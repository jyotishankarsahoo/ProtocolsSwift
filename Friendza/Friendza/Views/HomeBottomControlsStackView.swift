//
//  HomeBottomControlsStackView.swift
//  Friendza
//
//  Created by jyoti shankar sahoo on 1/24/19.
//  Copyright © 2019 jyoti shankar sahoo. All rights reserved.
//

import UIKit

class HomeBottomControlsStackView: UIStackView {

    static func createButton(with image: UIImage) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }

    let refreshButton: UIButton = createButton(with: #imageLiteral(resourceName: "refresh_circle"))
    let unlikeButton: UIButton = createButton(with: #imageLiteral(resourceName: "dismiss_circle"))
    let likeButton: UIButton = createButton(with: #imageLiteral(resourceName: "super_like_circle"))
    let superLikeButton: UIButton = createButton(with: #imageLiteral(resourceName: "like_circle"))
    let specialButton: UIButton = createButton(with: #imageLiteral(resourceName: "boost_circle"))


    override init(frame: CGRect) {
        super.init(frame: frame)
        distribution = .fillEqually
        heightAnchor.constraint(equalToConstant: 80).isActive = true
        [refreshButton, unlikeButton, likeButton, superLikeButton, specialButton].forEach { (button) in
            addArrangedSubview(button)
        }
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
