//
//  CharacterEndpoint.swift
//  CoinView
//
//  Created by KsArT on 19.08.2024.
//

import Foundation

enum CoinEndpoint {
    case coins
    case coin(id: Int)

    var url: URL? {
        switch self {
        case .coins:
            return URL(string: "\(Self.baseURL)/coins")
        case .coin(let id):
            return URL(string: "\(Self.baseURL)/coins/\(id)")
        }
    }

    private static let baseURL = "https://api.coinpaprika.com/v1"
}
