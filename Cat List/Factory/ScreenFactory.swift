//
//  ScreenFactory.swift
//  Cat List
//
//  Created by Jaffer Sheriff U on 22/10/22.
//

import UIKit

enum ScreenFactory {
    
    
    static func getCatBreedListVC() -> UIViewController {
        let catBreedRequest = CatBreedListRequest()
        let requestManager = RequestManager()
        
        let viewModel = CatBreedViewModel(request: catBreedRequest, manager: requestManager, view: nil)
        let catBreedListVC = CatBreedListVC(viewModel: viewModel)
        viewModel.view = catBreedListVC
        
        catBreedListVC.title = StringConstants.catBreedListVCTitle
        return catBreedListVC
    }
    
    
    static func getProfileVC() -> UIViewController {
        let profileVc = ProfileVC()
        profileVc.title = StringConstants.profileVCTitle
        return profileVc
    }
    
    
    static func getRootViewController() -> UIViewController{
        return CLTabBarVC()
    }
    
}



enum ViewFactory{
    
    
    static func getImageView() -> ImageViewProtocol {
        let clImageView = CLImageView(requestManager: RequestManager())
        return clImageView
    }
    
    
}
