//
//  LoadProductsfromLocalUseTestCase.swift
//  e-storeTests
//
//  Created by Sonic on 1/3/23.
//

import XCTest
@testable import e_store

class LoadProductsfromLocalUseTestCase: XCTestCase {
    
    func test_init_doesNotDataFromLocalJson() {
        let (_, reader) = makeSUT()
        
        XCTAssertTrue(reader.requestedFiles.isEmpty)
    }
    
    func test_load_twiceRequestDataFromFileTwice() {
        let fileName = "Offers.json"
        let (sut, reader) = makeSUT(fileName: fileName)
        
        sut.load { _ in }
        sut.load { _ in }
        
        XCTAssertEqual(reader.requestedFiles, [fileName, fileName])
    }
    
    func test_load_DoesNotFoundFileNameError() {
        let (sut, reader) = makeSUT()
        
        expect(sut, toCompleteWith: .failure(.notFound)) {
            let readerError = LocalFeedLoader.Error.notFound
            reader.complete(with: readerError)
        }
    }
    
    func test_load_DeliversInvalidDataFromFileNameWithInvalidJSON() {
        let (sut, reader) = makeSUT()
        
        expect(sut, toCompleteWith: .failure(.invalidData)) {
            let invalidJSON = Data("invalid JSON".utf8)
            reader.complete(data: invalidJSON)
        }
    }
    
    func test_load_deliversSuccessWithNoItemsFromFileNameWithEmptyJSONList() {
        let (sut, reader) = makeSUT()
        
        expect(sut, toCompleteWith: .success([])) {
            let json = makeProductsJSON([])
            reader.complete(data: json)
        }
    }
    
    func test_load_deliversSuccessWithItemsFromFileNameWithEmptyJSONItems() {
        let (sut, reader) = makeSUT()

        let item1 = makeProduct()
        let item2 = makeProduct()
        let item3 = makeProduct()
        
        expect(sut, toCompleteWith: .success([item1.model, item2.model, item3.model])) {
            let json = makeProductsJSON([item1.json, item2.json, item3.json])
            reader.complete(data: json)
        }
    }
}
