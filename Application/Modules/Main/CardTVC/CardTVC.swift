//
//  CardTVC.swift
//  CardTestApp
//
//  Created by Diachenko Ihor on 14.07.2023.
//

import UIKit

final class CardTVC: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var cardImageView: UIImageView!
    @IBOutlet private weak var cardNumberLabel: UILabel!
    
    // MARK: - Configure
    func configure(card: Card) {
        cardImageView.image = card.logo
        cardNumberLabel.text = card.numberStringRepresent
    }
}
