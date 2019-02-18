//
//  User.swift
//  Friendza
//
//  Created by jyoti shankar sahoo on 1/25/19.
//  Copyright © 2019 jyoti shankar sahoo. All rights reserved.
//

import UIKit

struct User: CardViewModelConvertable {
    let name: String?
    let age: Int?
    let occupation: String?
    var image1URL: String?
    var uid: String?

    init(with dictionary: [String: Any]) {
        self.age = dictionary["age"] as? Int
        self.occupation = dictionary["occupation"] as? String
        self.uid = dictionary["uid"] as? String
        self.name = dictionary["fullname"] as? String ?? ""
        self.image1URL = dictionary["img1URL"] as? String ?? ""

    }

    func toCardViewModel() -> CardViewModel {
        let attributedString = NSMutableAttributedString(string: name ?? "", attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
        let ageString = age != nil ? "\(age!)" : "N\\A"
        attributedString.append(NSMutableAttributedString(string: " \(ageString) \n", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
        let occupationString = occupation != nil ? "\(occupation!)" : "Not Specified"
        attributedString.append(NSMutableAttributedString(string: occupationString, attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
        return CardViewModel(attributedString: attributedString, imagesString: [image1URL ?? ""], allignement: .left)
    }
}
