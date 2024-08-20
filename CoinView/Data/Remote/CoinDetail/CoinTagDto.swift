//
//  CoinTagDTO.swift
//  CoinView
//
//  Created by KsArT on 20.08.2024.
//

import Foundation

struct CoinTagDto: Decodable {
    let coinCounter: Int
    let icoCounter: Int
    let id: String
    let name: String
}
