//
//  SearchInteractor.swift
//  iOSArchitecturesDemo
//
//  Created by Антон Васильченко on 22.11.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import Foundation
import Alamofire

protocol SearchInteractorInput {
    
    func requestApps(with query: String, completion: @escaping (Result<[ITunesApp]>) -> Void)
    func requestSongs(with query: String, completion: @escaping (Result<[ITunesSong]>) -> Void)
}

final class SearchInteractor: SearchInteractorInput {
    
    private let searchService = ITunesSearchService()
    
    func requestApps(with query: String, completion: @escaping (Result<[ITunesApp]>) -> Void) {
        self.searchService.getApps(forQuery: query, then: completion)
    }
    
    func requestSongs(with query: String, completion: @escaping (Result<[ITunesSong]>) -> Void) {
        self.searchService.getSongs(forQuery: query, completion: completion)

    }
}



