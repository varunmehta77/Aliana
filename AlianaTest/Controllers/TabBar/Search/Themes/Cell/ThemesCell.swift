//
//  ThemesCell.swift
//  AlianaTest
//
//  Created by Varun M on 16/11/20.
//

import UIKit

class ThemesCell: UICollectionViewCell {

    static let id = String(describing: ThemesCell.self)

    fileprivate var imgView = UIImageView()
    fileprivate var titleLabel = UILabel()

    fileprivate var themesCellVM: ThemesCellVM! {
        didSet {
            setupView()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()

        contentView.setCornerRadius(radius: 12)
        contentView.backgroundColor = UIColor.appBackgroundColor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureView(themesCellVM: ThemesCellVM) {
        self.themesCellVM = themesCellVM
    }

    private func setupView() {
        titleLabel.text = nil
        imgView.image = nil
        if let title = themesCellVM.title {
            titleLabel.text = title
        }
        if let icon = themesCellVM.imageName {
            imgView.image = UIImage(named: icon)
        }
    }
}

extension ThemesCell {

    private func setupUI() {
        setupImgView()
        setupTitleLabel()
    }

    private func setupImgView() {
        contentView.addSubview(imgView)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.clipsToBounds = true
        imgView.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate(
            [
                imgView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                imgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
                imgView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.6),
                imgView.heightAnchor.constraint(equalTo: imgView.widthAnchor)
            ]
        )
    }

    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.medium(16)
        titleLabel.textColor = UIColor.darkText
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.textAlignment = .center
        NSLayoutConstraint.activate(
            [
                titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                titleLabel.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: 10),
                titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
            ]
        )
    }
}
