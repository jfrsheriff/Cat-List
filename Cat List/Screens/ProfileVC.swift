//
//  ProfileVC.swift
//  Cat List
//
//  Created by Jaffer Sheriff U on 24/10/22.
//

import UIKit
import SwiftUI

class ProfileVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        let swiftUIController = UIHostingController(rootView: ProfileView())
        add(childVC: swiftUIController, to: view)
    }

}
