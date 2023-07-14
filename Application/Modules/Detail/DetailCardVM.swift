//
//  DetailCardVM.swift
//  CardTestApp
//
//  Created by Diachenko Ihor on 14.07.2023.
//

import Combine

final class DetailCardVM {
    
    // MARK: - Properties
    let card: Card
    
    // MARK: - Life Cycle
    init(card: Card) {
        self.card = card
    }
}
