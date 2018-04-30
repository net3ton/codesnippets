import os
import sys
import plistlib

ENTITLEMENTS_BODY = """
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>com.apple.security.app-sandbox</key><true/>
</dict>
</plist>
"""

def make_pkg(pathToApp):
    appPath, appFileName = os.path.split(pathToApp)
    appName = os.path.splitext(appFileName)[0]

    pathToPkg = os.path.join(appPath, appName + ".pkg")
    pathToEntitlements = os.path.join(appPath, appName + ".entitlements")
    pathToPlist = os.path.join(pathToApp, "Contents/Info.plist")

    try:
        p = plistlib.readPlist(pathToPlist)
        p["LSApplicationCategoryType"] = "public.app-category.games"
        plistlib.writePlist(p, pathToPlist)
    except Exception as ex:
        print("ERROR: can't edit plist!")
        print(ex)
        return

    try:
        with open(pathToEntitlements, "w") as fent:
            fent.write(ENTITLEMENTS_BODY) 

        os.system("codesign -f -s \"3rd Party Mac Developer Application:\" --entitlements \"%s\" \"%s\" --deep" % (pathToEntitlements, pathToApp))
        os.system("productbuild --component \"%s\" /Applications --sign \"3rd Party Mac Developer Installer:\" --product \"%s\" \"%s\"" % (pathToApp, pathToPlist, pathToPkg))
    except Exception as ex:
        print(ex)
    finally:
        os.remove(pathToEntitlements)
        print("done.")


if __name__ == '__main__':
    if len(sys.argv) != 2:
        print("ERROR: need one param - path to .app!")
        sys.exit()

    make_pkg(sys.argv[1])
