//
//  LocalFeedLoader.swift
//  e-store
//
//  Created by Sonic on 1/3/23.
//

import Foundation

public class LocalFeedLoader: FeedLoader {
    
    private let fileName: String
    private let reader: FileReader
    
    public enum Error: Swift.Error {
        case invalidData
        case notFound
    }
    
    init(fileName: String, reader: FileReader) {
        self.fileName = fileName
        self.reader = reader
    }
    
    func load(completion: @escaping (FeedResult) -> Void) {
        reader.get(from: fileName) { result in
            switch result {
            case let .failure(error):
                completion(.failure(error))
            case let .success(data):
                completion(FeedMapper.validateAndMap(data))
            }
        }
    }
    
}
