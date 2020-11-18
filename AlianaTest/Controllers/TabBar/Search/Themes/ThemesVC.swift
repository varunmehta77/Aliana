//
//  ThemesVC.swift
//  AlianaTest
//
//  Created by Varun M on 16/11/20.
//

import UIKit

class ThemesVC: UIViewController {

    fileprivate var collectionView: UICollectionView!

    fileprivate var themes = [Theme]()

    override func loadView() {
        super.loadView()

        setupCollectionView()
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
                let fetchthemes = try JSONDecoder().decode([Theme].self, from: data)
                themes = fetchthemes
                collectionView.reloadData()
            } catch {
                showAlert(title: "", message: error.localizedDescription)
            }
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
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return themes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThemesCell.id, for: indexPath) as? ThemesCell else {
            return UICollectionViewCell()
        }
        cell.configureView(theme: themes[indexPath.row])

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
