//
//  SearchRouter.swift
//  iOSArchitecturesDemo
//
//  Created by Антон Васильченко on 22.11.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit

protocol SearchRouterInput {
    
    func openDetails(for app: ITunesApp)
    func openAppInITunes(_ app: ITunesApp)
    
    func openDetails(for song: ITunesSong)
    func openAppInITunes(_ song: ITunesSong)

}

final class SearchRouter: SearchRouterInput {
    func openDetails(for song: ITunesSong) {
        let songDetaillViewController = SongDetailViewController(song: song)
        self.viewController?.navigationController?.pushViewController(songDetaillViewController, animated: true)
    }
    
    func openAppInITunes(_ song: ITunesSong) {
        guard let urlString = song.trackUrl, let url = URL(string: urlString) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    
    weak var viewController: UIViewController?
    
    func openDetails(for app: ITunesApp) {
        let appDetaillViewController = AppDetailViewController(app: app)
        self.viewController?.navigationController?.pushViewController(appDetaillViewController, animated: true)
    }
    
    func openAppInITunes(_ app: ITunesApp) {
        guard let urlString = app.appUrl, let url = URL(string: urlString) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

