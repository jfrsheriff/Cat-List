//
//  CatBreedViewModel.swift
//  Cat List
//
//  Created by Jaffer Sheriff U on 24/10/22.
//

import Foundation

final class CatBreedViewModel{
    
    var request: APIRequestProtocol
    var manager: RequestManagerProtocol
    var view: CatBreedViewProtocol?
    
    
    private var catBreeds : CatBreeds = []
    private var filteredCatBreeds : CatBreeds = []
    private var isSearching = false
    
    init(request: APIRequestProtocol, manager: RequestManagerProtocol, view : CatBreedViewProtocol?) {
        self.request = request
        self.manager = manager
        self.view = view
    }

    
    private func updateView(with catBreeds : CatBreeds){
        let listModel : [ListModel] = catBreeds.map { catBreed in
            ListModel(name: catBreed.name, imgUrl: catBreed.image?.url)
        }
        DispatchQueue.main.async { self.view?.updateUI(with: listModel)}
    }
}


extension CatBreedViewModel : CatBreedViewModelProtocol {
    
    func fetchListModel(){
        Task{
            do{
                let catBreeds : CatBreeds = try await manager.perform(request)
                self.catBreeds = catBreeds
                updateView(with: catBreeds)
            }catch{
                view?.showError(title : StringConstants.sorry ,
                                message : StringConstants.somethingWentWrong ,
                                buttonText: StringConstants.ok)
            }
        }
    }
    
    
    func searchModelWith(searchText: String) {
        guard !searchText.isEmpty else {
            isSearching = false
            filteredCatBreeds.removeAll()
            updateView(with: catBreeds)
            return
        }
        isSearching = true
        filteredCatBreeds = catBreeds.filter{$0.name.lowercased().contains(searchText.lowercased())}
        updateView(with: filteredCatBreeds)
    }
 
    
    func itemSelectedAt(indexPath: IndexPath) {
        let destinationArray = isSearching ? filteredCatBreeds : catBreeds
        let item = destinationArray[indexPath.item]
        
        guard let wikiUrlStr = item.wikipediaUrl, let wikiUrl = URL(string: wikiUrlStr) else {
            guard let cfaUrlStr = item.cfaUrl , let cfaUrl = URL(string: cfaUrlStr) else {
                view?.showError(title: StringConstants.sorry , message: StringConstants.noPageFoundForSelectedBreed, buttonText: StringConstants.ok)
                return
            }
            view?.presentSafariVC(for: cfaUrl)
            return
        }
        view?.presentSafariVC(for: wikiUrl)
    }
    
}
