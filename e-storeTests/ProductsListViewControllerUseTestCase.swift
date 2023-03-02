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
        let sut = ProductsListViewController()
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.navigationItem.title, "E-Store")
    }
    
    func test_viewDidLoad_renderViewwithCollectionViewItems() {
        
        let item = makeProduct(id: "110579",
                                url: "https://product-images.ibotta.com/offer/dUxYcQPeq391-DiywFZF8g-normal.png",
                                name: "Scotch-Brite® Scrub Dots Non-Scratch Scrub Sponges",
                                description: "Any variety - 2 ct. pack or larger",
                                terms: "Rebate valid on Scotch-Brite® Scrub Dots Non-Scratch Scrub Sponges for any variety, 2 ct. pack or larger.",
                                currentValue: "$0.75 Cash Back")
        
        let sut = ProductsListViewController(products: [item, item])
        
        sut.loadViewIfNeeded()
        
        sut.collectionView.numberOfItems(inSection: 0)
        XCTAssertEqual(sut.collectionView.numberOfItems(inSection: 0), 2)
    }
    
    //MARK: Helpers
    
    func makeProduct(id: String, url: String, name: String, description: String, terms: String, currentValue: String) -> FeedProduct {
        let item = FeedProduct(id: id,
                               url: url,
                               name: name,
                               description: description,
                               terms: terms,
                               current_value: currentValue)
            
        return item
    }
    
}
