//
//  Advertisement.swift
//  Friendza
//
//  Created by jyoti shankar sahoo on 1/26/19.
//  Copyright © 2019 jyoti shankar sahoo. All rights reserved.
//

import UIKit

struct Advertisement: CardViewModelConvertable {
    let title: String
    let brand: String
    let posterPhotoName: String

    func toCardViewModel() -> CardViewModel {
        let attributedString = NSMutableAttributedString(string: title, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
        attributedString.append(NSMutableAttributedString(string: "\n\(brand)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
        return CardViewModel(attributedString: attributedString, imageString: posterPhotoName, allignement: .center)
    }
}
