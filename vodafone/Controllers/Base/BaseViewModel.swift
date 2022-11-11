//
//  BaseViewModel.swift
//  vodafone
//
//  Created by canberk çığ on 11.11.2022.
//

import Foundation
import UIKit
import PagingTableView
import CRRefresh
import MBProgressHUD

enum MediaType: String {
    case movie = "movie", music = "musicVideo", app = "software", book = "ebook"
}

class BaseViewModel: NSObject {
    
    var viewController: BaseViewController?
    
    @IBOutlet weak var hobbiesCollectionView: UICollectionView!
    
    let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    var cellId = "hobbiesCell"
    var media: MediaType? = .movie
    var numberOfItemOnPage: Int = 25
    let searchController = UISearchController(searchResultsController: nil)
    var searchResults: SearchResponse?
    
    func setData(vc: BaseViewController, title: String, media: MediaType) {
        self.viewController = vc
        self.media = media
        setSearchBar()
        setCollectionViewProperties()
        setRightBarButton()
        vc.setNavigationBar(title: title)
        
    }
    
    func setRightBarButton() {
        let rightBarButton = UIButton(type: .custom)
        rightBarButton.contentMode = .scaleAspectFit
        rightBarButton.setImage(UIImage(named: "ic_filter"), for: .normal)
        rightBarButton.setTitle(" Filter", for: .normal)
        rightBarButton.setTitleColor(.black, for: .normal)
        rightBarButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(filterTapped)))
        viewController?.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBarButton)
        viewController?.navigationItem.rightBarButtonItem?.style = .plain
    }
    
    func setCollectionViewProperties() {
        hobbiesCollectionView.register(UINib(nibName: "SearchResultCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellId)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10.0, bottom: 0, right: 10.0)
        hobbiesCollectionView.setCollectionViewLayout(layout, animated: true)
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        hobbiesCollectionView.backgroundColor = .white
        
        hobbiesCollectionView.cr.addFootRefresh(animator: NormalFooterAnimator()) { [weak self] in
            self?.loadMore()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                self?.hobbiesCollectionView.cr.endLoadingMore()
                self?.hobbiesCollectionView.cr.noticeNoMoreData()
                self?.hobbiesCollectionView.cr.resetNoMore()
            })
        }
    }
    
    @objc func filterTapped() {
        GlobalHelper.pushController(id: "FilterViewController", self.viewController ?? UIViewController()) { (vc: FilterViewController) in
            vc.data = searchResults?.results
            vc.filterViewModel.delegate = self
        }
    }
    
    //MARK: - Search Bar -
    func setSearchBar() {
        searchController.searchBar.delegate = self
        searchController.setSearchController()
        viewController?.navigationItem.searchController = searchController
    }
            
    private func loadMore() {
        numberOfItemOnPage += 25
        refreshText()
    }
}

//MARK: - CollectionView Delegate & DataSources -
extension BaseViewModel: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize (width: (collectionView.frame.size.width - 30 ) / 2 , height: (collectionView.frame.size.width) / 1.75)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchController.isActive == true && searchController.searchBar.text != "" {
            if searchResults?.results?.count == 0 {
                collectionView.setEmptyMessage("No results", "no_result")
                return 0
            } else {
                collectionView.restore()
                return searchResults?.results?.count ?? 0
            }
        } else {
            collectionView.setEmptyMessage("Find something", "find")
            return 0
        }
    }
}


extension BaseViewModel: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath as IndexPath) as! SearchResultCollectionViewCell
        if searchController.isActive == true && searchController.searchBar.text != "" {
            let hobbiesListHeaderViewModel = SearchResultCollectionViewCellModel.init(result: searchResults?.results?[indexPath.row] ?? .init())
            cell.dataSource = hobbiesListHeaderViewModel
            cell.reloadData()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch media {
        case .movie:
            GlobalHelper.pushController(id: "MediaDetailScreenViewController", self.viewController ?? UIViewController()) { (vc: MediaDetailScreenViewController) in
                vc.data = searchResults?.results?[indexPath.row]
            }
        case .music:
            GlobalHelper.pushController(id: "MediaDetailScreenViewController", self.viewController ?? UIViewController()) { (vc: MediaDetailScreenViewController) in
                vc.data = searchResults?.results?[indexPath.row]
            }
        case .app:
            GlobalHelper.pushController(id: "AppDetailScreenViewController", self.viewController ?? UIViewController()) { (vc: AppDetailScreenViewController) in
                vc.data = searchResults?.results?[indexPath.row]
            }
        case .book:
            GlobalHelper.pushController(id: "BookDetailScreenViewController", self.viewController ?? UIViewController()) { (vc: BookDetailScreenViewController) in
                vc.data = searchResults?.results?[indexPath.row]
            }
        case .none:
            print("none")
        }
    }
    
}

//MARK: - SearchBar Delegate -
extension BaseViewModel: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        hobbiesCollectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.refreshText), object: nil)
        self.perform(#selector(self.refreshText), with: nil, afterDelay: 0.5)
    }
    
    @objc func refreshText() {
        guard let text = searchController.searchBar.text else { return }
        searchAPI(text: text)
    }
    
    func searchAPI(text: String) {
        API.shared.getItems(keyword: text, limit: numberOfItemOnPage, mediaType: media?.rawValue ?? "") { responseModel in
            self.searchResults = responseModel
            self.hobbiesCollectionView.reloadData()
        }
    }
}

extension BaseViewModel: ApplySelectedDelegate {
    func selectedCategories(categories: [String]) {
        let a = searchResults?.results?.filter{ categories.contains($0.primaryGenreName ?? "") }
        searchResults?.results = a
        hobbiesCollectionView.reloadData()
    }
}
