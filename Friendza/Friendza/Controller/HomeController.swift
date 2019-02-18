//
//  ViewController.swift
//  Friendza
//
//  Created by jyoti shankar sahoo on 1/23/19.
//  Copyright © 2019 jyoti shankar sahoo. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD

class HomeController: UIViewController {

    let topStackView = TopNavBarStackView()
    let bottomControlStackView = HomeBottomControlsStackView()
    let cardDeckView = UIView()

    var userViewModel = [CardViewModel]()
    var lastFetchedUser: User?
    lazy var refereshingProggressHUD: JGProgressHUD = {
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Refreshing"
        return hud
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        bottomControlStackView.refreshButton.addTarget(self, action: #selector(handleRefresh), for: .touchUpInside)
        setupFireStoreUserCards()
        fetchUserInfoFromFireBase()
    }
    fileprivate func fetchUserInfoFromFireBase() {
        refereshingProggressHUD.show(in: view)
        let query = Firestore.firestore().collection("users").order(by: "uid").start(after: [lastFetchedUser?.uid ?? ""]).limit(to: 1)
        query.getDocuments { (querySnapShot, error) in
            self.refereshingProggressHUD.dismiss()
            if let error = error {
                print(error.localizedDescription)
                return
            }
            querySnapShot?.documents.forEach({ (documentSnapShot) in
                let userDictionary = documentSnapShot.data()
                let user = User(with: userDictionary)
                self.userViewModel.append(user.toCardViewModel())
                self.lastFetchedUser = user
                self.setupCardsOnView(model: user)
                //self.setupFireStoreUserCards()
            })
        }
    }

    fileprivate func setupCardsOnView(model: User) {
        let cardView = CardView()
        cardView.viewModel = model.toCardViewModel()
        cardDeckView.addSubview(cardView)
        cardDeckView.sendSubviewToBack(cardView)
        cardView.fillInSuperView()
    }

    @objc fileprivate func handleRefresh() {
        fetchUserInfoFromFireBase()
    }
    fileprivate func setupFireStoreUserCards() {
        userViewModel.forEach { (viewModel) in
            let cardView = CardView()
            cardView.viewModel = viewModel
            cardDeckView.addSubview(cardView)
            cardView.fillInSuperView()
        }
    }

    fileprivate func setupLayout() {
        view.backgroundColor = .white
        let overallStackview = UIStackView(arrangedSubviews: [topStackView, cardDeckView, bottomControlStackView])
        overallStackview.axis = .vertical
        view.addSubview(overallStackview)
        overallStackview.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor)
        overallStackview.isLayoutMarginsRelativeArrangement = true
        overallStackview.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        overallStackview.bringSubviewToFront(cardDeckView)
    }

}
