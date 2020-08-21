//
//  LILoadingView.swift
//  LinkedInLoadingView
//
//  Created by Ahmed Khalaf on 8/21/20.
//  Copyright © 2020 io.github.ahmedkhalaf. All rights reserved.
//

import UIKit

open class LILoadingView: UIControl {
    // MARK: - Public
    public private(set) lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .medium)
        activityIndicatorView.color = .white
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }()
    public private(set) lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .boldSystemFont(ofSize: UIFont.systemFontSize)
        label.textColor = .white
        label.text = "Loading..."
        return label
    }()
    public private(set) lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [#colorLiteral(red: 0.3294117647, green: 0.7254901961, blue: 0.8823529412, alpha: 1), #colorLiteral(red: 0.2588235294, green: 0.5843137255, blue: 0.8039215686, alpha: 1)].map(\.cgColor)
        gradientLayer.startPoint = .init(x: 0, y: 0.5)
        gradientLayer.endPoint = .init(x: 1, y: 0.5)
        layer.insertSublayer(gradientLayer, at: 0)
        return gradientLayer
    }()
    open func show(in view: UIView, topInset: CGFloat = 64) {
        guard superview == nil else {
            return
        }
        
        clearConstraints()
        translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        let xConstraint = centerXAnchor.constraint(equalTo: view.centerXAnchor)
        xConstraint.isActive = true
        let yConstraint = topAnchor.constraint(equalTo: view.topAnchor, constant: 0)
        self.yConstraint = yConstraint
        yConstraint.isActive = true
        alpha = 0
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.25) {
            yConstraint.constant = topInset
            self.alpha = 1
            view.layoutIfNeeded()
        }
        
        constraintsWithParent.insert(xConstraint)
        constraintsWithParent.insert(yConstraint)
    }
    open func hide() {
        superview?.layoutIfNeeded()
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 0
            self.yConstraint?.constant = 0
            self.superview?.layoutIfNeeded()
        }) { _ in
            self.removeFromSuperview()
        }
    }
    // MARK: - Overrides
    open override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = layer.bounds
        gradientLayer.cornerRadius = bounds.height / 2
    }
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        _ = stackView
    }
    // MARK: - Private
    private weak var yConstraint: NSLayoutConstraint?
    private func clearConstraints() {
        for constraint in constraintsWithParent {
            removeConstraint(constraint)
        }
    }
    private var constraintsWithParent: Set<NSLayoutConstraint> = []
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            activityIndicatorView,
            label
        ])
        stackView.isUserInteractionEnabled = false // To allow taps.
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
        ])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 4
        return stackView
    }()
}
