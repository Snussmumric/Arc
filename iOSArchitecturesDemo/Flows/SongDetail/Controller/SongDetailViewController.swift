//
//  SongDetailViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Антон Васильченко on 19.11.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//


import UIKit

final class SongDetailViewController: UIViewController {
    
    public var song: ITunesSong
    
    lazy var headerViewController = SongDetailHeaderViewController(song: song)

    
    private let imageDownloader = ImageDownloader()
    
    private var songDetailView: SongDetailView {
        return self.view as! SongDetailView
    }
    
    init(song: ITunesSong) {
        self.song = song
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Lifecycle
    
//    override func loadView() {
//        super.loadView()
//        self.view = AppDetailView()
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
//        self.configureNavigationController()
//        self.downloadImage()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.navigationItem.largeTitleDisplayMode = .never
        
        addHeaderViewController()
    
        
    }
    
    private func addHeaderViewController() {
        self.addChild(headerViewController)
        self.view.addSubview(headerViewController.view)
        headerViewController.didMove(toParent: self)
        
        headerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerViewController.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            headerViewController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            headerViewController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor),
        ])
    }
    

    
//    // MARK: - Private
//
//    private func configureNavigationController() {
//        self.navigationController?.navigationBar.tintColor = UIColor.white;
//        self.navigationItem.largeTitleDisplayMode = .never
//    }
//
//    private func downloadImage() {
//        guard let url = self.app?.iconUrl else { return }
//        self.appDetailView.throbber.startAnimating()
//        self.imageDownloader.getImage(fromUrl: url) { (image, error) in
//            self.appDetailView.throbber.stopAnimating()
//            guard let image = image else { return }
//            self.appDetailView.imageView.image = image
//        }
//    }
}
