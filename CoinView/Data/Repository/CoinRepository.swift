//
//  CoinRepository.swift
//  CoinView
//
//  Created by KsArT on 19.08.2024.
//

import Foundation

protocol CoinRepository: AnyObject {
    func fetchData(endpoint: CoinEndpoint, callback: @escaping (Result<[Coin], any Error>) -> Void)
}
