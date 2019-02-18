//
//  CardViewModel.swift
//  Friendza
//
//  Created by jyoti shankar sahoo on 1/26/19.
//  Copyright © 2019 jyoti shankar sahoo. All rights reserved.
//

import UIKit
protocol CardViewModelConvertable {
    func toCardViewModel() -> CardViewModel
}
class CardViewModel {

    let attributedString: NSAttributedString
    let imagesString: [String]
    let allignement: NSTextAlignment
    fileprivate var imageIndex = 0 {
        didSet {
            let imageURL = imagesString[imageIndex]
            imageIndexObserver?(imageIndex, imageURL)
        }
    }

    init(attributedString: NSAttributedString, imagesString: [String], allignement: NSTextAlignment) {
        self.attributedString = attributedString
        self.imagesString = imagesString
        self.allignement = allignement
    }

    //Reactive Programming
    var imageIndexObserver: ((Int, String?) -> ())?

    func goToNextPhoto() {
        imageIndex = min(imageIndex + 1, imagesString.count - 1)
    }
    func goToPreviousPhoto() {
        imageIndex = max(0, imageIndex - 1)
    }
}
