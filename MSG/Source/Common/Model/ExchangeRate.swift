//
//  ExchangeRate.swift
//  MSG_Test
//
//  Created by 임준화 on 2022/05/13.
//

import UIKit

struct ExchangeRateResponse: Codable{
    let response: ExchangeResponse
}

struct ExchangeResponse: Codable{
    let body: ExchangeBody
}

struct ExchangeBody: Codable{
    let items: [ExchangeRateItem]?
}
struct ExchangeRateItem: Codable {
    let success: Bool
    let timestamp: Int
    let source: String
    let quotes: [String: Double]
}
