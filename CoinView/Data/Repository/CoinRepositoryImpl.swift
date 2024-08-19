//
//  CoinRepositoryImpl.swift
//  CoinView
//
//  Created by KsArT on 19.08.2024.
//

import Foundation

final class CoinRepositoryImpl: CoinRepository {

    private let service: CoinNetworkService

    init(service: CoinNetworkService) {
        self.service = service
    }

    func fetchData(endpoint: CoinEndpoint, callback: @escaping (Result<[Coin], Error>) -> Void) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.service.loadData(endpoint: endpoint) { (result: Result<[CoinDto], Error>) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let coinDTOs):
                        let coins = coinDTOs.map { $0.toCoin() }
                        callback(.success(coins))
                    case .failure(let error):
                        callback(.failure(error))
                    }
                }
            }
        }
    }
}
