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
}
