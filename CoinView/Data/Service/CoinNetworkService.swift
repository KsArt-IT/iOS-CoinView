//
//  CoinNetworkService.swift
//  CoinView
//
//  Created by KsArT on 19.08.2024.
//

import Foundation

protocol CoinNetworkService {

    func loadData<T>(endpoint: CoinEndpoint, completion: @escaping (Result<T, any Error>) -> Void) where T : Decodable
    func loadData(url: String, completion: @escaping (Data) -> Void)
}
