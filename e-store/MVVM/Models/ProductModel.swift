//
//  ProductModel.swift
//  e-store
//
//  Created by Sonic on 2/3/23.
//

import Foundation

struct ProductModel: Equatable {
    
    let id: String
    let url: String
    let name: String
    let description: String
    let terms: String
    let current_value: String
    
    var isFavoritte: Bool = false
}
