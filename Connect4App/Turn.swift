//
//  Turn.swift
//  Connect4App
//
//  Created by Eken Özlü on 7.06.2023.
//

import UIKit

enum Turn {
    case TurnRed
    case TurnYellow
}

var currenTurn = Turn.TurnYellow

func toggleTurn(turnImage: UIImageView){
    if yellowTurn() {
        currenTurn = .TurnRed
        turnImage.tintColor = .systemRed
    }
    else {
        currenTurn = .TurnYellow
        turnImage.tintColor = .systemYellow
    }
}

func yellowTurn() -> Bool {
    return currenTurn == .TurnYellow
}

func redTurn() -> Bool {
    return currenTurn == .TurnRed
}

func currentTurnTile() -> Tile {
    return yellowTurn() ? Tile.Yellow : Tile.Red
}

func currentTurnColor() -> UIColor {
    return yellowTurn() ? .systemYellow : .systemRed
}

func currentTurnString() -> String {
    return yellowTurn() ? "Yellow Wins" : "Red Wins"
}
