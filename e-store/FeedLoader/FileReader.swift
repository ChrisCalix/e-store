//
//  FileReader.swift
//  e-store
//
//  Created by Sonic on 1/3/23.
//

import Foundation

protocol FileReader {
    typealias Result = Swift.Result<Data, Error>
    
    func get(from fileName: String, completion: @escaping (FileReader.Result) -> Void)
}
