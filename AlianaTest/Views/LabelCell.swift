//
//  LabelCell.swift
//  AlianaTest
//
//  Created by Varun M on 16/11/20.
//

import UIKit

class LabelCell: UITableViewCell {

    static let id = String.init(describing: LabelCell.self)

    fileprivate var titleLabel = UILabel()
    fileprivate var labelLeadingConstraint: NSLayoutConstraint!
    fileprivate var labelTopConstraint: NSLayoutConstraint!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupLabel()
    }

    required init?(coder aDecoder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }

    func set(textAlignment: NSTextAlignment) {
        titleLabel.textAlignment = textAlignment
    }

    func configureView(text: String?) {
        titleLabel.text = nil
        if let txt = text {
            titleLabel.text = txt
        }
    }

    func configureView(attributedText: NSAttributedString, textAlignment: NSTextAlignment = .left) {
        titleLabel.text = nil
        titleLabel.textAlignment = textAlignment
        titleLabel.attributedText = attributedText
    }

    func setFont(font: UIFont) {
        titleLabel.font = font
    }

    func updateLabelTopLeadingConstraint(top: CGFloat? = nil, leading: CGFloat? = nil) {
        if let topc = top {
            labelTopConstraint.constant = topc
        }
        if let leadingc = leading {
            labelLeadingConstraint.constant = leadingc
        }
    }

    func setTextColor(color: UIColor) {
        titleLabel.textColor = color
    }
}

extension LabelCell {

    private func setupLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.font = UIFont.medium(16)
        titleLabel.textColor = UIColor.darkText
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                titleLabel.trailingAnchor.constraint(
                    equalTo: contentView.trailingAnchor,
                    constant: -16
                ),
                titleLabel.heightAnchor.constraint(
                    greaterThanOrEqualToConstant: 28
                )
            ]
        )
        labelLeadingConstraint = titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12)
        labelLeadingConstraint.isActive = true
        labelTopConstraint = titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8)
        labelTopConstraint.isActive = true

        let ba = titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ba.priority = UILayoutPriority(rawValue: 999)
        ba.isActive = true
    }
}

