//
//  CLButton.swift
//  Cat List
//
//  Created by Jaffer Sheriff U on 23/10/22.
//

import UIKit


class CLButton: UIButton {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(backgroundColor : UIColor , title : String , image : UIImage? = nil) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
        configure()
        if let image = image {
            configureImageView(withImage: image)
        }
    }
    
    
    private func configure(){
        layer.cornerRadius = 10
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    
    private func configureImageView(withImage image : UIImage){
        setImage(image, for: .normal)
        setImage(image, for: .highlighted)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        tintColor = .white
    }
    
}
