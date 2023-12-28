//
//  ChangeProductVC.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 24/12/23.
//

import Foundation
import UIKit
import SnapKit

class ChangeProductViewController: UIViewController {
        
    let mainView = ChangeProductView()
    var changeProductProtocol: ChangeProductViewModelProtocol!
    var id: Int = 0
    
    // MARK: - MAIN VIEW SETUP
    override func loadView() {
        view = mainView
    }

    // MARK: - INIT
    init(changeProductProtocol: ChangeProductViewModelProtocol!) {
        self.changeProductProtocol = changeProductProtocol
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
    }

    func addTargets() {
        mainView.addButton.addTarget(self, action: #selector(setPic), for: .touchUpInside)

        let cancelButton = UIBarButtonItem(image: UIImage(named: "cancel")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(cancelPressed))
        self.navigationItem.leftBarButtonItem = cancelButton
        
        let finishButton = UIBarButtonItem(image: UIImage(named: "finish")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(finishPressed))
        self.navigationItem.rightBarButtonItem = finishButton
    }
    
    // MARK: - ACTION BUTTONS
    @objc func cancelPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func finishPressed() {
        guard !mainView.images.isEmpty else { return }
        guard let title =  mainView.nameField.text else { return }
        guard let price = mainView.priceField.text else { return }
        guard let shortDescription = mainView.descriptionOne.text else { return }
        guard let longDescription = mainView.descriptionTwo.text else { return }
        
        changeProductProtocol.changeProduct(images: mainView.images, title: title, price: price, shortDescription: shortDescription, fullDescription: longDescription)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func setPic() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
}

// MARK: - EXTENSION
extension ChangeProductViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            
            mainView.addImage(image)
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
}
