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

    func fetchCoins(completion: @escaping (Result<[Coin], Error>) -> Void) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            self?.service.loadData(endpoint: .coins) { (result: Result<[CoinDto], Error>) in
                DispatchQueue.main.async {
                    switch result {
                        case .success(let coinDTOs):
                            let coins = coinDTOs.map { $0.mapToDomain() }
                            completion(.success(coins))
                        case .failure(let error):
                            completion(.failure(error))
                    }
                }
            }
        }
    }

    func fetchCoinDetail(id: String, completion: @escaping (Result<CoinDetail, any Error>) -> Void) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            self?.service.loadData(endpoint: .coin(id: id)) { (result: Result<CoinDetailDto, Error>) in
                DispatchQueue.main.async {
                    switch result {
                        case .success(let coinDetailDto):
                            completion(.success(coinDetailDto.mapToDomain()))
                        case .failure(let error):
                            completion(.failure(error))
                    }
                }
            }
        }
    }

    func fetchCoinLogo(id: String, completion: @escaping (Data) -> Void) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            self?.service.loadData(endpoint: .coin(id: id)) { (result: Result<CoinDetailDto, Error>) in
                switch result {
                    case .success(let coinDetailDto):
                        guard let url = coinDetailDto.logo else { return }
                        print("logo url = \(url)")
                        
                        self?.service.loadData(url: url) { data in
                            DispatchQueue.main.async {
                                completion(data)
                            }
                        }
                    case .failure(_):
                        break
                }
            }
        }
    }

}
