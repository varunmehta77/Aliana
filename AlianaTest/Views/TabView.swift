//
//  TabView.swift
//  AlianaTest
//
//  Created by Varun M on 16/11/20.
//

import UIKit

enum TabType: Int {
    case Category
    case Themes
    case Trending

    func getTitle() -> String {
        var title: String = ""
        switch self {
        case .Category:
            title = "Category"
        case .Themes:
            title = "Themes"
        case .Trending:
            title = "Trending"
        }
        return title
    }
}

protocol TabViewDelegate: class {
    func didTabSelectionUpdated(tab: TabType)
}

class TabView: UIView {

    private var tabs = [UIButton]()
    private var indicatorView = UIView()
    private var counter: Int = 500

    private var indicatorLeadingConstraint = NSLayoutConstraint()
    private var indicatorTrailingConstraint = NSLayoutConstraint()

    weak var delegate: TabViewDelegate?

    private var selectedTabType: TabType = .Category
    private var padding: CGFloat = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(tabs: [TabType], selectedTab: TabType = .Category, isTabWidthOnText: Bool = true) {
        self.init()

        selectedTabType = selectedTab
        setupTabs(tabs: tabs, isTabWidthOnText: isTabWidthOnText)
        setupIndicatorView()
        updateIndicatorViewConstraints()
        updateButtonAppearance()
    }

    required init?(coder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }

    private func setupTabs(tabs: [TabType], isTabWidthOnText: Bool) {
        var previousView: UIView?
        for (index, tab) in tabs.enumerated() {
            let bgview = UIView()
            addSubview(bgview)
            bgview.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate(
                [
                    bgview.topAnchor.constraint(equalTo: topAnchor),
                    bgview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2)
                ]
            )

            var la: NSLayoutConstraint!
            if index == 0 {
                la = bgview.leadingAnchor.constraint(equalTo: leadingAnchor)
            } else if let pview = previousView {
                la = bgview.leadingAnchor.constraint(equalTo: pview.trailingAnchor)
                bgview.widthAnchor.constraint(equalTo: pview.widthAnchor).isActive = true
            }
            la.isActive = true

            if index == tabs.count - 1 || tabs.count == 1 {
                bgview.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            }

            let b = UIButton()
            bgview.addSubview(b)
            b.translatesAutoresizingMaskIntoConstraints = false
            b.tag = index + counter
            b.titleLabel?.font = UIFont.medium(16)
            b.setTitle(tab.getTitle(), for: .normal)
            b.setTitleColor(.appBlueColor, for: .normal)
            b.addTarget(self, action: #selector(self.actionSelect(sender:)), for: .touchUpInside)

            NSLayoutConstraint.activate(
                [
                    b.topAnchor.constraint(equalTo: topAnchor),
                    b.bottomAnchor.constraint(equalTo: bottomAnchor)
                ]
            )
            if isTabWidthOnText, let width = b.titleLabel?.getWidthFromText() {
                NSLayoutConstraint.activate(
                    [
                        b.centerXAnchor.constraint(equalTo: bgview.centerXAnchor),
                        b.widthAnchor.constraint(equalToConstant: width + 12)
                    ]
                )
                let bla = b.leadingAnchor.constraint(greaterThanOrEqualTo: bgview.leadingAnchor, constant: 4)
                bla.priority = UILayoutPriority.init(999)
                bla.isActive = true

                let bta = b.trailingAnchor.constraint(lessThanOrEqualTo: bgview.trailingAnchor, constant: -4)
                bta.priority = UILayoutPriority.init(999)
                bta.isActive = true
            } else {
                NSLayoutConstraint.activate(
                    [
                        b.leadingAnchor.constraint(equalTo: leadingAnchor),
                        b.trailingAnchor.constraint(equalTo: trailingAnchor),
                        b.topAnchor.constraint(equalTo: topAnchor),
                        b.bottomAnchor.constraint(equalTo: bottomAnchor)
                    ]
                )
            }

            if index != tabs.count - 1, tabs.count > 1 {
                let dividerView = UIView()
                bgview.addSubview(dividerView)
                dividerView.translatesAutoresizingMaskIntoConstraints = false
                dividerView.backgroundColor = UIColor.lightGray
                NSLayoutConstraint.activate(
                    [
                        dividerView.trailingAnchor.constraint(equalTo: bgview.trailingAnchor),
                        dividerView.centerYAnchor.constraint(equalTo: bgview.centerYAnchor),
                        dividerView.heightAnchor.constraint(equalToConstant: 10),
                        dividerView.widthAnchor.constraint(equalToConstant: 1),
                    ]
                )
            }

            previousView = bgview
            self.tabs.append(b)
        }
    }

    private func setupIndicatorView() {
        addSubview(indicatorView)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.backgroundColor = .appBlueColor
        indicatorView.layer.cornerRadius = 2.3
        indicatorView.layer.masksToBounds = true
        indicatorView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        indicatorView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        indicatorLeadingConstraint = indicatorView.leadingAnchor.constraint(equalTo: tabs[selectedTabType.rawValue].leadingAnchor, constant: 0)
        indicatorLeadingConstraint.isActive = true
        indicatorTrailingConstraint = indicatorView.trailingAnchor.constraint(equalTo: tabs[selectedTabType.rawValue].trailingAnchor, constant: 0)
        indicatorTrailingConstraint.isActive = true
    }
}

extension TabView {

    @objc private func actionSelect(sender: UIButton) {
        let selectedTab = TabType(rawValue: sender.tag - counter) ?? .Category
        didSelectedIndexUpdated(tabType: selectedTab)
        delegate?.didTabSelectionUpdated(tab: selectedTab)
    }

    func updateSelectedTabIndex(tabType: TabType) {
        didSelectedIndexUpdated(tabType: tabType)
    }

    private func didSelectedIndexUpdated(tabType: TabType) {
        selectedTabType = tabType
        updateButtonAppearance()
        updateIndicatorViewConstraints()
    }

    private func updateButtonAppearance() {
        for tab in tabs {
            tab.setTitleColor(UIColor.gray, for: .normal)
            if tab.tag - counter == selectedTabType.rawValue {
                tab.setTitleColor(UIColor.appBlueColor, for: .normal)
            }
        }
    }

    private func updateIndicatorViewConstraints() {
        let selectedButton = tabs[selectedTabType.rawValue]
        removeConstraint(indicatorLeadingConstraint)
        removeConstraint(indicatorTrailingConstraint)

        indicatorLeadingConstraint = indicatorView.leadingAnchor.constraint(lessThanOrEqualTo: selectedButton.leadingAnchor)
        indicatorLeadingConstraint.isActive = true

        indicatorTrailingConstraint = indicatorView.trailingAnchor.constraint(lessThanOrEqualTo: selectedButton.trailingAnchor)
        indicatorTrailingConstraint.isActive = true

        UIViewPropertyAnimator(duration: 0.3, dampingRatio: 0.7) {
            self.setNeedsLayout()
            self.updateConstraintsIfNeeded()
            self.layoutIfNeeded()
        }.startAnimation()
    }
}
