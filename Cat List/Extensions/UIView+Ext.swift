//
//  UIView+Ext.swift
//  Cat List
//
//  Created by Jaffer Sheriff U on 23/10/22.
//

import UIKit

extension UIView{
    
    
    func pinToEdges(of superView : UIView, padding : CGFloat = 0){
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superView.leadingAnchor,constant: padding),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor,constant: -padding),
            topAnchor.constraint(equalTo: superView.topAnchor,constant: padding),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor,constant: -padding),
        ])
    }
    
    
    func addSubviews(_ views : UIView...){
        views.forEach { addSubview($0) }
    }
    
}
