//
//  CardsService.swift
//  CardTestApp
//
//  Created by Diachenko Ihor on 13.07.2023.
//

import KeychainAccess
import ReactiveSwift

protocol CardsUseCase {
    func saveToKeychain(cards: [Card]) -> SignalProducer<[Card], Error>
    func loadFromKeychain() -> SignalProducer<[Card], Error>
}

final class CardsService: CardsUseCase {
    let propertyListEncoder = PropertyListEncoder()
    let propertyListDecoder = PropertyListDecoder()
    let keychain = Keychain(service: "com.Dyachenko.CardTestApp")
    
    func saveToKeychain(cards: [Card]) -> SignalProducer<[Card], Error> {
        SignalProducer{ [unowned self] (observer, lifetime)  in
            do {
                let data = try propertyListEncoder.encode(cards)
                keychain[data: "encodedCardInfo"] = NSData(data: data) as Data
                observer.send(value: cards)
                observer.sendCompleted()
            } catch {
                observer.send(error: error)
            }
        }
    }
    
    func loadFromKeychain() -> SignalProducer<[Card], Error> {
        SignalProducer { [unowned self] (observer, lifetime) in
            do {
                guard let data = keychain[data: "encodedCardInfo"] else {
                    observer.send(value: [])
                    return
                }
                let cards = try propertyListDecoder.decode([Card].self, from: data)
                observer.send(value: cards)
                observer.sendCompleted()
            } catch {
                observer.send(error: error)
            }
        }
    }
}
