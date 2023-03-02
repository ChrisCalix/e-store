//
//  ProductsListViewControllerUseTestCase.swift
//  e-storeTests
//
//  Created by Sonic on 2/3/23.
//

import XCTest
@testable import e_store

class ProductsListViewControllerUseTestCase: XCTestCase {
    
    func test_viewDidLoad_renderViewWithNavigationBarTitle() {
        let sut = makeSUT()
        
        XCTAssertEqual(sut.navigationItem.title, "E-Store")
    }
    
    func test_viewDidLoad_renderViewwithCollectionViewItems() {
        let item = makeProduct(id: "110579",
                                url: "https://product-images.ibotta.com/offer/dUxYcQPeq391-DiywFZF8g-normal.png",
                                name: "Scotch-Brite® Scrub Dots Non-Scratch Scrub Sponges",
                                description: "Any variety - 2 ct. pack or larger",
                                terms: "Rebate valid on Scotch-Brite® Scrub Dots Non-Scratch Scrub Sponges for any variety, 2 ct. pack or larger.",
                                currentValue: "$0.75 Cash Back")
        
        let model = ProductModel(id: item.id, url: item.url, name: item.name, description: item.description, terms: item.terms, current_value: item.current_value)
        
        let sut = makeSUT()
        XCTAssertEqual(sut.collectionView.numberOfItems(inSection: 0), 0)
        XCTAssertEqual(makeSUT(products: [model]).collectionView.numberOfItems(inSection: 0), 1)
        XCTAssertEqual(makeSUT(products: [model, model]).collectionView.numberOfItems(inSection: 0), 2)
    }
    
    func test_viewDidLoad_renderViewWithCollectionViewItemDetail() {
        
        let item = makeProduct(id: "110579",
                                url: "https://product-images.ibotta.com/offer/dUxYcQPeq391-DiywFZF8g-normal.png",
                                name: "Scotch-Brite® Scrub Dots Non-Scratch Scrub Sponges",
                                description: "Any variety - 2 ct. pack or larger",
                                terms: "Rebate valid on Scotch-Brite® Scrub Dots Non-Scratch Scrub Sponges for any variety, 2 ct. pack or larger.",
                                currentValue: "$0.75 Cash Back")
        let model = ProductModel(id: item.id, url: item.url, name: item.name, description: item.description, terms: item.terms, current_value: item.current_value)
        
        let sut = makeSUT(products: [model])
        guard let cell = sut.collectionView.dataSource?.collectionView(sut.collectionView, cellForItemAt: IndexPath(item: 0, section: 0)) as? ProductsListCollectionViewCell else {
            XCTFail("Item not found")
            return
        }
        
        XCTAssertEqual(cell.nameLabel.text, item.name)
        XCTAssertEqual(cell.ammountLabel.text, item.current_value)
    }
    
    //MARK: Helpers
    
    func makeSUT(products: [ProductModel] = []) -> ProductsListViewController {
        let viewModel = ViewModelSpy(products: products)
        let sut = ProductsListViewController(viewModel: viewModel)
        sut.loadViewIfNeeded()
        return sut
    }
    
    func makeProduct(id: String, url: String, name: String, description: String, terms: String, currentValue: String) -> FeedProduct {
        let item = FeedProduct(id: id,
                               url: url,
                               name: name,
                               description: description,
                               terms: terms,
                               current_value: currentValue)
            
        return item
    }
    
    struct ViewModelSpy: ProductListViewModelExpected {
        private var products : Observable<[ProductModel]> = Observable([])
        private var productsSpy : [ProductModel]
        
        func getOffersProduct() {
            products.value = productsSpy
        }
        
        func getProduct(at indexPath: IndexPath) -> e_store.ProductModel? {
            if ((products.value?.indices.contains(indexPath.item)) == nil) {
                    return nil
            }
            return products.value?[indexPath.item]
        }
        
        func getNumberOfProducts() -> Int? {
            products.value?.count
        }
        
        init(products: [ProductModel]) {
            self.productsSpy = products
        }
        
    }
}
