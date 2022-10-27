//
//  UIHelper.swift
//  Cat List
//
//  Created by Jaffer Sheriff U on 23/10/22.
//

import UIKit

struct UIHelper{
    
    static let appThemeColor : UIColor = .systemGreen
    
    static func createThreeColumnFlowLayout(for view : UIView) -> UICollectionViewFlowLayout {
        let totalWidth = view.bounds.width
        let padding : CGFloat = 10
        let minimumItemSpacing : CGFloat = 8
        let availableWidth = totalWidth - 2 * padding - 2 * minimumItemSpacing
        let itemWidth = floor(availableWidth / 3.0) - 2
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 25)
        
        return flowLayout
    }
    
}
