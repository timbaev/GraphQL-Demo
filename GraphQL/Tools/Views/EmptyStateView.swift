//
//  EmptyStateView.swift
//  GraphQL
//
//  Created by Timur Shafigullin on 04/05/2020.
//  Copyright © 2020 GraphQL-Demo. All rights reserved.
//

import UIKit
import SnapKit

struct EmptyStateAction {

    // MARK: - Instance Properties

    let title: String

    let onActionButtonClicked: (() -> Void)

    // MARK: - Initializers

    init(title: String, onClicked: @escaping (() -> Void)) {
        self.title = title

        self.onActionButtonClicked = onClicked
    }
}

@IBDesignable final class EmptyStateView: UIView {

    // MARK: - Instance Properties

    private var imageView: UIImageView?

    private let titleLabel = UILabel()
    private let messageLabel = UILabel()

    private var actionButton: PrimaryButton?

    private var activityIndicatorView: UIActivityIndicatorView?

    // MARK: -

    @IBInspectable var image: UIImage? {
        didSet {
            self.updateImageView()
        }
    }

    @IBInspectable var title: String? {
        get {
            return self.titleLabel.text
        }

        set {
            self.titleLabel.text = newValue
        }
    }

    @IBInspectable var message: String? {
        get {
            return self.messageLabel.text
        }

        set {
            self.messageLabel.text = newValue
        }
    }

    @IBInspectable var textColor: UIColor = Colors.blackText {
        didSet {
            self.titleLabel.textColor = self.textColor
            self.messageLabel.textColor = self.textColor
        }
    }

    @IBInspectable var activityIndicatorColor: UIColor = Colors.primary {
        didSet {
            self.activityIndicatorView?.color = self.activityIndicatorColor
        }
    }

    var titleFont = Fonts.medium(ofSize: 20.0) {
        didSet {
            self.titleLabel.font = self.titleFont
        }
    }

    var messageFont = Fonts.regular(ofSize: 16.0) {
        didSet {
            self.messageLabel.font = self.messageFont
        }
    }

    var action: EmptyStateAction? {
        didSet {
            self.updateActionButton()
        }
    }

    var isActivityIndicatorHidden: Bool {
        return self.activityIndicatorView?.isHidden ?? true
    }

    // MARK: - Initializers

    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)

        self.initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.initialize()
    }

    // MARK: - Instance Methods

    @objc private func onActionButtonTouchUpInside(_ sender: UIButton) {
        self.action?.onActionButtonClicked()
    }

    // MARK: -

    private func initialize() {
        self.titleLabel.font = self.titleFont
        self.titleLabel.textColor = self.textColor
        self.titleLabel.numberOfLines = 2
        self.titleLabel.textAlignment = .center
        self.titleLabel.isUserInteractionEnabled = false

        self.addSubview(self.titleLabel)

        self.messageLabel.font = self.messageFont
        self.messageLabel.textColor = self.textColor
        self.messageLabel.numberOfLines = 0
        self.messageLabel.textAlignment = .center
        self.messageLabel.isUserInteractionEnabled = false

        self.addSubview(self.messageLabel)

        self.titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(32)
            make.trailing.equalTo(self).offset(-32)
        }

        self.messageLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(self).offset(18)
            make.trailing.equalTo(self).offset(-18)
            make.bottom.equalTo(self.snp.centerY).offset(-8)
        }

        self.backgroundColor = Colors.whiteBackground
    }

    private func updateActionButton() {
        self.actionButton?.removeFromSuperview()
        self.actionButton = nil

        if let action = self.action {
            let actionButton = PrimaryButton()

            self.addSubview(actionButton)
            self.actionButton = actionButton

            actionButton.setTitle(action.title, for: .normal)

            actionButton.addTarget(self,
                                   action: #selector(self.onActionButtonTouchUpInside(_:)),
                                   for: .touchUpInside)

            actionButton.contentEdgeInsets = UIEdgeInsets(top: 0.0, left: 48.0, bottom: 0.0, right: 48.0)

            actionButton.snp.makeConstraints { make in
                make.top.equalTo(self.messageLabel.snp.bottom).offset(24)
                make.centerX.equalTo(self)
                make.height.equalTo(48)
            }

            if !self.isActivityIndicatorHidden {
                actionButton.isEnabled = true
                actionButton.isHidden = false
            }
        }
    }

    private func updateImageView() {
        if let image = self.image {
            if let imageView = self.imageView {
                imageView.image = image
                imageView.isHidden = false
            } else {
                let imageView = UIImageView()

                imageView.image = image
                imageView.contentMode = .scaleAspectFill

                self.addSubview(imageView)

                self.imageView = imageView

                imageView.snp.makeConstraints { make in
                    make.bottom.equalTo(self.titleLabel.snp.top).offset(-32)
                    make.centerX.equalTo(self)
                }
            }
        } else {
            self.imageView?.isHidden = true
        }
    }

    // MARK: -

    func showActivityIndicator() {
        if self.activityIndicatorView == nil {
            let activityIndicatorView = UIActivityIndicatorView(style: .large)

            activityIndicatorView.color = self.activityIndicatorColor
            activityIndicatorView.hidesWhenStopped = true

            self.addSubview(activityIndicatorView)
            self.activityIndicatorView = activityIndicatorView

            activityIndicatorView.snp.makeConstraints { make in
                make.bottom.equalTo(self.messageLabel.snp.top).offset(-16)
                make.centerX.equalTo(self)
            }
        }

        if let actionButton = self.actionButton {
            actionButton.isEnabled = false
            actionButton.isHidden = true
        }

        let activityIndicatorView = self.activityIndicatorView!

        if !activityIndicatorView.isAnimating {
            activityIndicatorView.startAnimating()
        }
    }

    func hideActivityIndicator() {
        if let actionButton = self.actionButton {
            actionButton.isEnabled = true
            actionButton.isHidden = false
        }

        self.activityIndicatorView?.stopAnimating()
    }
}
