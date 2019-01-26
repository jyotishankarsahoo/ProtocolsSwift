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
struct CardViewModel {
    let attributedString: NSAttributedString
    let imageString: String
    let allignement: NSTextAlignment
}
