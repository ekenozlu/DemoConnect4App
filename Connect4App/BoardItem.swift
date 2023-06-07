//
//  BoardItem.swift
//  Connect4App
//
//  Created by Eken Özlü on 7.06.2023.
//

import UIKit

enum Tile {
    case Red
    case Yellow
    case Empty
}

struct BoardItem {
    var indexPath: IndexPath!
    var tile: Tile!
    
    func yellowTile() -> Bool {
        return tile == Tile.Yellow
    }
    
    func redTile() -> Bool {
        return tile == Tile.Red
    }
    
    func emptyTile() -> Bool {
        return tile == Tile.Empty
    }
    
    func tileColor() -> UIColor {
        if redTile() {
            return .systemRed
        }
        if yellowTile(){
            return .systemYellow
        }
        return .white
    }
}
