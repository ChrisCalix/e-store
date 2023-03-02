//
//  FeedMapper.swift
//  e-store
//
//  Created by Sonic on 1/3/23.
//

import Foundation

enum FeedMapper {
    static func validateAndMap(_ data: Data) -> LocalFeedLoader.FeedResult {
        guard let root = try? JSONDecoder().decode([FeedProduct].self, from: data) else {
            return .failure(LocalFeedLoader.Error.invalidData)
        }
        return .success(root.map(\.product))
    }
}
