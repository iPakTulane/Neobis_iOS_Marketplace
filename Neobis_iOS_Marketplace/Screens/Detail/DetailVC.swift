//
//  DetailVC.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 24/12/23.
//

import UIKit

class DetailViewController: UIViewController {

    lazy var mainView = DetailView()
    var mainViewModel: DetailViewModelProtocol?
    var mainImage: UIImage?
    var mainID: Int?
    
    override func loadView() {
        self.view = mainView
    }
    
    init(viewModel: DetailViewModelProtocol?, image: UIImage?, id: Int? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.mainViewModel = viewModel
        self.mainImage = image
        self.mainID = id
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: mainView.changeButton)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: mainView.backButton)
        mainViewModel?.delegate = self
        tabBarController?.tabBar.isHidden = true
        mainView.image.image = mainImage
        addTargets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    
    @objc func backPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func changeProduct() {
        let vc = ChangeProductViewController(viewModel: ChangeProductViewModel(id: mainID ?? 0))
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
