//
//  CardView.swift
//  Friendza
//
//  Created by jyoti shankar sahoo on 1/25/19.
//  Copyright © 2019 jyoti shankar sahoo. All rights reserved.
//

import UIKit

class CardView: UIView {
    private let imageView = UIImageView(image: #imageLiteral(resourceName: "lady5c").withRenderingMode(.alwaysOriginal))
    private let informationLabel = UILabel()
    private let gradient = CAGradientLayer()
    let panThreshold: CGFloat = 100

    var viewModel: CardViewModel! {
        didSet {
            imageView.image = UIImage(named: viewModel.imageString)
            informationLabel.attributedText = viewModel.attributedString
            informationLabel.textAlignment = viewModel.allignement
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        clipsToBounds = true

        addSubview(imageView)
        imageView.fillInSuperView()

        addGradientLayer()

        informationLabel.numberOfLines = 0
        informationLabel.textColor = .white
        addSubview(informationLabel)
        informationLabel.anchor(top: nil, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor, padding: .init(top: 0, left: 16, bottom: 16, right: 16))

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
    }

    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            superview?.subviews.forEach({ $0.layer.removeAllAnimations() })
        case .changed:
            handleChanged(gesture)
        case .ended:
            handleEnded(gesture)
        default:
            ()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func addGradientLayer() {
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.5, 1.1]
        self.layer.addSublayer(gradient)
    }

    override func layoutSubviews() {
        gradient.frame = self.frame
    }

    fileprivate func handleChanged(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: nil)
        let degree: CGFloat = translation.x / 20
        let angle = degree * .pi / 180

        let rotationalTransformation = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationalTransformation.translatedBy(x: translation.x, y: translation.y)
    }

    fileprivate func handleEnded(_ gesture: UIPanGestureRecognizer) {
        let transalationDirection: CGFloat = gesture.translation(in: nil).x > 0 ? 1 : -1
        let shouldDismissCard = abs(gesture.translation(in: nil).x) > panThreshold
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseInOut
            , animations: {
                if shouldDismissCard {
                    self.frame = CGRect(x: 1000 * transalationDirection, y: 0, width: self.superview!.frame.width, height: self.superview!.frame.height)
                } else {
                    self.transform = .identity
                }
        }) { (_) in
            self.transform = .identity
            if shouldDismissCard {
                self.removeFromSuperview()
            }
        }
    }
}
