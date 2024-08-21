//
//  CoinDetailViewController.swift
//  CoinView
//
//  Created by KsArT on 21.08.2024.
//

import UIKit

class CoinDetailViewController: UIViewController {

    private var coinId: String?
    private let repository: CoinRepository? = ServiceLocator.shared.resolve()

    @IBOutlet weak var loading: UIActivityIndicatorView!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var teamText: UITextView!
    @IBOutlet weak var tagsText: UITextView!
    @IBOutlet weak var messageLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        loadData(id: coinId)
    }

}

// MARK: - Loading data
private extension CoinDetailViewController {

    func loadData(id: String?) {
        guard let id else { return }

        loading.startAnimating()
        repository?.fetchCoinDetail(id: id) { [weak self] result in
            switch result {
                case .success(let coinDetail):
                    self?.updateView(coinDetail)
                    if !coinDetail.logo.isEmpty {
                        self?.repository?.fetchCoinLogo(id: coinDetail.id) { data in
                            self?.updateImage(data: data)
                        }
                    }
                case .failure(let error):
                    self?.showAlert(title: "Error", message: error.localizedDescription)
            }
            self?.loading.stopAnimating()
        }
    }

    func updateView(_ coin: CoinDetail) {
        nameLabel.text = coin.name
        symbolLabel.text = coin.symbol
        teamText.text = coin.team.joined(separator: "\n")
        tagsText.text = coin.tags.joined(separator: "\n")
        messageLabel.text = coin.message.isEmpty ? coin.description : coin.message
    }

    func updateImage(data: Data) {
        logoImageView.image = UIImage(data: data)
    }
}

// MARK: - CoinIdDelegate
extension CoinDetailViewController: CoinIdDelegate {

    func setCoinId(_ id: String) {
        coinId = id
    }

}
    
