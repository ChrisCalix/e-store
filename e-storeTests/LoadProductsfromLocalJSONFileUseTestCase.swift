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
    
    //MARK: Helpers
    
    func makeSUT(fileName: String = "Offers", file: StaticString = #filePath, line: UInt = #line) -> (sut: LocalFeedLoader, reader: JSONFileReader){
        let reader = JSONFileReader(bundle: Bundle(for: type(of: self)))
        let sut = LocalFeedLoader(fileName: fileName, reader: reader)
        return (sut, reader)
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
