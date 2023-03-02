//
//  FeedLoader.swift
//  e-store
//
//  Created by Sonic on 1/3/23.
//

import Foundation

protocol FeedLoader {
    typealias FeedResult = Swift.Result<[ProductModel], Swift.Error>
    
    func load(completion: @escaping (FeedResult) -> Void)
}
