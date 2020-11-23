//
//  CategoryVC.swift
//  AlianaTest
//
//  Created by Varun M on 16/11/20.
//

import UIKit

class CategoryVC: UIViewController {

    fileprivate var tableView = UITableView()

    fileprivate var categoryVM = CategoryVM()

    override func loadView() {
        super.loadView()
        setupTableView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .appBackgroundColor
        categoryVM.fetchData { (success, error) in
            if let error = error, error.count > 0 {
                self.showAlert(title: "", message: error)
                return
            }
            self.tableView.reloadData()
        }
    }
}

extension CategoryVC {

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.constraintsEqualToSuperView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.tableFooterView = UIView()
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.id)
    }
}

extension CategoryVC: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return categoryVM.getNumberOfSectionInTableView()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryVM.numberOfRowsInTableView()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.id, for: indexPath) as? CategoryCell else {
            return UITableViewCell()
        }
        cell.configureView(categoryCellVM: categoryVM.getCategoryVM(atIndex: indexPath.row))
        cell.selectionStyle = .none
        cell.setCornerRadiusForBgView(corners: [], radius: 0)
        cell.setBottomBorderColor(color: UIColor.lightGray)
        if tableView.numberOfRows(inSection: indexPath.section)-1 == indexPath.row {
            cell.setCornerRadiusForBgView(corners: [.bottomLeft, .bottomRight], radius: 8)
            cell.setBottomBorderColor(color: UIColor.clear)
        }

        return cell
    }
}

extension CategoryVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
