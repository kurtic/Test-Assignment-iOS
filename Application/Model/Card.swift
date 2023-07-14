//
//  Card.swift
//  CardTestApp
//
//  Created by Diachenko Ihor on 14.07.2023.
//

import UIKit

struct Card: Codable {
    let cardNumber: Int
    let isVisa: Bool
}

extension Card {
    var logo: UIImage? {
        isVisa ? R.image.icVisa() : R.image.icMastercard()
    }
    
    var numberStringRepresent: String {
        let numberStr = String(cardNumber)
        var resultStr = ""
        let amountShowingNumbers = 4
        for index in 0..<String(cardNumber).count - amountShowingNumbers {
            resultStr.append("*")
            if index > 0 && (index + 1) % 4 == 0 {
                resultStr.append(" ")
            }
        }
        resultStr.append(String(numberStr.suffix(amountShowingNumbers)))
        return resultStr
    }
    
    var shortCardNumber: String {
        "**** " + String(cardNumber).suffix(4)
    }
    
    var cardColor: UIColor? {
        isVisa ? R.color.visaColor() : R.color.msColor()
    }
}
