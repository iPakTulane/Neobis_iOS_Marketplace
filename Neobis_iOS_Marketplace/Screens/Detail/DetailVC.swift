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
    
    override func loadView() {
        self.view = mainView
    }
    
    var id: Int?
    
    init(
        viewModel: DetailViewModelProtocol? = nil,
        productImage: UIImage? = nil,
        id: Int? = nil) {

        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.productImage = productImage
        self.id = id
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: mainView.changeButton)
        
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
    
    @objc func changeProduct() {
        let vc = ChangeProductViewController(changeProductProtocol: ChangeProductViewModel(id: id ?? 0))
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func addTargets() {
        mainView.backButton.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
        mainView.changeButton.addTarget(self, action: #selector(changeProduct), for: .touchUpInside)
    }
}

// MARK: - EXTENSION
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
