//
//  ServiceLocator.swift
//  CoinView
//
//  Created by KsArT on 19.08.2024.
//

final class ServiceLocator {
    static let shared = ServiceLocator(); private init() {}

    private var services: [String: Any] = [:]

    func register<T>(service: T) {
        let key = "\(T.self)"
        services[key] = service
    }

    func resolve<T>() -> T? {
        let key = "\(T.self)"
        return services[key] as? T
    }

}
