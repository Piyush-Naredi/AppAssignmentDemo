//
//  ItemsListViewModel.swift
//  AppAssignmentDemo
//
//  Created by Piyush Naredi on 06/01/21.
//

import Foundation

///ItemsList View Model class
class ItemsListViewModel: NSObject {
    
    var showLoader: Bool = false {
        didSet {
            updateLoaderClosure?()
        }
    }
    
    var isResultSuccess: Bool = false {
        didSet {
            updateResultClosure?()
        }
    }
    
    var arrItems = [ItemsModel]()
    var errorMessage: String?
    
    var updateLoaderClosure: (() -> Void)?
    var updateResultClosure: (() -> Void)?
    
    
    func getItemsData() {
        self.showLoader = true
        NetworkManager.instance.callWebServiceAlamofire { [weak self] (result) in
            self?.showLoader = false
            switch result {
            case .success(let data):
                let arrItemsData = ItemsModel.getParsedItemsData(from: data)
                self?.arrItems = arrItemsData ?? []
                self?.isResultSuccess = true
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
                self?.isResultSuccess = false
            }
        }
    }
}
