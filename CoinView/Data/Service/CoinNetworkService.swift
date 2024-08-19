//
//  CoinNetworkService.swift
//  CoinView
//
//  Created by KsArT on 19.08.2024.
//

import Foundation

protocol CoinNetworkService {

    func loadData<T>(endpoint: CoinEndpoint, callback: @escaping (Result<T, Error>) -> Void) where T : Decodable
}
