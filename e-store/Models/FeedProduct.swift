//
//  FeedProduct.swift
//  e-store
//
//  Created by Sonic on 1/3/23.
//

import Foundation

struct FeedProduct: Decodable, Equatable {
    
    let id: Int
    let url: String
    let name: String
    let description: String
    let terms: String
    let current_value: String
}
