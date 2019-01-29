//
//  CustomTextField.swift
//  Friendza
//
//  Created by jyoti shankar sahoo on 1/28/19.
//  Copyright © 2019 jyoti shankar sahoo. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    var padding: CGFloat
    var height: CGFloat

    init(padding: CGFloat, height: CGFloat) {
        self.padding = padding
        self.height = height
        super.init(frame: .zero)
        backgroundColor = .white
        layer.cornerRadius = height/2
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    override var intrinsicContentSize: CGSize {
        return .init(width: 0, height: height)
    }
}
