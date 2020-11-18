//
//  TabBarVC.swift
//  AlianaTest
//
//  Created by Varun M on 16/11/20.
//

import Foundation
import UIKit

enum MainTab: Int {

    case home
    case search
    case stock
    case user
    case ideas

    func getIconImage() -> UIImage? {
        var text = ""
        switch self {
        case .home:
            text = "home"
        case .search:
            text = "search"
        case .stock:
            text = "stocks"
        case .user:
            text = "users"
        case .ideas:
            text = "ideas"
        }
        return UIImage(named: "icon-" + text)
    }

    func getSelectedIconImage() -> UIImage? {
        var text = ""
        switch self {
        case .home:
            text = "home"
        case .search:
            text = "search"
        case .stock:
            text = "stock"
        case .user:
            text = "user"
        case .ideas:
            text = "ideas"
        }

        return UIImage(named: "icon-" + text + "-selected")
    }

    func getMainController() -> UIViewController {
        var vc = UIViewController()
        switch self {
        case .search:
            vc = SearchVC()
        default:
            vc = CommonVC()
        }
        return vc
    }
}

class TabBarVC: UITabBarController {

    fileprivate var bgView = UIView()
    fileprivate let itemBgView = UIView()

    fileprivate var itemBgViewLeadingConstraint: NSLayoutConstraint!

    init(tabs: [MainTab]) {
        super.init(nibName: nil, bundle: nil)

        self.updateTabBar(tabs: tabs)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func loadView() {
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        setupBgView()
        setupItemBgView()

        DispatchQueue.main.async {
            self.bgView.addShadowToView(color: .darkGray, cornerRadius: 16, offset: CGSize(width: -1, height: 1))
            self.tabBar.roundCorners(corners: [.topLeft, .topRight], radius: 16)
        }

    }

    private func updateTabBar(tabs: [MainTab]) {
        var controllers = [UIViewController]()
        for tab in tabs {
            let vc = tab.getMainController()
            let nc = UINavigationController(rootViewController: vc)
            nc.tabBarItem.image = tab.getIconImage()
            nc.tabBarItem.title = nil
            nc.tabBarItem.imageInsets = UIEdgeInsets(top: 9, left: 0, bottom: -9, right: 0)
            controllers.append(nc)
            nc.tabBarItem.isEnabled = true
        }
        viewControllers = controllers
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let index = tabBar.items?.firstIndex(of: item) {
            updateItemBgViewConstraints(index: index)
        }
    }

    private func updateItemBgViewConstraints(index: Int) {
        let val = (tabBar.frame.width/5)*CGFloat(index)
        itemBgViewLeadingConstraint.constant = val

        UIViewPropertyAnimator(duration: 0.3, dampingRatio: 0.7) {
            self.tabBar.setNeedsLayout()
            self.tabBar.updateConstraintsIfNeeded()
            self.tabBar.layoutIfNeeded()
        }.startAnimation()
    }
}

extension TabBarVC {

    private func setupBgView() {
        view.addSubview(bgView)
        bgView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                bgView.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor, constant: 0),
                bgView.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor, constant: 0),
                bgView.topAnchor.constraint(equalTo: tabBar.topAnchor),
                bgView.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor),
            ]
        )
        bgView.backgroundColor = .white
        view.bringSubviewToFront(tabBar)
    }

    private func setupItemBgView() {
        tabBar.addSubview(itemBgView)
        itemBgView.translatesAutoresizingMaskIntoConstraints = false
        itemBgView.backgroundColor = UIColor.appBlueColor
        NSLayoutConstraint.activate(
            [
                itemBgView.topAnchor.constraint(equalTo: tabBar.topAnchor),
                itemBgView.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor),
                itemBgView.widthAnchor.constraint(equalTo: tabBar.widthAnchor, multiplier: 0.2),
            ]
        )
        itemBgViewLeadingConstraint = itemBgView.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor)
        itemBgViewLeadingConstraint.isActive = true
        DispatchQueue.main.async {
            self.itemBgView.roundCorners(corners: [.topLeft, .topRight], radius: 12)
        }
    }
}
