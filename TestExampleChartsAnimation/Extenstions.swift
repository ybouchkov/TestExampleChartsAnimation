//
//  Extenstions.swift
//  TestExampleChartsAnimation
//
//  Created by Yani Buchkov on 1.02.21.
//

import UIKit

extension UIViewController {
    func add(asChildViewController viewController: UIViewController, conteinerView: UIView) {
        // Add Child View Controller
        addChild(viewController)
        
        // Add Child View as Subview
        conteinerView.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = conteinerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParent: self)
        
        conteinerView.sendSubviewToBack(viewController.view)
    }
    
    func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParent()
    }
}

extension UIPageViewController {
    func goToNextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        if let currentViewController = viewControllers?[0] {
            if let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentViewController) {
                setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)
            }
        }
    }
    
    func goToPreviousPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        if let currentViewController = viewControllers?[0] {
            if let previousPage = dataSource?.pageViewController(self, viewControllerBefore: currentViewController){
                setViewControllers([previousPage], direction: .reverse, animated: true, completion: completion)
            }
        }
    }
}

extension UIView {
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
}

extension UIView {
    
    func fadeIn(duration: TimeInterval = 0.8, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in }) {
        self.alpha = 0.0
        
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.isHidden = false
            self.alpha = 1.0
        }, completion: completion)
    }
    
    func fadeOut(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in }) {
        self.alpha = 1.0
        
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }) { (completed) in
            self.isHidden = true
            completion(true)
        }
    }
}

extension UITableView {
    
    func registerCellWithReusableIdentifier<T: UITableViewCell >(_ cellType: T.Type) {
        let name = String(describing: cellType)
        let nib = UINib(nibName: name, bundle: nil)
        self.register(nib, forCellReuseIdentifier: name)
    }
    
    func registerCellsWithReusableIdentifiers<T: UITableViewCell>(_ cellTypes: [T.Type]) {
        for cellType in cellTypes {
            let name = String(describing: cellType)
            let nib = UINib(nibName: name, bundle: nil)
            self.register(nib, forCellReuseIdentifier: name)
        }
    }
    
    func registerHeader<T: UITableViewHeaderFooterView>(_ headerType: T.Type) {
        let name = String(describing: headerType)
        let nib = UINib(nibName: name, bundle: nil)
        self.register(nib, forHeaderFooterViewReuseIdentifier: name)
    }
    
    /// Reusable cell identifier is equal to cell type name
    func dequeueReusableCell<T: UITableViewCell>(cellType: T.Type, indexPath: IndexPath? = nil) -> T? {
        let identifier = String(describing: cellType)
        
        if let indexPath = indexPath, let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T {
            return cell
        } else if let cell = dequeueReusableCell(withIdentifier: identifier) as? T {
            return cell
        }
        
        return nil
    }
    
    func dequeueHeader<T: UITableViewHeaderFooterView>(_ headerType: T.Type) -> T {
        let name = String(describing: headerType)
        guard let cell = dequeueReusableHeaderFooterView(withIdentifier: name) as? T else {
            fatalError("Could not dequeue cell with identifier: \(name)")
        }
        return cell
    }
    
    // Default delay time = 0.5 seconds
    // Pass delay time interval, as a parameter argument
    func reloadDataAfterDelay(delayTime: TimeInterval) {
        self.perform(#selector(self.reloadData), with: nil, afterDelay: delayTime)
    }
}

