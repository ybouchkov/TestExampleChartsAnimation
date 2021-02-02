//
//  TestViewController.swift
//  TestExampleChartsAnimation
//
//  Created by Yani Buchkov on 1.02.21.
//

import UIKit

class TestViewController: UIViewController {
    
    @IBOutlet private weak var pageViewControllerHolderView: UIView!
    @IBOutlet private weak var pageViewControllerHolderViewHeighConstraint: NSLayoutConstraint!
    @IBOutlet private weak var legendViewHeighConstraint: NSLayoutConstraint!
    @IBOutlet private weak var legendView: LegendView!
    
    private lazy var pageViewController: UIPageViewController = {
        return UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageViewController()
    }
    
    @IBAction func applyFirstAnimation(_ sender: UIButton) {
        UIView.transition(with: pageViewControllerHolderView,
                          duration: 1.5,
                          options: .transitionCrossDissolve, animations: { [weak self] in
                            self?.pageViewControllerHolderView.alpha = 0.3
                            self?.legendView.alpha = 0.3
                          }, completion: { _ in
                            self.pageViewControllerHolderView.alpha = 0
                            self.legendView.alpha = 0
                          })
        
    }
    
    @IBAction func applySecondAnimation(_ sender: UIButton) {
    }
    
    private func setupPageViewController() {
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        pageViewController.view.frame = .zero // frame
        
        // Show view controller with initial page - zero page
        let pageViewController = getPageFor(index: 0)
        guard let initialPageController = pageViewController else {
            return
        }
        self.pageViewController.setViewControllers([initialPageController], direction: .forward, animated: true, completion: nil)
        self.addChild(self.pageViewController)
        
        // Add to holder view
        self.pageViewControllerHolderView.addSubview(self.pageViewController.view)
        self.pageViewController.didMove(toParent: self)
        
        //Pin to super view - (holder view)
        self.pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        self.pageViewController.view.topAnchor.constraint(equalTo: self.pageViewControllerHolderView.topAnchor).isActive = true
        self.pageViewController.view.leftAnchor.constraint(equalTo: self.pageViewControllerHolderView.leftAnchor).isActive = true
        self.pageViewController.view.bottomAnchor.constraint(equalTo: self.pageViewControllerHolderView.bottomAnchor).isActive = true
        self.pageViewController.view.rightAnchor.constraint(equalTo: self.pageViewControllerHolderView.rightAnchor).isActive = true
    }
    
    //Helper method to create view controllers for page view controller
    //for specified index
    func getPageFor(index: Int) -> PageViewController? {
        guard  let pageController  = self.storyboard?.instantiateViewController(identifier: "PageViewController") as? PageViewController else { return nil }
        pageController.didShowLegendView = { [weak self] in
            self?.legendView.isHidden = true
            self?.legendViewHeighConstraint.constant = 0
        }
        pageController.didHideLegendView = { [weak self] in
            self?.legendView.isHidden = false
            self?.legendViewHeighConstraint.constant = 30.0
        }
        pageController.pageIndex = index
        pageController.didMoveToNextPageViewController = { [weak self] in
            guard let strongSelf = self else {
                return
            }
            strongSelf.pageViewController.goToNextPage()
        }
        pageController.didMoveToPreviousPageViewController = { [weak self] in
            guard let strongSelf = self else {
                return
            }
            strongSelf.pageViewController.goToPreviousPage()
        }
        
        if pageController.pieChartMode == .collapsed {
            legendView.isHidden = true
            legendViewHeighConstraint.constant = 0
            pageViewControllerHolderViewHeighConstraint.constant = 60.0
        } else {
            legendView.isHidden = false
            legendViewHeighConstraint.constant = 30.0
            pageViewControllerHolderViewHeighConstraint.constant = 350.0
        }
        
        return pageController
    }
}

extension TestViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let beforePage = viewController as? PageViewController else { return nil }
        let beforePageIndex = beforePage.pageIndex
        //since it is before we need to go back the index
        let newIndex = beforePageIndex - 1
        if newIndex < 0 { return nil }
        return getPageFor(index: newIndex)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let afterPage = viewController as? PageViewController else { return nil }
        let afterPageIndex = afterPage.pageIndex
        //since it is after we need to go forword
        let newIndex = afterPageIndex + 1
        if newIndex <= 1 {
            return getPageFor(index: newIndex)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
    }
}
