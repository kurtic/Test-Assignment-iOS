//
//  MainVM.swift
//  CardTestApp
//
//  Created by Diachenko Ihor on 13.07.2023.
//

import ReactiveSwift

protocol MainVMDelegate: Coordinator {
    func showDetailCard(for card: Card)
}

final class MainVM: NSObject {
    
    // MARK: - Private Properties
    private var useCases: UseCases
    private weak var delegate: MainVMDelegate?
    
    let cards = MutableProperty<[Card]>([])
    
    // MARK: - Actions
    private lazy var saveCardsAction = Action(execute: useCases.saveToKeychain)
    private lazy var loadFromKeychainAction = Action(execute: useCases.loadFromKeychain)
    
    // MARK: - Life Cycle
    init(useCases: UseCases, delegate: MainVMDelegate) {
        self.useCases = useCases
        self.delegate = delegate
        super.init()
        cards <~ saveCardsAction.values.merge(with: loadFromKeychainAction.values)
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
        saveCardsAction.apply(cards).start()
    }
    
    func removeCard(at index: Int, completion: @escaping () -> ()) {
        var cards = cards.value
        cards.remove(at: index)
        saveCardsAction.apply(cards).startWithResult { result in
            guard case .success = result else { return }
            completion()
        }
    }
    
    func getCards() {
        loadFromKeychainAction.apply().start()
    }
}
