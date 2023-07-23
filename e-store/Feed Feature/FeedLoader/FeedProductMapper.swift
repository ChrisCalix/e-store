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
        return .success(
            root.map {
                ProductModel(
                    id: $0.id ?? "",
                    url: $0.url ?? "",
                    name: $0.name ?? "",
                    description: $0.description ?? "",
                    terms: $0.terms ?? "",
                    current_value: $0.current_value ?? ""
                )
            }
        )
    }
}
