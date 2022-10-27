//
//  ListProtocol.swift
//  Cat List
//
//  Created by Jaffer Sheriff U on 27/10/22.
//

import Foundation

protocol CatBreedViewModelProtocol{
    
    var request : APIRequestProtocol {get set}
    var manager : RequestManagerProtocol {get set}
    var view : CatBreedViewProtocol? {get set}
    
    func fetchListModel()
    func searchModelWith(searchText : String)
    func itemSelectedAt(indexPath : IndexPath)
}


protocol CatBreedViewProtocol {
    func updateUI(with listModel : [ListModel])
    func showError(title : String , message : String , buttonText : String)
    func presentSafariVC(for url : URL)
}
