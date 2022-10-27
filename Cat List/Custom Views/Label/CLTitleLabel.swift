//
//  CLTitleLabel.swift
//  Cat List
//
//  Created by Jaffer Sheriff U on 23/10/22.
//

import UIKit


class CLTitleLabel: UILabel {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(txtAlignment : NSTextAlignment, fontSize : CGFloat){
        super.init(frame: .zero)
        self.textAlignment = txtAlignment
        font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        configure()
    }
    
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
    }

    
}
