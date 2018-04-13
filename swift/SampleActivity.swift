//  Created by Oleksandr Kharkov on 08.04.2018.
//  Copyright © 2018 Oleksandr Kharkov. All rights reserved.
//

import UIKit

class SampleViewController: UIViewController {

    @IBAction func sharePressed(_ sender: UIBarButtonItem) {
        let activity: SampleActivity = SampleActivity()
        let panel = UIActivityViewController(activityItems: [], applicationActivities: [activity])
        //panel.excludedActivityTypes = [.postToFacebook, .airDrop]

        /// arrow point for ipad
        panel.popoverPresentationController?.barButtonItem = sender
        //panel.popoverPresentationController?.sourceView = self.view
        //panel.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: 100, height: 100)

        present(panel, animated: true, completion: nil)
    }
}

class SampleActivity: UIActivity {
    let HIPImages = "com.activity.sample"
    
    override class var activityCategory: UIActivityCategory {
        return .action
    }
    
    override var activityType: UIActivityType? {
        return UIActivityType(HIPImages)
    }
    
    override var activityImage: UIImage? {
        get { return UIImage(named: "camera") }
    }
    
    override var activityTitle: String? {
        get { return "do it" }
    }
    
    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        return true
    }
    
    override func prepare(withActivityItems activityItems: [Any]) {
        print("activity prepare...")
    }
    
    override func perform() {
        print("activity perform!")
        activityDidFinish(true)
    }
}
