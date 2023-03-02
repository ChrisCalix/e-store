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
    
    //MARK: Helpers

    func makeSUT(fileName: String = "Offers.json", file: StaticString = #filePath, line: UInt = #line) -> (sut: LocalFeedLoader, reader: FileReaderSpy){
        let reader = FileReaderSpy()
        let sut = LocalFeedLoader(fileName: fileName, reader: reader)
        return (sut, reader)
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
    }
}


