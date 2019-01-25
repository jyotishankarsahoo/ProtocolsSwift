//
//  HomeBottomControlsStackView.swift
//  Friendza
//
//  Created by jyoti shankar sahoo on 1/24/19.
//  Copyright © 2019 jyoti shankar sahoo. All rights reserved.
//

import UIKit

class HomeBottomControlsStackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        distribution = .fillEqually
        heightAnchor.constraint(equalToConstant: 80).isActive = true
        let buttons = [#imageLiteral(resourceName: "refresh_circle"), #imageLiteral(resourceName: "dismiss_circle"), #imageLiteral(resourceName: "super_like_circle"), #imageLiteral(resourceName: "like_circle"), #imageLiteral(resourceName: "boost_circle")].map { (image) -> UIView in
            let button = UIButton(type: .system)
            button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
            return button
        }

        buttons.forEach { (view) in
            addArrangedSubview(view)
        }
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
