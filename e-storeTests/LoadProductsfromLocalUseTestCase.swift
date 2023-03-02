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
        let reader = FileReaderSpy()
        let _ = LocalFeedLoader(fileName: "Offers.json", reader: reader)
        
        XCTAssertTrue(reader.requestedFiles.isEmpty)
    }
    
    func test_load_onceRequestDataFromFile() {
        let fileName = "Offers.json"
        let reader = FileReaderSpy()
        let sut = LocalFeedLoader(fileName: fileName, reader: reader)
        
        sut.load { _ in }
        
        XCTAssertEqual(reader.requestedFiles, [fileName])
    }
}

//MARK: Helpers

class FileReaderSpy: FileReader {
    private var messages = [(fileName: String, completion: (FileReader.Result) -> Void)]()
    
    var requestedFiles : [String] {
        return messages.map { $0.fileName }
    }
    
    func get(from fileName: String, completion: @escaping (Result<Data, Error>) -> Void) {
        messages.append((fileName, completion))
    }
}
