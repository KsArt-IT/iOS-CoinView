//
//  CoinDto.swift
//  CoinView
//
//  Created by KsArT on 19.08.2024.
//

struct CoinDto: Decodable {
    let id: String
    let isActive: Bool
    let isNew: Bool
    let name: String
    let rank: Int
    let symbol: String
    let type: String
}

extension CoinDto {
    
    func mapToDomain() -> Coin {
        Coin(id: self.id, isActive: self.isActive, name: self.name, rank: self.rank, symbol: self.symbol)
    }
}
