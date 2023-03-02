//
//  FileReaderSpy.swift
//  e-storeTests
//
//  Created by Sonic on 1/3/23.
//

import XCTest
@testable import e_store

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
