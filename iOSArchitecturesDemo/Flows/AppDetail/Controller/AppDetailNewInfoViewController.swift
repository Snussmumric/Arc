//
//  AppDetailNewInfoViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Антон Васильченко on 19.11.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit

class AppDetailNewInfoViewController: UIViewController {
    private let app: ITunesApp
    
    private let imageDownloader = ImageDownloader()
    
    private var appDetailHeaderView: AppDetailNewInfoView {
        return self.view as! AppDetailNewInfoView
    }
    
    init(app: ITunesApp) {
        self.app = app
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = AppDetailNewInfoView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillData()
    }
    
    private func fillData() {
        
        appDetailHeaderView.versionNumberLabel.text = app.version
        appDetailHeaderView.versionHistoryLabel.text = app.currentVersionReleaseDate
        appDetailHeaderView.versionInfoLabel.text = app.releaseNotes
    }
    
    
}
