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
        let readerError = LocalFeedLoader.Error.notFound
        
        let exp = expectation(description: "wait for load completion")
        
        sut.load { result in
            switch result {
            case let .failure(receivedError as LocalFeedLoader.Error):
                XCTAssertEqual(receivedError, readerError)
            default:
                XCTFail("Error in completion method")
            }
            exp.fulfill()
        }
    
        reader.complete(with: readerError)
        
        waitForExpectations(timeout: 0.1)
    }
    
    func test_load_DeliversInvalidDataFromFileNameWithInvalidJSON() {
        let (sut, reader) = makeSUT()
        let readerError = LocalFeedLoader.Error.invalidData
        
        let exp = expectation(description: "wait for load completion")
        
        sut.load { result in
            switch result {
            case let .failure(receivedError as LocalFeedLoader.Error):
                XCTAssertEqual(receivedError, readerError)
            default:
                XCTFail("Error in completion method")
            }
            exp.fulfill()
        }
    
        let invalidJSON = Data("invalid JSON".utf8)
        reader.complete(data: invalidJSON)
        
        waitForExpectations(timeout: 0.1)
    }
    
    func test_load_deliversSuccessWithNoItemsFromFileNameWithEmptyJSONList() {
        let (sut, reader) = makeSUT()
        
        let exp = expectation(description: "wait for load completion")
        
        sut.load { result in
            switch result {
            case let .success(receivedData):
                XCTAssertTrue(receivedData.isEmpty)
            default:
                XCTFail("Error in completion method")
            }
            exp.fulfill()
        }
        reader.complete(data: makeProductsJSON([]))
        
        waitForExpectations(timeout: 0.1)
    }
    
    func test_load_deliversSuccessWithItemsFromFileNameWithEmptyJSONItems() {
        let (sut, reader) = makeSUT()

        let item = makeProduct()

        let exp = expectation(description: "wait for load completion")

        sut.load { result in
            switch result {
            case let .success(receivedData):
                XCTAssertEqual(receivedData, [item.model])
            default:
                XCTFail("Error in completion method")
            }
            exp.fulfill()
        }

        reader.complete(data: makeProductsJSON([item.json]))

        waitForExpectations(timeout: 0.1)
    }
    
    //MARK: Helpers

    func makeSUT(fileName: String = "Offers.json", file: StaticString = #filePath, line: UInt = #line) -> (sut: LocalFeedLoader, reader: FileReaderSpy){
        let reader = FileReaderSpy()
        let sut = LocalFeedLoader(fileName: fileName, reader: reader)
        return (sut, reader)
    }
    
    private func makeProductsJSON(_ items: [[String: Any]]) -> Data {
        return try! JSONSerialization.data(withJSONObject: items)
    }
    
    private func makeProduct() -> (model: FeedProduct, json: [String: Any]) {
            let item = FeedProduct(id: 1, url: "", name: "", description: "", terms: "", current_value: "")
            
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

    class FileReaderSpy: FileReader {
        private var messages = [(fileName: String, completion: (FileReader.Result) -> Void)]()
        
        var requestedFiles : [String] {
            return messages.map { $0.fileName }
        }
        
        func get(from fileName: String, completion: @escaping (Result<Data, Error>) -> Void) {
            messages.append((fileName, completion))
        }
        
        func complete(with error: Error, at index: Int = 0, file: StaticString = #filePath, line: UInt = #line) {
            guard messages.indices.contains(index) else {
               return XCTFail("Can't complete request naver made")
            }

            messages[index].completion(.failure(error))
        }
        
        func complete(data: Data, at index: Int = 0, file: StaticString = #filePath, line: UInt = #line) {
              guard messages.indices.contains(index) else {
                  return XCTFail("Can't complete request naver made")
              }
              
              messages[index].completion(.success(data))
          }
    }
}


