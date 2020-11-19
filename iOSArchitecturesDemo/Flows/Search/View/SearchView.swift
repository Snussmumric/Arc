//
//  SearchView.swift
//  iOSArchitecturesDemo
//
//  Created by Evgeny Kireev on 02/06/2019.
//  Copyright © 2019 ekireev. All rights reserved.
//

import UIKit

final class SearchView: UIView {
    
    // MARK: - Subviews
    
    let searchBar = UISearchBar()
    let tableView = UITableView()
    let emptyResultView = UIView()
    let emptyResultLabel = UILabel()
    let searchTypeSegment = UISegmentedControl(items: ["app", "song"])
    let searchMode = SearchTypeMode.shared

    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }
    
    // MARK: - UI
    
    private func configureUI() {
        self.backgroundColor = .white
        self.addSearchTypeSegment()
        self.addSearchBar()
        self.addTableView()
        self.addEmptyResultView()
        self.setupConstraints()

    }
    
    private func addSearchTypeSegment() {
        searchTypeSegment.selectedSegmentIndex = 0
        
        // Set up Frame and SegmentedControl
        let frame = UIScreen.main.bounds
        self.searchBar.translatesAutoresizingMaskIntoConstraints = false

        self.searchTypeSegment.frame = CGRect(x: 0, y: 0, width: frame.width, height: 50)

        // Style the Segmented Control
        self.searchTypeSegment.layer.cornerRadius = 5.0  // Don't let background bleed
        self.searchTypeSegment.backgroundColor = UIColor.black
        self.searchTypeSegment.tintColor = UIColor.white

        // Add target action method
        self.searchTypeSegment.addTarget(self, action: #selector(segmentedValueChanged), for:.valueChanged)
        

//        self.searchTypeSegment.addTarget(self, action: Selector(("segmentedValueChanged:")), for: .touchUpInside)

//        self.searchTypeSegment.actions(forTarget: "changeColor:", forControlEvent: .valueChanged)

        // Add this custom Segmented Control to our view
        self.addSubview(self.searchTypeSegment)
    }
    
    @objc private func segmentedValueChanged()
    {
        switch self.searchTypeSegment.selectedSegmentIndex {
        case 0:
            searchMode.mode = .app
            self.searchBar.text?.removeAll()
            self.tableView.reloadData()
        case 1:
            searchMode.mode = .song
            self.searchBar.text?.removeAll()
            self.tableView.reloadData()

        default:
            break
        }
    }
    
    private func addSearchBar() {
        self.searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.searchBar.searchBarStyle = .minimal
        self.addSubview(self.searchBar)
    }
    
    private func addTableView() {
        self.tableView.rowHeight = 72.0
        self.tableView.separatorInset = UIEdgeInsets(top: 0.0, left: 12.0, bottom: 0.0, right: 0.0)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.isHidden = true
        self.tableView.tableFooterView = UIView()
        self.addSubview(self.tableView)
    }
    
    private func addEmptyResultView() {
        self.emptyResultView.translatesAutoresizingMaskIntoConstraints = false
        self.emptyResultView.backgroundColor = .white
        self.emptyResultView.isHidden = true
        
        self.emptyResultLabel.translatesAutoresizingMaskIntoConstraints = false
        self.emptyResultLabel.text = "Nothing was found"
        self.emptyResultLabel.textColor = UIColor.darkGray
        self.emptyResultLabel.textAlignment = .center
        self.emptyResultLabel.font = UIFont.systemFont(ofSize: 12.0)
        
        self.addSubview(self.emptyResultView)
        self.emptyResultView.addSubview(self.emptyResultLabel)
    }
    
    private func setupConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            self.searchTypeSegment.topAnchor.constraint(equalTo: self.topAnchor, constant: 8.0),
            self.searchTypeSegment.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.searchTypeSegment.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            
            self.searchBar.topAnchor.constraint(equalTo: self.searchTypeSegment.bottomAnchor),
            self.searchBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.searchBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            
            self.tableView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
            self.emptyResultView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor),
            self.emptyResultView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.emptyResultView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.emptyResultView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            self.emptyResultLabel.topAnchor.constraint(equalTo: self.emptyResultView.topAnchor, constant: 12.0),
            self.emptyResultLabel.leadingAnchor.constraint(equalTo: self.emptyResultView.leadingAnchor),
            self.emptyResultLabel.trailingAnchor.constraint(equalTo: self.emptyResultView.trailingAnchor)
            ])
    }
}
