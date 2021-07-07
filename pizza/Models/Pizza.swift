//
//  Pizza.swift
//  pizza
//
//  Created by William on 04/07/21.
//

import Foundation

struct Pizza: Codable {
    let id: String
    let name: String
    let imageUrl: String
    let rating: Double
    let priceP: Double
    let priceM: Double
    let priceG: Double
}
