//
//  ViewController.swift
//  CoinView
//
//  Created by KsArT on 19.08.2024.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var loading: UIActivityIndicatorView!

    @IBOutlet weak var coinsTable: UITableView!

    private var coins: [Coin] = []
    private var coinsLogo: [String:UIImage] = [:]
    // pull to refresh
    private let refreshControl: UIRefreshControl = {
        let view = UIRefreshControl()
        view.attributedTitle = NSAttributedString(string: "Updating...")
        return view
    }()
    private let repository: CoinRepository? = ServiceLocator.shared.resolve()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        loadData()
    }

    private func setupView() {
        loading.hidesWhenStopped = true
        coinsTable.delegate = self
        coinsTable.dataSource = self
        refreshControl.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        coinsTable.refreshControl = refreshControl
    }

    @objc private func handleRefreshControl() {
        loadData()
    }

}

// MARK: - Loading data for table
private extension MainViewController {

    private func loadData() {
        loading.startAnimating()
        refreshControl.beginRefreshing()
        repository?.fetchCoins() { [weak self] result in
            self?.loading.stopAnimating()
            switch result {
                case .success(let coins):
                    self?.coins = coins
                    self?.coinsTable.reloadData()
                case .failure(let error):
                    self?.showAlert(title: "Error", message: error.localizedDescription)
            }
            self?.refreshControl.endRefreshing()
        }
    }

    private func loadLogo(id: String, completion: @escaping (UIImage) -> Void) {
        guard !id.isEmpty else { return }

        if let image = coinsLogo[id] {
            completion(image)
        } else {
            repository?.fetchCoinLogo(id: id) { [weak self] data in
                guard let self, let image = UIImage(data: data)?.resize(64) else { return }
                self.coinsLogo[id] = image
                completion(image)
            }
        }
    }
}

// MARK: - TableViewDelegate
extension MainViewController: UITableViewDelegate {

}

// MARK: - TableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coins.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row < coins.count else { fatalError("'CoinCellSID' row=\(indexPath.row) > count=\(coins.count)") }

        let coin = coins[indexPath.row]

        let cell = coinsTable.dequeueReusableCell(withIdentifier: "CoinCellSID", for: indexPath)

        cell.textLabel?.text = coin.name
        cell.detailTextLabel?.text = "\(coin.rank) (\(coin.symbol))"
        cell.backgroundColor = (coin.isActive ? UIColor.green : UIColor.red).withAlphaComponent(0.5)

        // подставляем логотип coin
        let image = coinsLogo[coin.id]
        cell.imageView?.image = image
        if image == nil {
            // поставим заглушку
            cell.imageView?.image = UIImage(named: "Coin")
            // загрузим логотип из сети и обновим ячейку
            loadLogo(id: coin.id) { [weak self, weak cell, indexPath] image in
                guard let self, let cell else { return }

                cell.imageView?.image = image
                self.coinsTable.reloadRows(at: [indexPath], with: .fade)
            }
        }

        return cell
    }

}
