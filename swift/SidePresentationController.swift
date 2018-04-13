//
//  ActionPresentationController.swift
//  picstore
//
//  Created by Oleksandr Kharkov on 11.04.2018.
//  Copyright © 2018 Oleksandr Kharkov. All rights reserved.
//

import UIKit

enum EPresentationDirection {
    case left
    case top
    case right
    case bottom
}

class SidePresentationController: UIPresentationController, UIAdaptivePresentationControllerDelegate {
    private var chromeView: UIView = UIView()
    private var presentationDirection: EPresentationDirection = .left
    private var presentationPart: Float = 0.4
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        chromeView.backgroundColor = UIColor(white: 0.0, alpha: 0.4)
        chromeView.alpha = 0.0
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(onChromeTapped))
        chromeView.addGestureRecognizer(tap)
    }
    
    @objc func onChromeTapped(gesture: UIGestureRecognizer) {
        if gesture.state == .ended {
            presentingViewController.dismiss(animated: true, completion: nil)
        }
    }
    
    func setPart(direction: EPresentationDirection, part: Float)
    {
        self.presentationDirection = direction
        self.presentationPart = part
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        var presentedFrame = CGRect.zero
        presentedFrame.size = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerView!.bounds.size)
        
        switch presentationDirection {
        case .right:
            presentedFrame.origin.x = containerView!.bounds.size.width - presentedFrame.size.width
        case .bottom:
            presentedFrame.origin.y = containerView!.bounds.size.height - presentedFrame.size.height
        default:
            presentedFrame.origin = .zero
        }
        
        return presentedFrame
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        if presentationDirection == .left || presentationDirection == .right {
            return CGSize(width: parentSize.width * CGFloat(presentationPart), height: parentSize.height)
        }

        return CGSize(width: parentSize.width, height: parentSize.height * CGFloat(presentationPart))
    }
    
    override func presentationTransitionWillBegin() {
        chromeView.alpha = 0.0
        chromeView.frame = (containerView?.bounds)!
        
        containerView?.insertSubview(chromeView, at: 0)
        
        guard let transition = presentedViewController.transitionCoordinator else {
            chromeView.alpha = 1.0
            return
        }
        
        transition.animate(alongsideTransition: { _ in
            self.chromeView.alpha = 1.0
        })
    }

    override func dismissalTransitionWillBegin() {
        guard let transition = presentedViewController.transitionCoordinator else {
            chromeView.alpha = 0.0
            return
        }
        
        transition.animate(alongsideTransition: { _ in
            self.chromeView.alpha = 0.0
        })
    }
    
    override func containerViewWillLayoutSubviews() {
        chromeView.frame = containerView!.bounds
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
}

class SideAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    private var isPresentation: Bool = false
    private var presentationDirection: EPresentationDirection = .left
    
    init(isPresentation: Bool, direction: EPresentationDirection) {
        super.init()
        self.isPresentation = isPresentation
        self.presentationDirection = direction
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let key: UITransitionContextViewControllerKey = isPresentation ? .to : .from
        let topcontroller = transitionContext.viewController(forKey: key)!
        
        if isPresentation {
            transitionContext.containerView.addSubview(topcontroller.view)
        }

        let presentedFrame = transitionContext.finalFrame(for: topcontroller)
        var dismissedFrame = presentedFrame
        switch presentationDirection {
        case .left:
            dismissedFrame.origin.x = -presentedFrame.width
        case .top:
            dismissedFrame.origin.y = -presentedFrame.height
        case .right:
            dismissedFrame.origin.x = transitionContext.containerView.frame.size.width
        case .bottom:
            dismissedFrame.origin.y = transitionContext.containerView.frame.size.height
        }
        
        let initFrame = isPresentation ? dismissedFrame : presentedFrame
        let finalFrame = isPresentation ? presentedFrame : dismissedFrame
        let duration = transitionDuration(using: transitionContext)
        
        topcontroller.view.frame = initFrame

        UIView.animate(withDuration: duration, animations: {
            topcontroller.view.frame = finalFrame
        }, completion: { (finished) in
            transitionContext.completeTransition(finished)
        })
    }
}

class SideTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    private var presentationDirection: EPresentationDirection = .left
    private var presentationPart: Float = 0.5
    
    init(direction: EPresentationDirection, part: Float) {
        super.init()
        self.presentationDirection = direction
        self.presentationPart = part
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let controller = SidePresentationController(presentedViewController: presented, presenting: presenting)
        controller.setPart(direction: presentationDirection, part: presentationPart)
        return controller
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SideAnimatedTransitioning(isPresentation: true, direction: presentationDirection)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SideAnimatedTransitioning(isPresentation: false, direction: presentationDirection)
    }
}

/*
// Example of use

let sideTransitionDelegate = SideTransitioningDelegate(direction: .left, part: 0.4)

@IBAction func buttonPressed(_ sender: UIBarButtonItem) {
    
    let sboard = UIStoryboard(name: "Main", bundle: nil) as UIStoryboard
    let settings = sboard.instantiateViewController(withIdentifier: "settings-controller") as UIViewController
    settings.transitioningDelegate = sideTransitionDelegate
    settings.modalPresentationStyle = .custom
    present(settings, animated: true, completion: nil)
}
*/
