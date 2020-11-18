//
//  Extension+UIViewController.swift
//  AlianaTest
//
//  Created by Varun M on 16/11/20.
//

import Foundation
import UIKit

extension UIViewController {

    func updateNavigationBarAppearance(tintColor: UIColor, barTintColor: UIColor, isTranslucent: Bool = true, textColor: UIColor = UIColor.white, shadowImage: UIImage = UIImage()) {
        if let nc = self.navigationController {
            let navigationBar = nc.navigationBar
            let titleTextAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: textColor]
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.backgroundColor = barTintColor
            navBarAppearance.titleTextAttributes = titleTextAttributes
            navBarAppearance.shadowImage = nil
            navBarAppearance.shadowColor = nil
            navigationBar.scrollEdgeAppearance = navBarAppearance
            navigationBar.standardAppearance = navBarAppearance
            navigationBar.tintColor = tintColor
            navigationBar.barTintColor = barTintColor
            navigationBar.titleTextAttributes = titleTextAttributes
        }
    }

    func showAlert(title: String?, message: String?, withActions actions: [UIAlertAction] = []) {
        if title?.count ?? 0 <= 0, message?.count ?? 0 <= 0, actions.count <= 0 {
            return
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if actions.count > 0 {
          actions.forEach { alert.addAction($0) }
        } else {
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        }
        DispatchQueue.main.async { [weak self] in
          self?.present(alert, animated: true, completion: nil)
        }
    }
}
