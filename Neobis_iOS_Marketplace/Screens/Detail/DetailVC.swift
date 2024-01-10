//
//  DetailVC.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 24/12/23.
//

import UIKit

class DetailViewController: UIViewController {

    let mainView = DetailView()
    var viewModel: DetailViewModelProtocol?
    var productImage: UIImage?
//    var peronalProduct: Bool?
    var id: Int?
    
    init(
        viewModel: DetailViewModelProtocol? = nil,
        productImage: UIImage? = nil,
//        isFavorite: Bool = false,
//        peronalProduct: Bool? = false, 
        id: Int? = nil) {

        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.productImage = productImage
//        self.peronalProduct = peronalProduct
        self.id = id
//        mainView.heartButton.tintColor = isFavorite ? .systemRed : .gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let personalProduct = peronalProduct, personalProduct {
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: mainView.changeButton)
//        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: mainView.backButton)
        viewModel?.delegate = self
        tabBarController?.tabBar.isHidden = true
        mainView.image.image = productImage
        addTargets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    
    @objc func backPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func likePressed() {
//        if mainView.heartButton.tintColor == .gray {
//            MainViewModel.likeProduct(id: viewModel?.mainDetailResponse?.id ?? 0)
//            mainView.likeAmount.text = String((Int(mainView.likeAmount.text ?? "0") ?? 0) + 1)
//            mainView.heartButton.updateLikeButton()
//        } else {
//            let customAlertController = CustomLikeAlert(id: viewModel?.detailResponse?.id, delegate: self)
//            customAlertController.modalPresentationStyle = .overFullScreen
//            present(customAlertController, animated: false)
//        }
    }
    
    @objc func changeProduct() {
//        navigationController?.pushViewController(ChangeProductViewController(changeProductProtocol: ChangeProductViewModel()), image: mainView.image.image, cost: 0, name: mainView.title.text,shortDescription: mainView.shortDescription.text ,longDescription: mainView.longDescription.text, id: id ?? 1), animated: true)
    }
    
    func addTargets() {
        mainView.backButton.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
//        mainView.heartButton.addTarget(self, action: #selector(likePressed), for: .touchUpInside)
        mainView.changeButton.addTarget(self, action: #selector(changeProduct), for: .touchUpInside)
    }

    override func loadView() {
        self.view = mainView
    }
}

extension DetailViewController: DetailDelegate {
    func didSucceed(response: DetailResponse) {
        
        guard let price = response.price,
              let name = response.name,
              let short_description = response.short_description,
              let description = response.description else {
            
            // Show an alert to notify the user about missing data
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Error", message: "Some data is missing.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            return
        }
        
        DispatchQueue.main.async {
            self.mainView.cost.text = price + " $"
            self.mainView.title.text = name
            self.mainView.shortDescription.text = short_description
            self.mainView.longDescription.text = description
        }
    }
}

//extension DetailViewController: CustomLikeAlertDelegate {
//    func removeLike() {
//        mainView.heartButton.updateLikeButton()
//        let num = (Int(mainView.likeAmount.text ?? "0") ?? 0) - 1
//        mainView.likeAmount.text = String(num < 0 ? 0 : num)
//    }
//}
