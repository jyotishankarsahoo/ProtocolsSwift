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
    let cardDeckView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupDummyCards()
    }

    fileprivate func setupDummyCards() {
        let cardView = CardView()
        cardDeckView.addSubview(cardView)
        cardView.fillInSuperView()
    }

    fileprivate func setupLayout() {
        let overallStackview = UIStackView(arrangedSubviews: [topStackView, cardDeckView, bottomStackView])
        overallStackview.axis = .vertical
        view.addSubview(overallStackview)
        overallStackview.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor)
        overallStackview.isLayoutMarginsRelativeArrangement = true
        overallStackview.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        overallStackview.bringSubviewToFront(cardDeckView)
    }

}
