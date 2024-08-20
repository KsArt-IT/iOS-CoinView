//
//  CoinRepository.swift
//  CoinView
//
//  Created by KsArT on 19.08.2024.
//

import Foundation

protocol CoinRepository: AnyObject {
    func fetchCoins(completion: @escaping (Result<[Coin], any Error>) -> Void)
    func fetchCoinDetail(id: String, completion: @escaping (Result<CoinDetail, any Error>) -> Void)
    func fetchCoinLogo(id: String, completion: @escaping (Data) -> Void)
}
