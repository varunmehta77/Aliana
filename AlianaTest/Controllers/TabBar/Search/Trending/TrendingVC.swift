//
//  TrendingVC.swift
//  AlianaTest
//
//  Created by Varun M on 16/11/20.
//

import UIKit

class TrendingVC: UIViewController {

    fileprivate var tableView = UITableView()

    fileprivate var trendingResponse = [TrendingResponse]()

    override func loadView() {
        super.loadView()
        setupUI()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .appBackgroundColor
        fetchData()
    }

    private func fetchData() {
        if let data = FileHelper.getJSON(contoller: self) {
            do {
                let fetchresponse = try JSONDecoder().decode([TrendingResponse].self, from: data)
                trendingResponse = fetchresponse
                tableView.reloadData()
            } catch {
                showAlert(title: "", message: error.localizedDescription)
            }
        }
    }
}

extension TrendingVC {

    private func setupUI() {
        setupTableView()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.constraintsEqualToSuperView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.appBackgroundColor
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.tableFooterView = UIView()
        tableView.scrollsToTop = true
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(TrendingCell.self, forCellReuseIdentifier: TrendingCell.id)
    }
}

extension TrendingVC: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return trendingResponse.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trendingResponse[section].trendings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendingCell.id, for: indexPath) as? TrendingCell else {
            return UITableViewCell()
        }
        cell.configureView(trending: trendingResponse[indexPath.section].trendings[indexPath.row])
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

extension TrendingVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let hview = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 40))
        hview.backgroundColor = UIColor.clear

        let bgview = UIView()
        hview.addSubview(bgview)
        bgview.translatesAutoresizingMaskIntoConstraints = false
        bgview.backgroundColor = .white
        DispatchQueue.main.async {
            bgview.roundCorners(corners: [], radius: 0)
            if section != 0 {
                bgview.roundCorners(corners: [.topLeft, .topRight], radius: 10)
            }
        }
        NSLayoutConstraint.activate(
            [
                bgview.leadingAnchor.constraint(equalTo: hview.leadingAnchor, constant: 4),
                bgview.trailingAnchor.constraint(equalTo: hview.trailingAnchor, constant: -4),
                bgview.topAnchor.constraint(equalTo: hview.topAnchor),
                bgview.bottomAnchor.constraint(equalTo: hview.bottomAnchor)
            ]
        )

        let label = UILabel()
        bgview.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = UIFont.medium(16)
        label.textAlignment = .left
        label.text = trendingResponse[section].title ?? ""
        NSLayoutConstraint.activate(
            [
                label.leadingAnchor.constraint(equalTo: bgview.leadingAnchor, constant: 16),
                label.trailingAnchor.constraint(equalTo: bgview.trailingAnchor, constant: -16),
                label.topAnchor.constraint(equalTo: bgview.topAnchor),
                label.bottomAnchor.constraint(equalTo: bgview.bottomAnchor)
            ]
        )

        return hview
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 6
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let fview = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 6))
        fview.backgroundColor = UIColor.clear

        return fview
    }
}
