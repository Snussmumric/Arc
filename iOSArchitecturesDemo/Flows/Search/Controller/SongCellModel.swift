//
//  SongCellModel.swift
//  iOSArchitecturesDemo
//
//  Created by Антон Васильченко on 19.11.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import Foundation

struct SongCellModel {
    let trackName: String
    let artistName: String?
    let collectionName: String?
}

final class SongCellModelFactory {
    
    static func cellModel(from model: ITunesSong) -> SongCellModel {
        return SongCellModel(trackName: model.trackName,
                             artistName: model.artistName,
                             collectionName: model.collectionName)}
}
