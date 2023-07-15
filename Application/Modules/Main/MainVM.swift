//
//  MainVM.swift
//  CardTestApp
//
//  Created by Diachenko Ihor on 13.07.2023.
//

import Combine
import UIKit

protocol MainVMDelegate: Coordinator {
    func showDetailCard(for card: Card)
}

final class MainVM {
    
    // MARK: - Private Properties
    private var useCases: UseCases
    private weak var delegate: MainVMDelegate?
    
    var cancellable = Set<AnyCancellable>()
    let cards: CurrentValueSubject<[Card], Never> = CurrentValueSubject([])
    
    // MARK: - Life Cycle
    init(useCases: UseCases, delegate: MainVMDelegate) {
        self.useCases = useCases
        self.delegate = delegate
    }
    
    func showCardDetails(for card: Card) {
        delegate?.showDetailCard(for: card)
    }
    
    func addCard() {
        var cards = cards.value
        cards.append(Card(cardNumber: Int.random( in: 1_000_000_000_000_000...9_999_999_999_999_999),
                          isVisa: Bool.random(),
                          createdAt: Date()))
        cards = cards.sorted { $0.createdAt > $1.createdAt }
        saveCards(cards: cards)
    }
    
    func removeCard(at index: Int, completion: @escaping ()->()) {
        var cards = cards.value
        cards.remove(at: index)
        useCases.saveToKeychain(cards: cards).sink { _ in } receiveValue: { [unowned self] _ in
            self.cards.value = cards
            completion()
        }
        .store(in: &cancellable)
    }
    
    func getCards() {
        useCases.loadFromKeychain().sink { _ in } receiveValue: { [unowned self] cards in
            self.cards.value = cards
        }
        .store(in: &cancellable)
    }
    
    func saveCards(cards: [Card]) {
        useCases.saveToKeychain(cards: cards).sink { _ in } receiveValue: { [unowned self] _ in
            self.cards.value = cards
        }
        .store(in: &cancellable)
    }
}
