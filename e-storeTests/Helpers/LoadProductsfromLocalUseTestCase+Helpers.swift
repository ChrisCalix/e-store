//
//  LoadProductsfromLocalUseTestCase+Helpers.swift
//  e-storeTests
//
//  Created by Sonic on 1/3/23.
//

import XCTest
@testable import e_store

extension LoadProductsfromLocalUseTestCase {
    
    func makeSUT(fileName: String = "Offers.json", file: StaticString = #filePath, line: UInt = #line) -> (sut: LocalFeedLoader, reader: FileReaderSpy){
        let reader = FileReaderSpy()
        let sut = LocalFeedLoader(fileName: fileName, reader: reader)
        return (sut, reader)
    }
    
    func makeProductsJSON(_ items: [[String: Any]]) -> Data {
        return try! JSONSerialization.data(withJSONObject: items)
    }
    
    func makeProduct() -> (model: ProductModel, json: [String: Any]) {
        let item = ProductModel(id: "1", url: "", name: "", description: "", terms: "", current_value: "")
        
        let json = [
            "id": item.id,
            "url": item.url,
            "name": item.name,
            "description": item.description,
            "terms": item.terms,
            "current_value": item.current_value
        ].compactMapValues { $0 }
        
        return (item, json)
    }
    
    func expect(_ sut: LocalFeedLoader, toCompleteWith expectedResult: Result<[ProductModel], LocalFeedLoader.Error>, when action: () -> Void, file: StaticString = #filePath, line: UInt = #line) {
        let exp = expectation(description: "Wait for load completion")

        sut.load { receivedResult in
            switch (receivedResult, expectedResult) {
            case let (.success(receivedItems), .success(expectedItems)):
                XCTAssertEqual(receivedItems, expectedItems, file: file, line: line)

            case let (.failure(receivedError as LocalFeedLoader.Error), .failure(expectedError)):
                XCTAssertEqual(receivedError, expectedError, file: file, line: line)

            default:
                XCTFail("Expected result \(expectedResult) got \(receivedResult) instead", file: file, line: line)
            }

            exp.fulfill()
        }

        action()

        waitForExpectations(timeout: 0.1)
    }
}
