//
//  CardsService.swift
//  CardTestApp
//
//  Created by Diachenko Ihor on 13.07.2023.
//

import KeychainAccess
import Combine

protocol CardsUseCase {
    func saveToKeychain(cards: [Card]) -> AnyPublisher<Void, Error>
    func loadFromKeychain() -> AnyPublisher<[Card], Error>
}

final class CardsService: CardsUseCase {
    let propertyListEncoder = PropertyListEncoder()
    let propertyListDecoder = PropertyListDecoder()
    let keychain = Keychain(service: "com.Dyachenko.CardTestApp")
    
    func saveToKeychain(cards: [Card]) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { [unowned self] promise in
            do {
                let data = try propertyListEncoder.encode(cards)
                keychain[data: "encodedCardInfo"] = NSData(data: data) as Data
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func loadFromKeychain() -> AnyPublisher<[Card], Error> {
        Future<[Card], Error> { [unowned self] promise in
            do {
                guard let data = keychain[data: "encodedCardInfo"] else {
                    promise(.success([]))
                    return
                }
                let cards = try propertyListDecoder.decode([Card].self, from: data)
                promise(.success(cards))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
}
