//
//  MainFactory.swift
//  CardTestApp
//
//  Created by Diachenko Ihor on 13.07.2023.
//

import Foundation

final class MainFactory: BaseFactory {
    static var main = MainFactory()
    private override init() {}
    
    func makeMainVC<T: Coordinator & MainVMDelegate>(coordinator: T) -> MainVC {
        makeController(coordinator) {
            $0.viewModel = MainVM(useCases: coordinator.useCases, delegate: coordinator)
        }
    }
    
    func makeCardDetailVC<T: Coordinator> (coordinator: T, card: Card) -> DetailCardVC {
        makeController(coordinator) {
            $0.viewModel = DetailCardVM(card: card)
        }
    }
}
