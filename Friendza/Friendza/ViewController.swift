//
//  ViewController.swift
//  Friendza
//
//  Created by jyoti shankar sahoo on 1/23/19.
//  Copyright © 2019 jyoti shankar sahoo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let topStackView = TopNavBarStackView()
    let bottomStackView = HomeBottomControlsStackView()
    let greenView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        greenView.backgroundColor = UIColor.green
        setupLayout()
    }

    fileprivate func setupLayout() {
        let overallStackview = UIStackView(arrangedSubviews: [topStackView, greenView, bottomStackView])
        overallStackview.axis = .vertical
        view.addSubview(overallStackview)
        overallStackview.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }

}
