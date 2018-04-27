import os
import shutil
from PIL import Image

SIZES = {
    (1024,  "icon_512x512@2x.png"),
    (512,   "icon_512x512.png"),
    (512,   "icon_256x256@2x.png"),
    (256,   "icon_256x256.png"),
    (256,   "icon_128x128@2x.png"),
    (128,   "icon_128x128.png"),
    (64,    "icon_32x32@2x.png"),
    (32,    "icon_32x32.png"),
    (32,    "icon_16x16@2x.png"),
    (16,    "icon_16x16.png")
}

ICON_FOLDER = "icon.iconset"

if os.path.exists(ICON_FOLDER):
    shutil.rmtree(ICON_FOLDER)
os.makedirs(ICON_FOLDER)

img = Image.open("icon.png")
for size, name in SIZES:
    icon = img.resize((size, size), Image.ANTIALIAS)
    icon.save(os.path.join(ICON_FOLDER, name))

os.system("iconutil --convert icns " + ICON_FOLDER)
