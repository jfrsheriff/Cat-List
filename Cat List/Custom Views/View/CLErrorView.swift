//
//  CLErrorView.swift
//  Cat List
//
//  Created by Jaffer Sheriff U on 27/10/22.
//

import UIKit

class CLErrorView: UIView {

    private let title : String
    private let message : String
    weak var delegate : ErrorViewDelegate?
    
    private let imageView = UIImageView(image:SystemImages.error)
    private let titleLabel : CLTitleLabel = CLTitleLabel(txtAlignment: .center, fontSize: 30)
    private let descriptionLabel : CLBodyLabel = CLBodyLabel(txtAlignment: .center)
    private let reloadButton : CLButton = {
        let image = SystemImages.reload
        let button = CLButton(backgroundColor: .systemBlue, title: StringConstants.reload, image: image )
        return button
    }()
    
    
    init(title : String, message : String , delegate : ErrorViewDelegate?) {
        self.title = title
        self.message = message
        self.delegate = delegate
        super.init(frame: .zero)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(){
        addSubviews(imageView,titleLabel,descriptionLabel,reloadButton)
        
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .systemRed
        
        titleLabel.text = title
        descriptionLabel.text = message
        reloadButton.addTarget(self, action: #selector(reloadAction), for: .touchUpInside)

        let titlePadding : CGFloat = 10
        let descriptionLeftRightPadding : CGFloat = 20
        let buttonPadding : CGFloat = 50
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),
        
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: titlePadding),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -titlePadding),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: titlePadding),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: descriptionLeftRightPadding),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -descriptionLeftRightPadding),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: titlePadding),
            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            reloadButton.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.leadingAnchor),
            reloadButton.trailingAnchor.constraint(lessThanOrEqualTo: titleLabel.trailingAnchor),
            reloadButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: buttonPadding),
            reloadButton.widthAnchor.constraint(equalToConstant: 220),
            reloadButton.heightAnchor.constraint(equalToConstant: 80),
            reloadButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        
        ])
    }
    
    
    @objc func reloadAction(){
        delegate?.reload()
    }
    
    
}

