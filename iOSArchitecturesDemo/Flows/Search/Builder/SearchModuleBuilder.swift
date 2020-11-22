//
//  SearchModuleBuilder.swift
//  iOSArchitecturesDemo
//
//  Created by Veaceslav Chirita on 11/12/20.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit


final class SearchModuleBuilder {
    
    static func build() -> (UIViewController & SearchViewInput) {
        let router = SearchRouter()
        let interactor = SearchInteractor()
        let presenter = Presenter(interactor: interactor, router: router)
        let viewController = SearchViewController(presenter: presenter)
        
        presenter.viewInput = viewController
        router.viewController = viewController
        
        return viewController
    }
}

