//
//  ViewController.swift
//  Friendza
//
//  Created by jyoti shankar sahoo on 1/23/19.
//  Copyright © 2019 jyoti shankar sahoo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let upperSubview = [UIColor.gray, .darkGray, .black].map { (color) -> UIView in
            let view = UIView()
            view.backgroundColor = color
            return view
        }
        let topStackView = UIStackView(arrangedSubviews: upperSubview)
        topStackView.axis = .horizontal
        topStackView.distribution = .fillEqually
        topStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true

        let greenView = UIView()
        greenView.backgroundColor = UIColor.green

        let blueView = UIView()
        blueView.backgroundColor = UIColor.blue
        blueView.heightAnchor.constraint(equalToConstant: 100).isActive = true

        let stackView = UIStackView(arrangedSubviews: [topStackView, greenView, blueView])
        stackView.axis = .vertical
        view.addSubview(stackView)
        stackView.fillInSuperView()
    }


}

extension UIView {
    func fillInSuperView() {
        anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, trailing: superview?.trailingAnchor, bottom: superview?.bottomAnchor)
    }

    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {

        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }

        if size.width != 0 { widthAnchor.constraint(equalToConstant: size.width).isActive = true }
        if size.height != 0 { heightAnchor.constraint(equalToConstant: size.height).isActive = true }
    }
}

