//
//  SearchModuleBuilder.swift
//  iOSArchitecturesDemo
//
//  Created by Veaceslav Chirita on 11/12/20.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit

class SearchModuleBuilder {
    static func build() -> (UIViewController & SearchViewInput) {
        let presenter = Presenter()
        let viewController = SearchViewController(presenter: presenter)
        presenter.viewInput = viewController
        return viewController
    }
    
}
