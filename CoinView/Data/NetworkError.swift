//
//  NetworkError.swift
//  CoinView
//
//  Created by KsArT on 19.08.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL, invalidRequest, invalidResponse, invalidData
}
