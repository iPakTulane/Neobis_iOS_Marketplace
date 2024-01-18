//
//  ProductVC.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 24/12/23.
//

import Foundation
import UIKit
import SnapKit

class ProductViewController: UIViewController {
    
    lazy var mainView = ProductView()
    
    var mainViewModel: ProductProtocol!
    
    var blurEffectView: UIVisualEffectView?
    
    
    //    var products: [ProductResponse] = []
    
    let popUp: PopUpView = {
        let view = PopUpView()
        view.isHidden = true
        return view
    }()
    
    // MARK: - INIT
    override func loadView() {
        view = mainView
    }
    
    init(viewModel: ProductProtocol!) {
        self.mainViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationView()
        setupCollectionView()
        setupPopupView()
        addTapGesture()
        addDelegates()
        fetchData()
    }
    
    // To hide tab bar
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    // To start network request
    override func viewDidAppear(_ animated: Bool) {
        fetchData()
    }
    
    func fetchData() {
        mainViewModel?.fetchData()
        mainView.collectionView.reloadData()
    }
    
    func setupNavigationView() {
        title = "My products"
        let backButton = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backPressed))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    func setupCollectionView() {
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
        mainView.collectionView.register(ProductCellView.self, forCellWithReuseIdentifier: "ProductCell")
    }
    
    func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    func addDelegates() {
        mainViewModel?.delegate = self
    }
    
    @objc func backPressed() {
        dismiss(animated: true)
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    // MARK: - BLURING
    func unblurMainView() {
        blurEffectView?.removeFromSuperview()
        blurEffectView = nil
    }
    
    func blurMainView() {
        let blurEffect = UIBlurEffect(style: .regular)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = view.bounds
        view.addSubview(blurEffectView!)
        view.bringSubviewToFront(popUp) // Ensure the popUp is above the blurred view
    }
    
    // MARK: - POPUP
    func setupPopupView() {
        view.addSubview(popUp)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        let touchPoint = gesture.location(in: view)
        if !popUp.frame.contains(touchPoint) {
            popUp.isHidden = true
            unblurMainView()
        }
    }
    
}

// MARK: - COLLECTION VIEW DELEGATE

extension ProductViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let viewModel = mainViewModel {
            return viewModel.products?.count ?? 0
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCellView
        
        guard let product = mainViewModel.products?[indexPath.item] else {
            return cell
        }
        
        cell.productNameLabel.text = product.name
        cell.priceLabel.text = product.price
        
        if let photoURLString = product.photos?.first?.photo,
           let imageURL = URL(string: photoURLString) {
            
            // Download and set product image asynchronously
            downloadImage(from: imageURL) { image in
                DispatchQueue.main.async {
                    cell.productImageView.image = image ?? UIImage(named: "defaultImage")
                }
            }
        } else {
            cell.productImageView.image = UIImage(named: "defaultImage")
        }
        
        return cell
    }
    
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
               let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }.resume()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = 161
        let cellHeight = 184
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////

// MARK: - CELL DELEGATE
extension ProductViewController: ProductCellDelegate {
    
    func popupDidAppear(id: Int) {
        popUp.isHidden = false
        blurMainView()
    }
    
    func goToDetail(id: Int, image: UIImage) {
        let vc = DetailViewController(viewModel: DetailViewModel(id: id), image: image)
        navigationController?.pushViewController(vc, animated: true)
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////

// MARK: - POPUP DELEGATE
extension ProductViewController: ProductPopupDelegate {
    
    func goToChangeProductWith(id: Int, image: UIImage) {
        let vc = DetailViewController(viewModel: DetailViewModel(id: id), image: image)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func deleteProductWith(id: Int) {
        mainViewModel.deleteData(withID: id)
    }
    
}

////////////////////////////////////////////////////////////////////////////////////////////////////////

// MARK: - VIEW MODEL DELEGATE
extension ProductViewController: ProductDelegate {
    
    func didSucceed() {
        DispatchQueue.main.async {
            
            self.mainView.collectionView.reloadData()
            
            guard let data = self.mainViewModel?.products else { return }
            
            if data.isEmpty {
                self.mainView.collectionView.isHidden = true
                self.mainView.emptyLabel.isHidden = false
                self.mainView.boxImage.isHidden = false
            } else {
                self.mainView.collectionView.isHidden = false
                self.mainView.emptyLabel.isHidden = true
                self.mainView.boxImage.isHidden = true
            }
        }
    }
    
    func didFail(withError error: Error) {
        print("Product failed with error: \(error.localizedDescription)")

        self.mainView.collectionView.reloadData()

        DispatchQueue.main.async {
            self.mainView.boxImage.isHidden = false
            self.mainView.emptyLabel.isHidden = false
            self.mainView.collectionView.isHidden = true
        }
    }
}
