//
//  ViewController.swift
//  Connect4App
//
//  Created by Eken Özlü on 7.06.2023.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{

    @IBOutlet weak var turnImage: UIImageView!
    @IBOutlet weak var boardCV: UICollectionView!
    
    @IBOutlet weak var yellowScoreLabel: UILabel!
    @IBOutlet weak var redScoreLabel: UILabel!
    
    var yellowScore = 0
    var redScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetBoard()
        setScoreLabels()
        setCellWidthHeight()
    }
    
    func setScoreLabels() {
        yellowScoreLabel.text = String(yellowScore)
        redScoreLabel.text = String(redScore)
    }
    
    func setCellWidthHeight() {
        let width = boardCV.frame.size.width / 9
        let height = boardCV.frame.size.height / 6
        let flowLayout = boardCV.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    func numberOfSections(in cv: UICollectionView) -> Int {
        return board.count
    }

    func collectionView(_ cv: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return board[section].count
    }
    
    func collectionView(_ cv: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cv.dequeueReusableCell(withReuseIdentifier: "idCell", for: indexPath) as! BoardCollectionViewCell
        
        let boardItem = getBoardItem(indexPath)
        cell.image.tintColor = boardItem.tileColor()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let column = indexPath.item
        if var boardItem = getLowestEmptyBoardItem(column) {
            if let cell = boardCV.cellForItem(at: boardItem.indexPath) as? BoardCollectionViewCell {
                cell.image.tintColor = currentTurnColor()
                boardItem.tile = currentTurnTile()
                updateBoardWithBoardItem(boardItem)
                
                if victoryAchieved() {
                    if yellowTurn(){
                        yellowScore += 1
                    }
                    if redTurn() {
                        redScore += 1
                    }
                    resultAlert(title: currentTurnString())
                    setScoreLabels()
                }
                
                if boardIsFull() {
                    resultAlert(title: "Draw")
                }
                
                toggleTurn(turnImage: turnImage)
            }
        }
    }
    
    func resultAlert(title: String) {
        let message = "\nRed:" + String(redScore) + "\n\nYellow:" + String(yellowScore)
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Next Round", style: .cancel, handler: { _ in
            resetBoard()
            self.resetCells()
        }))
        ac.addAction(UIAlertAction(title: "Reset Game", style: .destructive, handler: { _ in
            resetBoard()
            self.resetCells()
            self.yellowScore = 0
            self.redScore = 0
            self.setScoreLabels()
        }))
        self.present(ac, animated: true)
    }
    
    func resetCells() {
        for cell in boardCV.visibleCells as! [BoardCollectionViewCell] {
            cell.image.tintColor = .white
        }
    }
}

