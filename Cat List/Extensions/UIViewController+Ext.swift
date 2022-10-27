//
//  UIViewController+Ext.swift
//  Cat List
//
//  Created by Jaffer Sheriff U on 23/10/22.
//

import UIKit
import SafariServices

fileprivate var containerView : UIView?

protocol ErrorViewDelegate : AnyObject {
    func reload()
}


extension UIViewController{
    
    
    func presentAlertOnMainThread(title : String, message : String , buttonTitle : String) {
        DispatchQueue.main.async {
            let alertVC = CLAlertVC(alertTitle: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    
    func presentSafariVC(with url : URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = UIHelper.appThemeColor
        safariVC.modalPresentationStyle = .formSheet
        self.present(safariVC, animated: true)
    }
    
    
    
    func showLoading(){
        let conView = UIView.init(frame: view.bounds)
        conView.backgroundColor = .systemBackground
        conView.alpha = 0
        view.addSubview(conView)
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        conView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        UIView.animate(withDuration: 0.5) {
            conView.alpha = 0.8
        }
        activityIndicator.startAnimating()
        containerView = conView
    }
    
    
    func hideLoading(){
        DispatchQueue.main.async {
            containerView?.removeFromSuperview()
            containerView = nil
        }
    }
    
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
    
    
    func add(childVC : UIViewController , to containerView : UIView) {
        self.addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    
    func showErrorMessage(title : String , message : String, buttonText : String , delegate : ErrorViewDelegate?){
        DispatchQueue.main.async {
            
            let conView = UIView.init(frame: self.view.bounds)
            conView.backgroundColor = .systemBackground
            self.view.addSubview(conView)
            containerView = conView
            
            let errorView = CLErrorView(title: title, message: message, delegate : delegate)
            let height : CGFloat = 300
            errorView.frame = CGRect(x: 0, y: conView.center.y - (height/2.0) , width: conView.bounds.width, height: height)
            conView.addSubview(errorView)
            
            conView.bringSubviewToFront(errorView)
        }
    }
    
    
    func hideErrorMessage(){
        containerView?.removeFromSuperview()
        containerView = nil
    }
    
}

