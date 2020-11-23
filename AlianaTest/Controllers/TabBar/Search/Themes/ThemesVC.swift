//
//  ThemesVC.swift
//  AlianaTest
//
//  Created by Varun M on 16/11/20.
//

import UIKit

class ThemesVC: UIViewController {

    fileprivate var collectionView: UICollectionView!

    fileprivate var themesVM = ThemesVM()

    override func loadView() {
        super.loadView()

        setupCollectionView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .appBackgroundColor
        themesVM.fetchData { (success, error) in
            if let error = error, error.count > 0 {
                self.showAlert(title: "", message: error)
                return
            }
            self.collectionView.reloadData()
        }
    }
}

extension ThemesVC {

    private func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ThemesCell.self, forCellWithReuseIdentifier: ThemesCell.id)
        collectionView.constraintsEqualToSuperView()
    }
}

extension ThemesVC: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return themesVM.getNumberOfSectionInTableView()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return themesVM.numberOfRowsInTableView()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThemesCell.id, for: indexPath) as? ThemesCell else {
            return UICollectionViewCell()
        }
        cell.configureView(themesCellVM: themesVM.getThemeCellVM(atIndex: indexPath.row))

        return cell
    }
}

extension ThemesVC: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension ThemesVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let val = (collectionView.frame.width-(16*3))/2
        return CGSize(width: val, height: val)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset: CGFloat = 16
        return UIEdgeInsets.init(top: inset, left: inset, bottom: inset, right: inset)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}
