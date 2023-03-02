//
//  LoadProductsfromLocalJSONFileUseTestCase.swift
//  e-storeTests
//
//  Created by Sonic on 1/3/23.
//

import XCTest
@testable import e_store

class LoadProductsfromLocalJSONFileUseTestCase: XCTestCase {
    
    func test_load_DoesNotFoundFileNameError() {
        let (sut, _) = makeSUT(fileName: "DoesNotExistFile")
        
        expect(sut, toCompleteWith: .failure(.notFound))
    }
    
    func test_load_DeliversInvalidDataFromFileNameWithInvalidJSON() {
        let (sut, _) = makeSUT(fileName: "InvalidJSON")

        expect(sut, toCompleteWith: .failure(.invalidData))
    }
    
    func test_load_deliversSuccessWithNoItemsFromFileNameWithEmptyJSONList() {
        let (sut, _) = makeSUT(fileName: "EmptyProducts")

        expect(sut, toCompleteWith: .success([]))
    }

    func test_load_deliversSuccessWithItemsFromFileNameWithEmptyJSONItems() {
        let (sut, _) = makeSUT()

        let item1 = makeProduct(id: "110579",
                                url: "https://product-images.ibotta.com/offer/dUxYcQPeq391-DiywFZF8g-normal.png",
                                name: "Scotch-Brite® Scrub Dots Non-Scratch Scrub Sponges",
                                description: "Any variety - 2 ct. pack or larger",
                                terms: "Rebate valid on Scotch-Brite® Scrub Dots Non-Scratch Scrub Sponges for any variety, 2 ct. pack or larger.",
                                currentValue: "$0.75 Cash Back")
        
        let item2 = makeProduct(id: "110580",
                                url: "https://product-images.ibotta.com/offer/OS0MnVcHXe7snozDC7nIiw-normal.png",
                                name: "Scotch-Brite® Scrub Dots Heavy Duty Scrub Sponges",
                                description: "Any variety - 2 ct. pack or larger",
                                terms: "Rebate valid on Scotch-Brite® Scrub Dots Heavy Duty Scrub Sponges for any variety, 2 ct. pack or larger.",
                                currentValue: "$0.75 Cash Back")

        expect(sut, toCompleteWith: .success([item1.model, item2.model]))
    }
    
    //MARK: Helpers
    
    func makeSUT(fileName: String = "Offers", file: StaticString = #filePath, line: UInt = #line) -> (sut: LocalFeedLoader, reader: JSONFileReader){
        let reader = JSONFileReader(bundle: Bundle(for: type(of: self)))
        let sut = LocalFeedLoader(fileName: fileName, reader: reader)
        return (sut, reader)
    }
    
    func makeProduct(id: String, url: String, name: String, description: String, terms: String, currentValue: String) -> (model: FeedProduct, json: [String: Any]) {
        let item = FeedProduct(id: id,
                               url: url,
                               name: name,
                               description: description,
                               terms: terms,
                               current_value: currentValue)
        
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
    
    func expect(_ sut: LocalFeedLoader, toCompleteWith expectedResult: Result<[FeedProduct], LocalFeedLoader.Error>, file: StaticString = #filePath, line: UInt = #line) {
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

          waitForExpectations(timeout: 0.1)
      }
}
