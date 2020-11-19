//
//  AppDetailNewInfoView.swift
//  iOSArchitecturesDemo
//
//  Created by Антон Васильченко on 19.11.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit

class AppDetailNewInfoView: UIView {
    
    private(set) lazy var whatsNewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.text = "What's new"
        
        return label
    }()
    
    
    private(set) lazy var versionNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        
        return label
    }()
    
    private(set) lazy var versionHistoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.numberOfLines = 0
        
        return label
    }()
    
    private(set) lazy var versionHistoryButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("version history", for: .normal)
        button.backgroundColor = UIColor(white: 0.3, alpha: 1.0)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
//        button.layer.cornerRadius = 16.0
        
        return button
    }()
    
    private(set) lazy var versionInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.numberOfLines = 0
        
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.addSubview(whatsNewLabel)
        self.addSubview(versionHistoryButton)
        self.addSubview(versionNumberLabel)
        self.addSubview(versionHistoryLabel)
        self.addSubview(versionInfoLabel)
        
        NSLayoutConstraint.activate([
            whatsNewLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            whatsNewLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16.0),
//            whatsNewLabel.widthAnchor.constraint(equalToConstant: 80),

            
            versionNumberLabel.topAnchor.constraint(equalTo: whatsNewLabel.bottomAnchor, constant: 12),
//            versionNumberLabel.leftAnchor.constraint(equalTo: whatsNewLabel.rightAnchor, constant: ),
            versionNumberLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            
            versionHistoryLabel.topAnchor.constraint(equalTo: versionHistoryButton.bottomAnchor, constant: 12.0),
//            versionHistoryLabel.leftAnchor.constraint(equalTo: versionNumberLabel.leftAnchor),
            versionHistoryLabel.rightAnchor.constraint(equalTo: rightAnchor),
            
//            versionHistoryButton.leftAnchor.constraint(equalTo: whatsNewLabel.rightAnchor, constant: 16),
            versionHistoryButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            versionHistoryButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
//            versionHistoryButton.widthAnchor.constraint(equalToConstant: 80),
            versionHistoryButton.heightAnchor.constraint(equalToConstant: 32),
            
            versionInfoLabel.topAnchor.constraint(equalTo: versionNumberLabel.bottomAnchor, constant: 24),
            versionInfoLabel.leftAnchor.constraint(equalTo: leftAnchor),
            versionInfoLabel.widthAnchor.constraint(equalTo: widthAnchor),
            versionInfoLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
            
            
        ])
    }
    

    
}
