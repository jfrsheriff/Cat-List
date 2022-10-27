//
//  CLImageView.swift
//  Cat List
//
//  Created by Jaffer Sheriff U on 22/10/22.
//

import UIKit

protocol ImageViewProtocol : UIView,AnyObject {
    var delegate : ImageDownloadingProtocol? {get set}
    func downloadImageFrom(urlStr: String?)
    func prepareForReuse()
}

class CLImageView : UIImageView{
    
    private let placeHolderImage: UIImage?
    private let requestManager : RequestManager
    weak var delegate : ImageDownloadingProtocol?
    
    private var activityIndicator : UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    
    init(requestManager: RequestManager,
         placeHolderImage : UIImage? = Images.collectionViewCellPlaceHolderImage) {
        self.requestManager = requestManager
        self.placeHolderImage = placeHolderImage
        super.init(frame: .zero)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setPlaceHolderAndStartLoading(){
        image = placeHolderImage
        contentMode = .scaleAspectFit
        configureActivityIndicator()
    }
    
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        layer.cornerRadius = 10
        tintColor = .label
        setPlaceHolderAndStartLoading()
    }
    
    
    private func configureActivityIndicator(){
        addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        activityIndicator.startAnimating()
    }
    
    
    private func updateUIWith(catImageData : Data , fromUrlString urlStr: String){
        guard let downloadedImage = UIImage(data: catImageData), let delegate = self.delegate else {
            configureForFailedImageDowload()
            return
        }
        
        if delegate.shouldSetDownloadedImage(forUrl: urlStr) {
            self.configure(catImage: downloadedImage)
        }
    }
    
    
    private func configureForFailedImageDowload(){
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.image = self.placeHolderImage
            self.contentMode = .scaleAspectFit
        }
    }
    
    
    private func configure(catImage : UIImage){
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.contentMode = .scaleToFill
            self.image = catImage
            self.alpha = 0.4
            UIView.animate(withDuration: 0.4) {
                self.alpha = 1
            }
        }
    }
    
    
}

extension CLImageView : ImageViewProtocol{
    
    
    func prepareForReuse() {
        setPlaceHolderAndStartLoading()
    }
    
    
    func downloadImageFrom(urlStr: String?) {
        guard let urlStr = urlStr else {
            configureForFailedImageDowload()
            return
        }
        Task{
            do{
                let data = try await requestManager.downloadImage(from: urlStr)
                updateUIWith(catImageData: data, fromUrlString : urlStr )
            }catch{
                configureForFailedImageDowload()
            }
        }
    }
    
}
