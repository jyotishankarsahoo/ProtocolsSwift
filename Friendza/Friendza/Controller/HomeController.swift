//
//  ViewController.swift
//  Friendza
//
//  Created by jyoti shankar sahoo on 1/23/19.
//  Copyright © 2019 jyoti shankar sahoo. All rights reserved.
//

import UIKit

class HomeController: UIViewController {

    let topStackView = TopNavBarStackView()
    let bottomStackView = HomeBottomControlsStackView()
    let cardDeckView = UIView()

    let userViewModel: [CardViewModel] = {
        let models: [CardViewModelConvertable] = [User(name: "Christ", age: 18, occupation: "Radio DJ", imageString: "lady5c"),
                      User(name: "Lessly", age: 21, occupation: "Teacher", imageString: "lady4c"),
                      Advertisement(title: "Welcome to MVVM", brand: "Self Learning", posterPhotoName: "slide_out_menu_poster"),
                      User(name: "Christ", age: 18, occupation: "Radio DJ", imageString: "lady5c")]
        return models.map({ $0.toCardViewModel()})
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupDummyCards()
    }

    fileprivate func setupDummyCards() {
        userViewModel.forEach { (viewModel) in
            let cardView = CardView()
            cardView.viewModel = viewModel
            cardDeckView.addSubview(cardView)
            cardView.fillInSuperView()
        }

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
