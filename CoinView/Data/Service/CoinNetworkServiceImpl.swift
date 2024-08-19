//
//  CoinNetworkServiceImpl.swift
//  CoinView
//
//  Created by KsArT on 19.08.2024.
//

import Foundation

final class CoinNetworkServiceImpl: CoinNetworkService {

    func loadData<T>(endpoint: CoinEndpoint, callback: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        executeRequest(endpoint: endpoint) { data in
            if let result: T = self.decode(from: data) {
                callback(.success(result))
            } else {
                callback(.failure(NetworkError.invalidData))
            }
        } errorData: { error in
            callback(.failure(error))
        }
    }

    private func executeRequest(endpoint: CoinEndpoint, decodeData: @escaping (Data) -> Void, errorData: @escaping (Error) -> Void) {
        guard let url = endpoint.url else {
            errorData(NetworkError.invalidURL)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                errorData(error)
                return
            }

            guard let data else {
                errorData(NetworkError.invalidData)
                return
            }

            decodeData(data)
        }.resume()
    }

    private func decode<T>(from data: Data) -> T? where T : Decodable {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try? decoder.decode(T.self, from: data)
    }
}
