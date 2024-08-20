//
//  ControllersExt.swift
//  CoinView
//
//  Created by KsArT on 20.08.2024.
//

import UIKit

extension UIViewController {

    func showAlert(title: String = "", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }

}
