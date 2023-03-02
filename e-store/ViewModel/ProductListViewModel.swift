//
//  ProductListViewModel.swift
//  e-store
//
//  Created by Sonic on 2/3/23.
//

import Foundation

class ProductListViewModel {
    let fileName = "Offers"
    var products : Observable<[ProductModel]> = Observable([])
    
    func getOffersProduct() {
        let reader = JSONFileReader()
        let localFeedLoader = LocalFeedLoader(fileName: fileName, reader: reader)
        localFeedLoader.load { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(receivedProducts):
                self.products.value = receivedProducts
            case .failure(_):
                //MARK: make empty state
                break
            }
        }
    }
    
    func getProduct(at indexPath: IndexPath ) -> ProductModel? {
        if ((products.value?.indices.contains(indexPath.item)) == nil) {
                return nil
        }
        return products.value?[indexPath.item]
    }
}
