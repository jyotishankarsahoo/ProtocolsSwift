//
//  RegistrationViewModel.swift
//  Friendza
//
//  Created by jyoti shankar sahoo on 1/28/19.
//  Copyright © 2019 jyoti shankar sahoo. All rights reserved.
//

import UIKit
import Firebase

class RegistrationViewModel {
    var userImage: UIImage? {
        didSet { userImageObserver?(userImage) }
    }
    var isRegistering: Bool? {
        didSet {
            registrationObserver?(isRegistering)
        }
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
    var registrationObserver: ((Bool?) -> ())?

    func performRegistration(with complition: @escaping ((Error?) -> Void)) {
        guard let email = email, let password = password else { return }
        isRegistering = true
        Auth.auth().createUser(withEmail: email, password: password) {(result, error) in
            if let error = error {
                self.isRegistering = false
                complition(error)
                return
            }
            print("Registered User is :", result?.user.uid ?? "")
            self.storeImageInFireBase(with: complition)
        }
    }

    fileprivate func storeImageInFireBase(with complition: @escaping ((Error?) -> Void)) {
        let filename = UUID().uuidString
        let imageRef = Storage.storage().reference(withPath: "/images/\(filename)")
        let imageData = self.userImage?.jpegData(compressionQuality: 0.75) ?? Data()
        // Upload data in Firebase database once user is Authoraized
        imageRef.putData(imageData, metadata: nil, completion: { (_, err) in
            if let err = err {
                self.isRegistering = false
                complition(err)
                return
            }
            print("Finished uploading photo")
            // Fetch image URL from firebase
            imageRef.downloadURL(completion: { (url, err) in
                if let err = err {
                    self.isRegistering = false
                    complition(err)
                    return
                }
                self.isRegistering = false
                self.saveUserInfoOnFirebase(imageURL: url?.absoluteString, with: complition)
            })
        })
    }

    fileprivate func saveUserInfoOnFirebase(imageURL: String?, with complition: @escaping ((Error?) -> ())) {
        guard let uuid = Auth.auth().currentUser?.uid, let imgURL  = imageURL, let fullName = fullName else {
            return
        }
        let dataDict = ["fullname": fullName, "img1URL": imgURL, "uid": uuid]
        Firestore.firestore().collection("users").document(uuid).setData(dataDict) { (error) in
            if let error = error {
                complition(error)
                return
            }
            complition(nil)
        }
    }
}
