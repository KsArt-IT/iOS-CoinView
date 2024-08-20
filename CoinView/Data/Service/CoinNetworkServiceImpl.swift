//
//  CoinNetworkServiceImpl.swift
//  CoinView
//
//  Created by KsArT on 19.08.2024.
//

import Foundation

final class CoinNetworkServiceImpl: CoinNetworkService {

    func loadData(url: String, completion: @escaping (Data) -> Void) {
        guard let url = URL(string: url) else { return }

        executeRequest(url: url, successData: completion, errorData: { _ in })
    }

    func loadData<T>(endpoint: CoinEndpoint, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        guard let url = endpoint.url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        executeRequest(url: url) { data in
            if let result: T = self.decode(from: data) {
                completion(.success(result))
            } else {
                completion(.failure(NetworkError.invalidData))
            }
        } errorData: { error in
            completion(.failure(error))
        }
    }

    private func executeRequest(url: URL, successData: @escaping (Data) -> Void, errorData: @escaping (Error) -> Void) {
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

            successData(data)
        }.resume()
    }

    private func decode<T>(from data: Data) -> T? where T : Decodable {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try? decoder.decode(T.self, from: data)
    }
}
