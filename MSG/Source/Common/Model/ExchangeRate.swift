//
//  ExchangeRate.swift
//  MSG_Test
//
//  Created by 임준화 on 2022/05/13.
//

import UIKit

// MARK: - Info
struct ExchangeRateItemResponse: Codable{
    let items: [ExchangeRateItem]?
}
struct Info: Codable {
    let timestamp: Int
    let quote: Double
}

// MARK: - Query
struct Query: Codable {
    let from: String
    let to: String
    let amount: Int
}
struct ExchangeRateItem: Codable {
    let success: Bool
    let query: Query
    let info: Info
    let result: Double
}
