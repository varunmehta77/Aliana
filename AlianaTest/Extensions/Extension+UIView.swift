//
//  Extension+UIView.swift
//  AlianaTest
//
//  Created by Varun M on 16/11/20.
//

import Foundation
import UIKit

extension UIView {
    func setCornerRadius(radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
    }



    func constraintsEqualToSuperView(commonConstant: CGFloat = 0, isSafeArea: Bool = false) {
        if let superview = self.superview {
            NSLayoutConstraint.activate(
                [
                    self.topAnchor.constraint(
                        equalTo: (isSafeArea ? superview.safeAreaLayoutGuide.topAnchor : superview.topAnchor), constant: commonConstant
                    ),
                    self.bottomAnchor.constraint(
                        equalTo: (isSafeArea ? superview.safeAreaLayoutGuide.bottomAnchor : superview.bottomAnchor), constant: -commonConstant
                    ),
                    self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: commonConstant),
                    self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -commonConstant)
                ]
            )
        }
    }

    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }

    func setBorder(color: UIColor, width: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }

    func addShadowToView(color: UIColor = UIColor.gray, cornerRadius: CGFloat, offset: CGSize = CGSize(width: 0, height: 0)) {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        self.clipsToBounds = false
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = offset
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = 5
    }
}
