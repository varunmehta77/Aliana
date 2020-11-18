//
//  BaseVC.swift
//  AlianaTest
//
//  Created by Varun M on 16/11/20.
//

import UIKit

class BaseVC: UIViewController {

    override func loadView() {
        super.loadView()

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .appBackgroundColor
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon-menu"), style: .plain, target: self, action: #selector(menuTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon-notification"), style: .plain, target: self, action: #selector(notificationTapped))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: true)
        self.updateNavigationBarAppearance(tintColor: UIColor.black, barTintColor: UIColor.white, isTranslucent: true, textColor: UIColor.black)
    }

    @objc private func menuTapped() {

    }

    @objc private func notificationTapped() {

    }
}
