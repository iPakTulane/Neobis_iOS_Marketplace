//
//  HomeVC.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 24/12/23.
//

import Foundation
import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    let mainView = HomeView()
    var mainViewModel: HomeProtocol!
    
//    var products: [ProductResponse] = []
    
    // MARK: - INIT
    override func loadView() {
        view = mainView
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.reloadData()
    }
    
    init(viewModel: HomeProtocol!) {
        super.init(nibName: nil, bundle: nil)
        self.mainViewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainViewModel?.getData()
        mainView.collectionView.reloadData()
        addDelegates()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mainViewModel?.getData()
        mainView.collectionView.reloadData()
        tabBarController?.tabBar.isHidden = false
    }

    func addDelegates() {
        mainViewModel?.delegate = self
        mainView.collectionView.delegate = self
    }
    
    func setupCollectionView() {
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
        mainView.collectionView.register(HomeCellView.self, forCellWithReuseIdentifier: HomeCellView.identifier)
    }

}

// MARK: - EXTENSION
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if let viewModel = mainViewModel {
//            return viewModel.products?.count ?? 0
//        }
//        return 0
        if let viewModel = mainViewModel {
            let count = viewModel.products?.count ?? 0
            print("Number of items: \(count)")
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCellView.identifier, for: indexPath) as! HomeCellView
        if let products = mainViewModel?.products {
            cell.configureCell(with: products[indexPath.row])
            cell.delegate = self
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 165, height: 184)
    }
}

extension HomeViewController: HomeCellDelegate {
    
    func goToDetail(id: Int, image: UIImage) {
        let vc = DetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension HomeViewController: HomeDelegate {
    
    func didSucceed(withData data: [ProductResponse]) {
        print("Home succeeded with data: \(data)")
        
        DispatchQueue.main.async {
            if !data.isEmpty  {
                print("Not Empty")
                self.mainView.emptyLabel.isHidden = true
                self.mainView.boxImage.isHidden = true
                self.mainView.collectionView.isHidden = false
                self.mainView.collectionView.reloadData()
            } else {
                print("Empty")
                self.mainView.emptyLabel.isHidden = false
                self.mainView.boxImage.isHidden = false
                self.mainView.collectionView.isHidden = true
            }
        }
    }
        
    func didFail(withError error: Error) {
        print("Home failed with error: \(error)")
        mainView.boxImage.isHidden = false
        mainView.emptyLabel.isHidden = false
        mainView.collectionView.isHidden = true
    }
    
}


