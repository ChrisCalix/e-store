//
//  FeedProduct.swift
//  e-store
//
//  Created by Sonic on 1/3/23.
//

import Foundation

import Foundation

struct FeedProduct: Codable, Equatable {
    let id: String?
    let url: String?
    let name: String?
    let description: String?
    let terms: String?
    let current_value: String?
}
