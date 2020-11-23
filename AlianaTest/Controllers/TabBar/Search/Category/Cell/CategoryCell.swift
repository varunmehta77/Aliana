//
//  CategoryCell.swift
//  AlianaTest
//
//  Created by Varun M on 16/11/20.
//

import UIKit

class CategoryCell: UITableViewCell {

    static let id = String.init(describing: CategoryCell.self)

    fileprivate var categoryCellVM: CategoryCellVM! {
        didSet {
            setupView()
        }
    }

    fileprivate var bgContentView = UIView()
    fileprivate var bgView = UIView()
    fileprivate var imgView = UIImageView()
    fileprivate var titleLabel = UILabel()
    fileprivate var dividerView = UIView()

    fileprivate var radius: CGFloat = 0
    fileprivate var corners: UIRectCorner = []

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        DispatchQueue.main.async {
            self.bgContentView.roundCorners(corners: self.corners, radius: self.radius)
        }
    }

    func configureView(categoryCellVM: CategoryCellVM) {
        self.categoryCellVM = categoryCellVM
    }

    private func setupView() {
        titleLabel.text = nil
        imgView.image = nil
        bgView.backgroundColor = UIColor.appBlueColor
        imgView.setBorder(color: UIColor.white, width: 2)
        if let title = categoryCellVM.title {
            titleLabel.text = title
        }
        if let color = categoryCellVM.bgColorCode {
            bgView.backgroundColor = UIColor(hex: color)
        }
        if let icon = categoryCellVM.imageName {
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

extension CategoryCell {

    private func setupUI() {
        setupBgContentView()
        setupBgView()
        setupImgView()
        setupTitleLabel()
        setupDividerView()
    }

    private func setupBgContentView() {
        contentView.addSubview(bgContentView)
        bgContentView.translatesAutoresizingMaskIntoConstraints = false
        bgContentView.backgroundColor = .white
        NSLayoutConstraint.activate(
            [
                bgContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
                bgContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
                bgContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
                bgContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            ]
        )
    }

    private func setupBgView() {
        bgContentView.addSubview(bgView)
        bgView.translatesAutoresizingMaskIntoConstraints = false
        bgView.setCornerRadius(radius: 40)
        NSLayoutConstraint.activate(
            [
                bgView.leadingAnchor.constraint(equalTo: bgContentView.leadingAnchor, constant: 32),
                bgView.trailingAnchor.constraint(equalTo: bgContentView.trailingAnchor, constant: -32),
                bgView.topAnchor.constraint(equalTo: bgContentView.topAnchor, constant: 16),
                bgView.bottomAnchor.constraint(equalTo: bgContentView.bottomAnchor, constant: -16),
                bgView.heightAnchor.constraint(equalToConstant: 80)
            ]
        )
    }

    private func setupImgView() {
        bgView.addSubview(imgView)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.setCornerRadius(radius: 24)
        imgView.contentMode = .center
        NSLayoutConstraint.activate(
            [
                imgView.centerYAnchor.constraint(equalTo: bgView.centerYAnchor),
                imgView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
                imgView.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 16),
                imgView.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -16),
                imgView.widthAnchor.constraint(equalTo: imgView.heightAnchor)
            ]
        )
    }

    private func setupTitleLabel() {
        bgView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.semiBold(18)
        titleLabel.textColor = UIColor.darkText
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        NSLayoutConstraint.activate(
            [
                titleLabel.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 16),
                titleLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
                titleLabel.topAnchor.constraint(equalTo: imgView.topAnchor),
                titleLabel.bottomAnchor.constraint(equalTo: imgView.bottomAnchor)
            ]
        )
    }

    private func setupDividerView() {
        bgContentView.addSubview(dividerView)
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = .lightGray
        NSLayoutConstraint.activate(
            [
                dividerView.leadingAnchor.constraint(equalTo: bgContentView.leadingAnchor),
                dividerView.trailingAnchor.constraint(equalTo: bgContentView.trailingAnchor),
                dividerView.bottomAnchor.constraint(equalTo: bgContentView.bottomAnchor),
                dividerView.heightAnchor.constraint(equalToConstant: 1)
            ]
        )
    }
}
