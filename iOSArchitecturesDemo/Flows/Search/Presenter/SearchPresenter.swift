//
//  Presenter.swift
//  iOSArchitecturesDemo
//
//  Created by Veaceslav Chirita on 11/12/20.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit

protocol SearchViewInput: class {
    var searchResults: [ITunesApp] { get set }
    var searchSongResults: [ITunesSong] { get set }
    
    func showError(error: Error)
    func showNoResults()
    func hideNoResults()
    func throbber(show: Bool)
}

protocol SearchViewOutput: class {
    func viewDidSearch(with query: String)
    func viewDidSelectApp(app: ITunesApp)
    func viewDidSelectSong(song: ITunesSong)
}

class Presenter {
    
    weak var viewInput: (UIViewController & SearchViewInput)?
    private let searchService = ITunesSearchService()
    let searchMode = SearchTypeMode.shared

    
    
    
    
    private func requestApps(with query: String) {
        searchService.getApps(forQuery: query) { [weak self] (result) in
            guard let self = self else { return }
            
            self.viewInput?.throbber(show: false)
            result.withValue { (apps) in
                guard !apps.isEmpty else {
                    self.viewInput?.showNoResults()
                    
                    return
                }
                
                self.viewInput?.hideNoResults()
                self.viewInput?.searchResults = apps
            }.withError { (error) in
                self.viewInput?.showError(error: error)
            }
            
        }
    }
    
    private func requestSongs(with query: String) {
        searchService.getSongs(forQuery: query) { [weak self] (result) in
            guard let self = self else { return }
            
            self.viewInput?.throbber(show: false)
            result.withValue { (songs) in
                guard !songs.isEmpty else {
                    self.viewInput?.showNoResults()
                    
                    return
                }
                
                self.viewInput?.hideNoResults()
                self.viewInput?.searchSongResults = songs
            }.withError { (error) in
                self.viewInput?.showError(error: error)
            }
            
        }
    }
    
    private func openAppDetails(with app: ITunesApp) {
        let appDetailViewController = AppDetailViewController(app: app)
        viewInput?.navigationController?.pushViewController(appDetailViewController, animated: true)
    }
    
    private func openSongDetails(with song: ITunesSong) {
        let songDetailViewController = SongDetailViewController(song: song)
        viewInput?.navigationController?.pushViewController(songDetailViewController, animated: true)
    }
    
}

extension Presenter: SearchViewOutput {
    func viewDidSelectSong(song: ITunesSong) {
        openSongDetails(with: song)
    }
    
    func viewDidSearch(with query: String) {
        viewInput?.throbber(show: true)
        if searchMode.mode == .app {
            requestApps(with: query)
            
        } else if searchMode.mode == .song {
            requestSongs(with: query)
        }
        
    }
    
    func viewDidSelectApp(app: ITunesApp) {
        openAppDetails(with: app)
    }
    
    
}
