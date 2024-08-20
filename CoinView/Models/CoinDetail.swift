//
//  CoinDetail.swift
//  CoinView
//
//  Created by KsArT on 20.08.2024.
//

public struct CoinDetail {
    let id: String
    let name: String
    let symbol: String
    let rank: Int
    let isNew: Bool
    let isActive: Bool

    let description: String
    let firstDataAt: String

    let lastDataAt: String
    let message: String

    let tags: [String]
    let team: [String]
}
