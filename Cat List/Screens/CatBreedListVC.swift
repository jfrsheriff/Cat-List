//
//  CatBreedListVC.swift
//  Cat List
//
//  Created by Jaffer Sheriff U on 22/10/22.
//

import UIKit

final class CatBreedListVC: UIViewController {
    
    let viewModel : CatBreedViewModelProtocol
    
    private var collectionView : UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, ListModel>?

    init(viewModel: CatBreedViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureSearchController()
        configureCollectionView()
        fetchCatBreeds()
        configureDataSource()
    }
    
    
    private func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    private func configureSearchController(){
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = StringConstants.catBreedListSearchBarPlaceHolder
        searchController.searchBar.isHidden = true
        navigationItem.searchController = searchController
    }
    
    
    private func configureCollectionView(){
        let collectionViewFrame = CGRect(x: view.bounds.minX, y: view.bounds.minY, width: view.bounds.size.width, height: view.bounds.size.height -  (self.tabBarController?.tabBar.frame.size.height ?? 0))
        
        collectionView = UICollectionView(frame: collectionViewFrame , collectionViewLayout: UIHelper.createThreeColumnFlowLayout(for: view))
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CLCatBreedListCell.self, forCellWithReuseIdentifier: CLCatBreedListCell.reuseId)
        view.addSubview(collectionView)
    }
    
    
    private func fetchCatBreeds(){
        showLoading()
        viewModel.fetchListModel()
    }
    
    
    private func configureDataSource(){
        guard let collectionView = collectionView else {return}
        dataSource = UICollectionViewDiffableDataSource<Section,ListModel>(collectionView: collectionView, cellProvider: { collectionView, indexPath, listModel in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CLCatBreedListCell.reuseId, for: indexPath) as! CLCatBreedListCell
            cell.set(model: listModel)
            return cell
        })
    }
    
    
    private func refreshData(_ model: [ListModel]) {
        var snapShot = NSDiffableDataSourceSnapshot<Section,ListModel>()
        snapShot.appendSections([.main])
        snapShot.appendItems(model)
        DispatchQueue.main.async {
            self.dataSource?.apply(snapShot,animatingDifferences: true)
        }
    }
    
    private func hideSearchBarInMainThread() {
        DispatchQueue.main.async {self.navigationItem.searchController?.searchBar.isHidden = true}
    }
    
    
    private func unHideSearchBarInMainThread() {
        DispatchQueue.main.async {self.navigationItem.searchController?.searchBar.isHidden = false}
    }
    
}

extension CatBreedListVC : UISearchResultsUpdating, UICollectionViewDelegate{
    
    
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.searchModelWith(searchText: searchController.searchBar.text ?? "")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.itemSelectedAt(indexPath: indexPath)
    }
    
}

extension CatBreedListVC : CatBreedViewProtocol{
    
    
    func updateUI(with listModel: [ListModel]) {
        hideLoading()
        unHideSearchBarInMainThread()
        refreshData(listModel)
    }
    
    
    func showError(title: String, message: String, buttonText: String) {
        hideLoading()
        hideSearchBarInMainThread()
        presentAlertOnMainThread(title: title, message: message, buttonTitle: buttonText)
        showErrorMessage(title: title, message: message, buttonText: buttonText,delegate: self)
    }
    
    
    func presentSafariVC(for url: URL) {
        presentSafariVC(with: url)
    }
}


extension CatBreedListVC : ErrorViewDelegate{
    func reload() {
        hideErrorMessage()
        fetchCatBreeds()
    }
}
