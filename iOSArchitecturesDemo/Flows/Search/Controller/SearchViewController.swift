//
//  ViewController.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 14.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {
    
    // MARK: - Private Properties
    
    let searchMode = SearchTypeMode.shared
    
    private let presenter: SearchViewOutput
    
    private var searchView: SearchView {
        return self.view as! SearchView
    }
    
    private let searchService = ITunesSearchService()
    
    var searchResults = [ITunesApp]() {
        didSet {
            searchView.tableView.isHidden = false
            searchView.tableView.reloadData()
            searchView.searchBar.resignFirstResponder()
        }
    }
    
    var searchSongResults = [ITunesSong]() {
        didSet {
            searchView.tableView.isHidden = false
            searchView.tableView.reloadData()
            searchView.searchBar.resignFirstResponder()
        }
    }
    
    init(presenter: SearchViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.view = SearchView()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.searchView.searchBar.delegate = self
        self.searchView.tableView.register(AppCell.self, forCellReuseIdentifier: "AppCell")
        self.searchView.tableView.register(SongCell.self, forCellReuseIdentifier: "SongCell")
        self.searchView.tableView.delegate = self
        self.searchView.tableView.dataSource = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.throbber(show: false)
    }
    
    // MARK: - Private
    
    
    
    //    private func requestApps(with query: String) {
    //        self.throbber(show: true)
    //        self.searchResults = []
    //        self.searchView.tableView.reloadData()
    //
    //        self.searchService.getApps(forQuery: query) { [weak self] result in
    //            guard let self = self else { return }
    //            self.throbber(show: false)
    //            result
    //                .withValue { apps in
    //                    guard !apps.isEmpty else {
    //                        self.searchResults = []
    //                        self.showNoResults()
    //                        return
    //                    }
    //                    self.hideNoResults()
    //                    self.searchResults = apps
    //
    //                    self.searchView.tableView.isHidden = false
    //                    self.searchView.tableView.reloadData()
    //
    //                    self.searchView.searchBar.resignFirstResponder()
    //                }
    //                .withError {
    //                    self.showError(error: $0)
    //                }
    //        }
    //    }
}

//MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch searchMode.mode {
        case .app:
            return searchResults.count
        case .song:
            return searchSongResults.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch searchMode.mode {
        case .app:
            let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: "AppCell", for: indexPath)
                guard let cell = dequeuedCell as? AppCell else {
                    return dequeuedCell
                }
                let app = self.searchResults[indexPath.row]
                let cellModel = AppCellModelFactory.cellModel(from: app)
                cell.configure(with: cellModel)
            return cell

        case .song:
            let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath)
            guard let cell = dequeuedCell as? SongCell else {
                return dequeuedCell
            }
            let song = self.searchSongResults[indexPath.row]
            let cellModel = SongCellModelFactory.cellModel(from: song)
            cell.configure(with: cellModel)
            return cell
        }

    }
}

//MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch searchMode.mode {
        case .app:
            tableView.deselectRow(at: indexPath, animated: true)
            let app = searchResults[indexPath.row]
            let appDetaillViewController = AppDetailViewController(app: app)
            appDetaillViewController.app = app
            presenter.viewDidSelectApp(app: app)

        case .song:
            tableView.deselectRow(at: indexPath, animated: true)
            let song = searchSongResults[indexPath.row]
            let songDetaillViewController = SongDetailViewController(song: song)
            songDetaillViewController.song = song
            presenter.viewDidSelectSong(song: song)

        }

        
        //        navigationController?.pushViewController(appDetaillViewController, animated: true)
    }
}

//MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else {
            searchBar.resignFirstResponder()
            return
        }
        if query.count == 0 {
            searchBar.resignFirstResponder()
            return
        }
        
        presenter.viewDidSearch(with: query)
        //        self.requestApps(with: query)
    }
}

extension SearchViewController: SearchViewInput {
    func throbber(show: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = show
    }
    
    func showError(error: Error) {
        let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showNoResults() {
        self.searchView.emptyResultView.isHidden = false
    }
    
    func hideNoResults() {
        self.searchView.emptyResultView.isHidden = true
    }
}
