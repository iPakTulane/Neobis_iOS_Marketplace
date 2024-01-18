//
//  DetailVM.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 24/12/23.
//

import UIKit

protocol DetailDelegate {
    
    func didSucceed(response: DetailResponse)
    
}

protocol DetailViewModelProtocol {
    var id: Int? {get set}
    var detailResponse: DetailResponse? {get set}
    var delegate: DetailDelegate? {get set}
    func fetchProductData()
}

class DetailViewModel: DetailViewModelProtocol {
    
    var id: Int?
    var detailResponse: DetailResponse?
    var delegate: DetailDelegate?
    
    init(id: Int) {
        self.id = id
        fetchProductData()
    }
    
    func fetchProductData() {
        let url = "https://aibek-backender.org.kg/products/create-update-list/{id}/" + String(id ?? 0)
        
        guard let token = TokenManager.shared.accessToken else { return }
        
        let header = ["Authorization" : "Bearer \(token)", "Content-Type" : "application/json"]
        
        
        //        APIService.request(urlString: url, method: .get, headers: header) { (result: Result<ProductResponse, Error>)  in
        //            switch result {
        //            case .success(let data):
        //                self.detailResponse = data
        //                self.delegate?.didSucceed(response: data)
        //            case .failure(let error):
        //                print("Detail fail: \(error.localizedDescription)")
        
    }
}

