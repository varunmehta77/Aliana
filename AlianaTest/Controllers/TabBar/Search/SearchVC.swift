//
//  SearchVC.swift
//  AlianaTest
//
//  Created by Varun M on 16/11/20.
//

import UIKit

class SearchVC: BaseVC {

    fileprivate var tabView = TabView()
    fileprivate var contentView = UIView()

    fileprivate var tabs: [TabType] = [.Category, .Themes, .Trending]
    private var selectedTab: TabType = .Category


    fileprivate lazy var tabsControllers: [UIViewController] = {
        return [CategoryVC(), ThemesVC(), TrendingVC()]
    }()

    fileprivate lazy var pageController: CarouselPageVC = {
        return CarouselPageVC(viewControllers: tabsControllers)
    }()

    override func loadView() {
        super.loadView()

        setupUI()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Explore"
    }
}

extension SearchVC {

    private func setupUI() {
        setupTabView()
        setupContentView()
    }

    private func setupTabView() {
        tabView = TabView.init(tabs: tabs, selectedTab: selectedTab)
        view.addSubview(tabView)
        tabView.translatesAutoresizingMaskIntoConstraints = false
        tabView.delegate = self
        tabView.clipsToBounds = true
        tabView.backgroundColor = .white
        NSLayoutConstraint.activate(
            [
                tabView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tabView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tabView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
                tabView.heightAnchor.constraint(equalToConstant: 32)
            ]
        )
    }

    private func setupContentView() {
        view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                contentView.topAnchor.constraint(equalTo: tabView.bottomAnchor, constant: 0),
            ]
        )

        pageController.view.frame = contentView.frame
        pageController.carouselDelegate = self
        addChild(pageController)
        contentView.addSubview(pageController.view)
        pageController.didMove(toParent: self)
    }
}

extension SearchVC: TabViewDelegate {
    func didTabSelectionUpdated(tab: TabType) {
        guard selectedTab != tab else {
            return
        }
        selectedTab = tab
        pageController.scrollToIndex(index: tab.rawValue)
    }
}

extension SearchVC: CarouselPageVCDelegate {
    func didCarouselIndexUpdated(index: Int) {
        let tab = TabType(rawValue: index) ?? selectedTab
        if selectedTab != tab {
            tabView.updateSelectedTabIndex(tabType: tab)
            selectedTab = tab
        }
    }
}
