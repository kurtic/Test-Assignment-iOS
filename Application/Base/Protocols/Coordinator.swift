//
//  Coordinator.swift
//  CardTestApp
//
//  Created by Diachenko Ihor on 13.07.2023.
//

import Foundation

typealias UseCases = CardsUseCase

protocol Coordinator: AnyObject {
    var useCases: UseCases { get }
    
    func start()
    func stop()
}
