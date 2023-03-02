//
//  FeedProduct.swift
//  e-store
//
//  Created by Sonic on 1/3/23.
//

import Foundation

struct FeedProduct: Decodable, Equatable {
    
    let id: String
    let url: String
    let name: String
    let description: String
    let terms: String
    let current_value: String
    
    enum CodingKeys: CodingKey {
        case id
        case url
        case name
        case description
        case terms
        case current_value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        self.url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        self.terms = try container.decodeIfPresent(String.self, forKey: .terms) ?? ""
        self.current_value = try container.decodeIfPresent(String.self, forKey: .current_value) ?? ""
    }
    
    init(id: String, url: String, name: String, description: String, terms: String, current_value: String) {
        self.id = id
        self.url = url
        self.name = name
        self.description = description
        self.terms = terms
        self.current_value = current_value
    }
}
