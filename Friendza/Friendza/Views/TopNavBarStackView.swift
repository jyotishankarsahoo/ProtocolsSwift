//
//  TopNavBarStackView.swift
//  Friendza
//
//  Created by jyoti shankar sahoo on 1/24/19.
//  Copyright © 2019 jyoti shankar sahoo. All rights reserved.
//

import UIKit

class TopNavBarStackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        distribution = .fillEqually
        heightAnchor.constraint(equalToConstant: 80).isActive = true
        let topSubviews = [#imageLiteral(resourceName: "top_left_profile"), #imageLiteral(resourceName: "app_icon"), #imageLiteral(resourceName: "top_right_messages")].map { (image) -> UIView in
            let button = UIButton(type: .system)
            button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
            return button
        }
        topSubviews.forEach { (view) in
            addArrangedSubview(view)
        }
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
