//
//  CLCatBreedListCell.swift
//  Cat List
//
//  Created by Jaffer Sheriff U on 22/10/22.
//

import UIKit

protocol ImageDownloadingProtocol : AnyObject {
    func shouldSetDownloadedImage(forUrl urlStr: String) -> Bool
}

class CLCatBreedListCell : UICollectionViewCell{
    
    static let reuseId = "CatbreedListCell"
    
    let catImageView : ImageViewProtocol = ViewFactory.getImageView()
    let catBreedNameLabel = CLTitleLabel(txtAlignment: .center, fontSize: 14)
    var lastDownloadedImageUrl : String = ""
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(){        
        addSubview(catImageView)
        addSubview(catBreedNameLabel)
        catImageView.delegate = self
        
        let padding: CGFloat = 0
        
        NSLayoutConstraint.activate([
            catImageView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor,constant: padding),
            catImageView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor,constant: -padding),
            catImageView.topAnchor.constraint(equalTo: topAnchor,constant: padding),
            catImageView.widthAnchor.constraint(equalTo: widthAnchor,constant: -2*padding),
            catImageView.heightAnchor.constraint(equalTo: catImageView.widthAnchor),
            
            catBreedNameLabel.topAnchor.constraint(equalTo: catImageView.bottomAnchor, constant: padding),
            catBreedNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: padding),
            catBreedNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -padding),
            catBreedNameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        catImageView.prepareForReuse()
    }
    
    func set(model : ListModel){
        catBreedNameLabel.text = model.name
        lastDownloadedImageUrl = model.imgUrl ?? ""
        catImageView.downloadImageFrom(urlStr: model.imgUrl)
    }
    
}


extension CLCatBreedListCell : ImageDownloadingProtocol{
    func shouldSetDownloadedImage(forUrl urlStr: String) -> Bool {
        return lastDownloadedImageUrl == urlStr
    }
}
