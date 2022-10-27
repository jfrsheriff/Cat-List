//
//  CLTabBarVC.swift
//  Cat List
//
//  Created by Jaffer Sheriff U on 24/10/22.
//

import UIKit

class CLTabBarVC : UITabBarController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = UIHelper.appThemeColor
        self.viewControllers = [createCatBreedListVC(),createProfileVC()]
    }
    
    
    private func createCatBreedListVC() -> UIViewController {
        let catBreedListVC = ScreenFactory.getCatBreedListVC()
        catBreedListVC.tabBarItem = UITabBarItem(title: StringConstants.catBreedListVCTitle, image: SystemImages.listDash, tag: 0)
        return UINavigationController(rootViewController:catBreedListVC)
    }
    
    
    private func createProfileVC() -> UIViewController {
        let aboutVC = ScreenFactory.getProfileVC()
        aboutVC.tabBarItem = UITabBarItem(title:StringConstants.profilTabBarTitle , image: SystemImages.person , tag: 1)
        return UINavigationController(rootViewController:aboutVC)
    }
    
}
