//
//  RegistrationViewModel.swift
//  Friendza
//
//  Created by jyoti shankar sahoo on 1/28/19.
//  Copyright © 2019 jyoti shankar sahoo. All rights reserved.
//

import UIKit

struct RegistrationViewModel {
    var userImage: UIImage? {
        didSet { userImageObserver?(userImage) }
    }
    var fullName: String? { didSet { checkFormValidatity() } }
    var email: String? { didSet { checkFormValidatity() } }
    var password: String? { didSet { checkFormValidatity() } }

    fileprivate func checkFormValidatity() {
        let isformValid = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        shouldEnableRegisterButton?(isformValid)
    }
    var userImageObserver: ((UIImage?) -> ())?
    var shouldEnableRegisterButton: ((Bool)-> ())?
}
