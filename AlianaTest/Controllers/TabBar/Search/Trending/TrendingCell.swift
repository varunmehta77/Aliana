//
//  TrendingCell.swift
//  AlianaTest
//
//  Created by Varun M on 16/11/20.
//

import UIKit

class TrendingCell: UITableViewCell {

    static let id = String.init(describing: TrendingCell.self)

    fileprivate var bgView = UIView()
    fileprivate var imgView = UIImageView()
    fileprivate var titleLabel = UILabel()
    fileprivate var subtitleLabel = UILabel()
    fileprivate var dividerView = UIView()
    fileprivate var percentLabel = UILabel()

    fileprivate var radius: CGFloat = 0
    fileprivate var corners: UIRectCorner = []

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()

        contentView.backgroundColor = .clear
        backgroundColor = .clear
        bgView.backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        DispatchQueue.main.async {
            self.bgView.roundCorners(corners: self.corners, radius: self.radius)
        }
    }

    func configureView(trending: Trending) {
        titleLabel.text = nil
        subtitleLabel.text = nil
        imgView.image = nil
        percentLabel.backgroundColor = UIColor.lightGray
        percentLabel.text = nil
        if let text = trending.title {
            titleLabel.text = text
        }
        if let text = trending.subTitle {
            subtitleLabel.text = text
        }
        if let value = trending.percentChange {
            percentLabel.text = (value > 0) ? "+" + String(value) : String(value)
            if value > 0 {
                percentLabel.backgroundColor = UIColor.appBackgroundGreenColor
            } else {
                percentLabel.backgroundColor = UIColor.appBackgroundRedColor
            }
        }
        if let icon = trending.icon {
            imgView.image = UIImage(named: icon)
        }
    }

    func setCornerRadiusForBgView(corners: UIRectCorner, radius: CGFloat) {
        self.corners = corners
        self.radius = radius
        layoutSubviews()
    }

    func setBottomBorderColor(color: UIColor) {
        dividerView.backgroundColor = color
    }
}

extension TrendingCell {

    private func setupUI() {
        setupBgView()
        setupImgView()
        setupPercentLabel()
        setupTitleLabel()
        setupSubTitleLabel()
        setupDividerView()
    }

    private func setupBgView() {
        contentView.addSubview(bgView)
        bgView.translatesAutoresizingMaskIntoConstraints = false
        bgView.backgroundColor = .white
        NSLayoutConstraint.activate(
            [
                bgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
                bgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
                bgView.topAnchor.constraint(equalTo: contentView.topAnchor),
                bgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            ]
        )
    }

    private func setupImgView() {
        bgView.addSubview(imgView)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.setCornerRadius(radius: 24)
        imgView.backgroundColor = UIColor.appBackgroundColor
        NSLayoutConstraint.activate(
            [
                imgView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
                imgView.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 16),
                imgView.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -16),
                imgView.widthAnchor.constraint(equalTo: imgView.heightAnchor),
                imgView.heightAnchor.constraint(equalToConstant: 48)
            ]
        )
    }

    private func setupPercentLabel() {
        bgView.addSubview(percentLabel)
        percentLabel.translatesAutoresizingMaskIntoConstraints = false
        percentLabel.font = UIFont.medium(14)
        percentLabel.textColor = UIColor.white
        percentLabel.textAlignment = .center
        percentLabel.numberOfLines = 1
        percentLabel.minimumScaleFactor = 0.5
        percentLabel.adjustsFontSizeToFitWidth = true
        percentLabel.contentMode = .center
        percentLabel.setCornerRadius(radius: 11)
        NSLayoutConstraint.activate(
            [
                percentLabel.centerYAnchor.constraint(equalTo: bgView.centerYAnchor),
                percentLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -12),
                percentLabel.widthAnchor.constraint(equalToConstant: 75),
                percentLabel.heightAnchor.constraint(equalToConstant: 22)
            ]
        )
    }

    private func setupTitleLabel() {
        bgView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.semiBold(16)
        titleLabel.textColor = UIColor.darkText
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        NSLayoutConstraint.activate(
            [
                titleLabel.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 16),
                titleLabel.trailingAnchor.constraint(equalTo: percentLabel.leadingAnchor, constant: -12),
                titleLabel.topAnchor.constraint(equalTo: imgView.topAnchor)
            ]
        )
    }

    private func setupSubTitleLabel() {
        bgView.addSubview(subtitleLabel)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.font = UIFont.medium(14)
        subtitleLabel.textColor = UIColor.lightGray
        subtitleLabel.numberOfLines = 0
        subtitleLabel.lineBreakMode = .byWordWrapping
        NSLayoutConstraint.activate(
            [
                subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
                subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
                subtitleLabel.bottomAnchor.constraint(equalTo: imgView.bottomAnchor),
                subtitleLabel.heightAnchor.constraint(equalToConstant: 18)
            ]
        )
    }

    private func setupDividerView() {
        bgView.addSubview(dividerView)
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = .lightGray
        NSLayoutConstraint.activate(
            [
                dividerView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor),
                dividerView.trailingAnchor.constraint(equalTo: bgView.trailingAnchor),
                dividerView.bottomAnchor.constraint(equalTo: bgView.bottomAnchor),
                dividerView.heightAnchor.constraint(equalToConstant: 1)
            ]
        )
    }
}
