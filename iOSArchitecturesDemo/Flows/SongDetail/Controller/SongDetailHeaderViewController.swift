//
//  SongDetailHeaderViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Антон Васильченко on 19.11.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit

class SongDetailHeaderViewController: UIViewController {
    private let song: ITunesSong
    
    private let imageDownloader = ImageDownloader()
    
    private var songDetailHeaderView: SongDetailHeaderView {
        return self.view as! SongDetailHeaderView
    }
    
    init(song: ITunesSong) {
        self.song = song
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = SongDetailHeaderView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillData()
    }
    
    private func fillData() {
        downloadImage()
        
        songDetailHeaderView.titleLabel.text = song.artistName
        songDetailHeaderView.subTitleLabel.text = song.trackName
        songDetailHeaderView.ratingLabel.text = song.collectionName    }
    
    private func downloadImage() {
        guard let url = song.artwork else { return }
        imageDownloader.getImage(fromUrl: url) { [weak self] (image, _) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.songDetailHeaderView.imageView.image = image
            }
            
        }
    }
    
}
