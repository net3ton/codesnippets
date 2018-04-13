//  Created by Oleksandr Kharkov on 13.04.2018.
//  Copyright © 2018 Oleksandr Kharkov. All rights reserved.
//

import UIKit

class PopoverViewController: UIViewController {
    let popoverDelegate = SamplePopoverDelegate()
    
    @IBAction func alertPressed(_ sender: UIBarButtonItem) {
         let alert = UIAlertController(title: "Title", message: "Message", preferredStyle: .actionSheet);

         alert.addAction(UIAlertAction(title: "Action!", style: .default, handler: { (action) in
            print("Action begins!");
         }))
         alert.addAction(UIAlertAction(title: "Remove", style: .destructive, handler: { (action) in
            print("Remove");
         }))
         alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            print("Cancel");
         }))

         /// arrow point for ipad
         let popalert = alert.popoverPresentationController
         //popalert?.sourceView = self.view
         //popalert?.sourceRect = CGRect(x: 0, y: 0, width: 100, height: 100)
         popalert?.barButtonItem = sender

         present(alert, animated: true, completion: nil)
    }

    @IBAction func popupPressed(_ sender: UIBarButtonItem) {
        let sboard = UIStoryboard(name: "Main", bundle: nil) as UIStoryboard
        let popview = sboard.instantiateViewController(withIdentifier: "some-controller") as UIViewController
        popview.modalPresentationStyle = .popover
        popview.popoverPresentationController?.delegate = popoverDelegate

        /// arrow point for ipad
        popview.popoverPresentationController?.barButtonItem = sender
        //popview.popoverPresentationController?.permittedArrowDirections = .any
        //popview.popoverPresentationController?.sourceView = self.view
        //popview.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: 100, height: 100)

        present(popview, animated: true, completion: nil)
    }
}


class SamplePopoverDelegate: NSObject, UIPopoverPresentationControllerDelegate {
    var parentController: UIViewController?

    // to show with popup on iphone
    //func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
    //    return .none
    //}

    func presentationController(_ controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        parentController = controller.presentingViewController
        
        let navcontroller = UINavigationController(rootViewController: controller.presentedViewController)
        let btnDone = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(cancel))
        navcontroller.topViewController?.navigationItem.rightBarButtonItem = btnDone
        return navcontroller
    }

    @objc func cancel() {
        parentController?.dismiss(animated: true, completion: nil)
    }
}
