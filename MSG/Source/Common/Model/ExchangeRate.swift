//
//  ExchangeRate.swift
//  MSG_Test
//
//  Created by 임준화 on 2022/05/13.
//

import UIKit

// MARK: - Info
struct Info: Decodable {
    let timestamp: Int
    let quote: Double
}

// MARK: - Query
struct Query: Decodable{
    let from: String
    let to: String
    let amount: Int
}
struct ExchangeRateItem: Decodable{
    let success: Bool
    let query: Query
    let info: Info
    let result: Double
}
