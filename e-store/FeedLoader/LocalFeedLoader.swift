//
//  LocalFeedLoader.swift
//  e-store
//
//  Created by Sonic on 1/3/23.
//

import Foundation

class LocalFeedLoader: FeedLoader {
    
    private let fileName: String
    private let reader: FileReader
    
    init(fileName: String, reader: FileReader) {
        self.fileName = fileName
        self.reader = reader
    }
    
    func load(completion: @escaping (FeedResult) -> Void) {

    }
}
