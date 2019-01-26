//
//  User.swift
//  Friendza
//
//  Created by jyoti shankar sahoo on 1/25/19.
//  Copyright © 2019 jyoti shankar sahoo. All rights reserved.
//

import UIKit

struct User: CardViewModelConvertable {
    let name: String
    let age: Int
    let occupation: String
    let imageString: String

    func toCardViewModel() -> CardViewModel {
        let attributedString = NSMutableAttributedString(string: name, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
        attributedString.append(NSMutableAttributedString(string: " \(age)\n", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
        attributedString.append(NSMutableAttributedString(string: occupation, attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
        return CardViewModel(attributedString: attributedString, imageString: imageString, allignement: .left)
    }
}
