//
//  ProductListViewModel.swift
//  e-store
//
//  Created by Sonic on 2/3/23.
//

import Foundation

protocol ProductListViewModelExpected {
    func getOffersProduct()
    func getProduct(at indexPath: IndexPath ) -> ProductModel?
    func getNumberOfProducts() -> Int?
    func updateProduct(at indexPath: IndexPath)
}

struct ProductListViewModel : ProductListViewModelExpected {
    private let fileName = "Offers"
    private var products : Observable<[ProductModel]> = Observable([])
    
    func getOffersProduct() {
        let reader = JSONFileReader()
        let localFeedLoader = LocalFeedLoader(fileName: fileName, reader: reader)
        localFeedLoader.load { result in
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
    
    func updateProduct(at indexPath: IndexPath) {
        products.value?[indexPath.row].isFavoritte.toggle()
    }
    
    func getNumberOfProducts() -> Int? {
        products.value?.count
    }
}
