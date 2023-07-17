//
//  DetailCardVC.swift
//  CardTestApp
//
//  Created by Diachenko Ihor on 14.07.2023.
//

import UIKit

extension DetailCardVC: Makeable {
    static func make() -> DetailCardVC { R.storyboard.detailCard.detailCardVC()! }
}

final class DetailCardVC: UIViewController {
    
    private enum C {
        static let cornerRadius: CGFloat = 10
    }
    
    // MARK: - IBOutlets
    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var cardNumberLabel: UILabel!
    @IBOutlet private weak var cardLogoImageView: UIImageView!
    
    // MARK: - Properties
    var viewModel: DetailCardVM?
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        cardView.layer.cornerRadius = C.cornerRadius
        cardNumberLabel.text = viewModel?.card.shortCardNumber
        cardNumberLabel.textColor = (viewModel?.card.isVisa ?? false) ? .darkText : .white
        cardLogoImageView.image = viewModel?.card.logo
        cardView.backgroundColor = viewModel?.card.cardColor
    }
}
