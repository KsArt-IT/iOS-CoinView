//
//  CoinDetailDto.swift
//  CoinView
//
//  Created by KsArT on 20.08.2024.
//


struct CoinDetailDto: Decodable {
    let id: String
    let name: String
    let symbol: String
    let rank: Int
    let isNew: Bool
    let isActive: Bool
    let type: String?
    let contract: String?
    let logo: String?
    let platform: String?
    let description: String
    let developmentStatus: String?
    let firstDataAt: String?
    let hardwareWallet: Bool
    let hashAlgorithm: String?
    let lastDataAt: String?
    let message: String?
    let openSource: Bool
    let orgStructure: String?
    let proofType: String?
    let startedAt: String?
    let tags: [CoinTagDto]
    let team: [CoinTeamMemberDto]
    let whitepaper: CoinWhitepaperDto
}

extension CoinDetailDto {

    func mapToDomain() -> CoinDetail {
        CoinDetail(
            id: self.id,
            name: self.name,
            symbol: self.symbol,
            rank: self.rank,
            isNew: self.isNew,
            isActive: self.isActive,
            description: self.description,
            firstDataAt: self.firstDataAt ?? "",
            lastDataAt: self.lastDataAt ?? "",
            message: self.message ?? "",
            tags: self.tags.map { $0.name },
            team: self.team.map { "\($0.name) - \($0.position)" }
        )
    }
}
