//
//  RegistrationViewController.swift
//  Friendza
//
//  Created by jyoti shankar sahoo on 1/28/19.
//  Copyright © 2019 jyoti shankar sahoo. All rights reserved.
//

import UIKit

extension RegistrationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        dismiss(animated: true, completion: nil)
        viewModel.userImage = image
    }
}

class RegistrationViewController: UIViewController {
    fileprivate let selectImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select Photo", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        button.setTitleColor(.black, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 18
        button.backgroundColor = .white
        button.imageView?.contentMode = .scaleAspectFill
        button.heightAnchor.constraint(equalToConstant: 275).isActive = true
        button.addTarget(self, action: #selector(handlePhotoSelection), for: .touchUpInside)
        return button
    }()

    fileprivate lazy var selectImageButtonHeightAnchor = selectImageButton.heightAnchor.constraint(equalToConstant: 275)

    fileprivate lazy var selectImageButtonWidthAnchor = selectImageButton.widthAnchor.constraint(equalToConstant: 275)

    fileprivate let fullnameTextField: UITextField = {
        let textField = CustomTextField(padding: 25, height: 50)
        textField.placeholder = "Enter full name"
        textField.backgroundColor = .white
        textField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        return textField
    }()
    fileprivate let emailTextField: UITextField = {
        let textField = CustomTextField(padding: 25, height: 50)
        textField.keyboardType = .emailAddress
        textField.placeholder = "Enter email"
        textField.backgroundColor = .white
        textField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        return textField
    }()
    fileprivate let passwordTextField: UITextField = {
       let textField = CustomTextField(padding: 25, height: 50)
        textField.isSecureTextEntry = true
        textField.placeholder = "Enter password"
        textField.backgroundColor = .white
        textField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        return textField
    }()
    fileprivate let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        button.setTitleColor(.gray, for: .normal)
        button.isEnabled = false
        button.layer.cornerRadius = 22
        button.backgroundColor = .lightGray
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        return button
    }()
    lazy var verticalStackView: UIStackView = {
        let verticalStackView = UIStackView(arrangedSubviews: [fullnameTextField, emailTextField, passwordTextField, registerButton])
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 8
        return verticalStackView

    }()
    lazy var overallStackView = UIStackView(arrangedSubviews: [selectImageButton, verticalStackView])
    fileprivate let gradientLayer = CAGradientLayer()
    private var viewModel = RegistrationViewModel()

    //MARK: - View lifecycle Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientLayer()
        setupLayout()
        setupTapGesture()
        setupKeyBoardObserver()
        setupViewModelPropertyObserver()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // To avoid retain cycle
        //TODO: Comments to avoid key board  issue
        //NotificationCenter.default.removeObserver(self)
    }

    //MARK: - To handle orientation change
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gradientLayer.frame = view.bounds
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if self.traitCollection.verticalSizeClass == .compact {
            overallStackView.axis = .horizontal
            selectImageButtonHeightAnchor.isActive = false
            selectImageButtonWidthAnchor.isActive = true
            verticalStackView.distribution = .fillEqually
        } else {
            overallStackView.axis = .vertical
            verticalStackView.distribution = .fill
            selectImageButtonHeightAnchor.isActive = true
            selectImageButtonWidthAnchor.isActive = false
        }
    }

    //MARK: - fileprivate Outlet Actions

    @objc fileprivate func handlePhotoSelection() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }

    @objc fileprivate func textChanged(textField: UITextField) {
        if textField == fullnameTextField {
            viewModel.fullName = textField.text
        } else if textField == emailTextField {
            viewModel.email = textField.text
        } else {
            viewModel.password = textField.text
        }
    }

    @objc fileprivate func handleShowKyboard(notification: Notification) {
        // how to figure out how tall the keyboard actually is
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        let kyboardFrame = value.cgRectValue
        // let's try to figure out how tall the gap is from the register button to the bottom of the screen
        let bottomSpace = view.frame.height - overallStackView.frame.origin.y - overallStackView.frame.height

        let diff = kyboardFrame.height - bottomSpace
        view.transform = CGAffineTransform(translationX: 0, y: -diff - 8)
    }

    @objc fileprivate func handleHideKyboard(notification: Notification) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: { self.view.transform = .identity })
    }

    @objc fileprivate func handleTap() {
        view.endEditing(true) // Dismiss keyboard
    }

    //MARK: - fileprivate

    fileprivate func setupViewModelPropertyObserver() {
        viewModel.shouldEnableRegisterButton = { [unowned self] (isvalid) in
            if isvalid {
                self.registerButton.isEnabled = true
                self.registerButton.backgroundColor = #colorLiteral(red: 0.8235294118, green: 0, blue: 0.3254901961, alpha: 1)
                self.registerButton.setTitleColor(.white, for: .normal)
            } else {
                self.registerButton.isEnabled = false
                self.registerButton.backgroundColor = .lightGray
                self.registerButton.setTitleColor(.gray, for: .normal)
            }
        }
        viewModel.userImageObserver = { [unowned self] (image) in
            self.selectImageButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }

    fileprivate func setupKeyBoardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleShowKyboard), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleHideKyboard), name: UIResponder.keyboardDidHideNotification, object: nil)
    }

    fileprivate func setupGradientLayer() {
        gradientLayer.colors = [#colorLiteral(red: 0.9921568627, green: 0.3568627451, blue: 0.3725490196, alpha: 1).cgColor, #colorLiteral(red: 0.8980392157, green: 0, blue: 0.4470588235, alpha: 1).cgColor]
        gradientLayer.locations = [0.5, 1]
        gradientLayer.frame = view.bounds
        view.layer.addSublayer(gradientLayer)
    }

    fileprivate func setupLayout() {
        view.addSubview(overallStackView)
        overallStackView.axis = .vertical
        overallStackView.spacing = 8
        overallStackView.anchor(top: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: nil, padding: .init(top: 0, left: 50, bottom: 0, right: 50))
        overallStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    fileprivate func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }

}
