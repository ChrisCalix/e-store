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
    
    func expect(_ sut: LocalFeedLoader, toCompleteWith expectedResult: Result<[FeedProduct], LocalFeedLoader.Error>, when action: () -> Void, file: StaticString = #filePath, line: UInt = #line) {
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


