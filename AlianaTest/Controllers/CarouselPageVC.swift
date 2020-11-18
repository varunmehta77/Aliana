//
//  CarouselPageVC.swift
//  AlianaTest
//
//  Created by Varun M on 16/11/20.
//

import UIKit
import Foundation

protocol CarouselPageVCDelegate: class {
    func didCarouselIndexUpdated(index: Int)
}

class CarouselPageVC: UIPageViewController {

    fileprivate var controllers: [UIViewController] = []
    fileprivate var currentIndex: Int = 0 {
        didSet {
            self.carouselDelegate?.didCarouselIndexUpdated(index: self.currentIndex)
        }
    }

    weak var carouselDelegate: CarouselPageVCDelegate?

    fileprivate var currentFrame: CGRect?

    convenience init(viewControllers: [UIViewController]) {
        self.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        controllers = viewControllers
    }

    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey: Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation, options: options)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        if let firstViewController = controllers.first {
            setViewController(controller: firstViewController)
            currentIndex = 0
        }
    }

    func setControllers(viewControllers: [UIViewController]) {
        controllers = viewControllers
        if let firstViewController = controllers.first {
            setViewController(controller: firstViewController)
            currentIndex = 0
        }
    }

    private func setViewController(controller: UIViewController, isForward: Bool = true) {
        DispatchQueue.main.async {
            self.setViewControllers([controller], direction: (isForward ? .forward : .reverse), animated: true, completion: nil)
        }
    }

    func scrollToIndex(index: Int) {
        if index < controllers.count {
            let isForward: Bool = currentIndex < index
            setViewController(controller: controllers[index], isForward: isForward)
            currentIndex = index
        }
    }

    func appendController(controller: UIViewController) {
        if !controllers.contains(controller) {
            controllers.append(controller)
            setViewControllers([controllers[currentIndex]], direction: .forward, animated: false, completion: nil)
        }
    }
}

extension CarouselPageVC: UIPageViewControllerDataSource {

    func pageViewController(_: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentVCIndex = controllers.firstIndex(of: viewController) else {
            return nil
        }
        let nextVCIndex = currentVCIndex + 1
        currentIndex = currentVCIndex
        guard controllers.count != nextVCIndex else {
            return nil
        }
        guard controllers.count > nextVCIndex else {
            return nil
        }
        return controllers[nextVCIndex]
    }

    func pageViewController(_: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentVCIndex = controllers.firstIndex(of: viewController) else {
            return nil
        }
        let previousVCIndex = currentVCIndex - 1
        currentIndex = currentVCIndex
        guard previousVCIndex >= 0 else {
            return nil
        }
        guard controllers.count > previousVCIndex else {
            return nil
        }
        return controllers[previousVCIndex]
    }
}

extension CarouselPageVC: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let firstVC = viewControllers?.first,
            let index = controllers.firstIndex(of: firstVC) {
            currentIndex = index
        }
    }
}

