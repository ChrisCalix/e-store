//
//  ProductListViewModel.swift
//  e-store
//
//  Created by Sonic on 2/3/23.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

protocol ProductListViewModelExpected {
    
    var products: BehaviorRelay<[ProductsSection]> { get }
    func getOffersProduct()
    
//    func getProduct(at indexPath: IndexPath ) -> ProductModel?
//    func getNumberOfProducts() -> Int?
//    func updateProduct(at indexPath: IndexPath)
}

typealias ProductsSection = SectionModel<String, ProductModel>

class ProductListViewModel : ProductListViewModelExpected {
    
    private let fileName = "Offers"
    var products : BehaviorRelay<[ProductsSection]> = BehaviorRelay(value: [])
    
    func getOffersProduct() {
        let reader = JSONFileReader()
        let localFeedLoader = LocalFeedLoader(fileName: fileName, reader: reader)
        localFeedLoader.load { result in
            switch result {
            case let .success(receivedProducts):
                self.products = BehaviorRelay(value: [
                    ProductsSection(model: "List of products", items: receivedProducts.map({
                        ProductModel.product($0)
                    }))
                ])
            case .failure(_):
                //MARK: make empty state
                print("error fail")
                break
            }
        }
    }
    
//    func getProduct(at indexPath: IndexPath ) -> ProductModel? {
//        if ((products.value?.indices.contains(indexPath.item)) == nil) {
//                return nil
//        }
//        return products.value?[indexPath.item]
//    }
//
//    func updateProduct(at indexPath: IndexPath) {
//        products.value?[indexPath.row].isFavoritte.toggle()
//    }
//
//    func getNumberOfProducts() -> Int? {
//        products.value?.count
//    }
}

enum ProductModel {
    case product(Product)
}
