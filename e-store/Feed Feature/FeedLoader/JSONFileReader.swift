//
//  JSONFileReader.swift
//  e-store
//
//  Created by Sonic on 1/3/23.
//

import Foundation

class JSONFileReader: FileReader {
    
    let bundle: Bundle
    
    init(bundle: Bundle = Bundle.main) {
        self.bundle = bundle
    }
    
    func get(from fileName: String, completion: @escaping (Result<Data, Error>) -> Void) {
        
        guard let bundlePath = bundle.path(forResource: fileName, ofType: "json"),
            let data = try? String(contentsOfFile: bundlePath).data(using: .utf8)  else {
            completion(.failure(LocalFeedLoader.Error.notFound))
            return
        }

        completion(.success(data))
    }
}
