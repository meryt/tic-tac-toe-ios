//
//  ViewController.swift
//  Tic-Tac-Toe
//
//  Created by Jennifer van Hoof on 2017-01-12.
//  Copyright © 2017 Jennifer van Hoof. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet var buttons: [UIButton]!

    var whoseTurn = "O"

    let nought = UIImage(named: "nought.png")
    let cross = UIImage(named: "cross.png")

    var plays : [[String]] = [[String]]()

    let winningCoords = [[[0,0], [0,1], [0,2]],
                         [[1,0], [1,1], [1,2]],
                         [[2,0], [2,1], [2,2]],
                         [[0,0], [1,0], [2,0]],
                         [[0,1], [1,1], [2,1]],
                         [[0,2], [1,2], [2,2]],
                         [[0,0], [1,1], [2,2]],
                         [[2,0], [1,1], [0,2]]]

    @IBAction func squarePressed(_ button: UIButton) {

        if button.image(for: []) != nil {
            print("Someone has already checked this space")
            return
        }

        if whoseTurn == "O" {
            button.setImage(nought, for: [])
        } else if whoseTurn == "X" {
            button.setImage(cross, for: [])
        } else {
            // game is over, don't do anything
        }

        if whoseTurn == "O" || whoseTurn == "X" {
            registerPlay(player: whoseTurn, buttonTitle: button.currentTitle!)
        }

        let checkWinner = someoneHasWon()
        if checkWinner != "" {
            turnLabel.text = "\(checkWinner) has won!"
            whoseTurn = ""
        } else if nobodyWon() {
            turnLabel.text = "It's a draw!"
            whoseTurn = ""
        } else {
            setTurn(player: whoseTurn == "O" ? "X" : "O")
        }

    }

    @IBAction func startOverPressed(_ sender: Any) {
        clearBoard()
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        for i in [0,1,2] {
            plays.append([])
            plays[i].append("")
            plays[i].append("")
            plays[i].append("")
        }

        clearBoard()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    internal func registerPlay(player:String, buttonTitle:String) {
        let parts = buttonTitle.components(separatedBy: "_")
        let x = Int(parts[1])!
        let y = Int(parts[2])!

        if x < 0 || x > 2 || y < 0 || y > 2 {
            print("Error: Invalid x,y value \(x),\(y)")
            return
        }
        if plays[x][y] != "" {
            print("Error: There is already a \(plays[x][y]) in this square")
        }

        plays[x][y] = player
    }

    internal func someoneHasWon() -> String {
        for winner in winningCoords {
            let whoWon = isAllXsOrOs(winningRow: winner)
            if whoWon != "" {
                return whoWon
            }
        }
        return ""
    }

    internal func nobodyWon() -> Bool {
        for i in [0, 1, 2] {
            for j in [0, 1, 2] {
                if plays[i][j] == "" {
                    return false
                }
            }
        }
        return true
    }

    internal func isAllXsOrOs(winningRow: [[Int]]) -> String {
        let coord1 = winningRow[0]
        let coord2 = winningRow[1]
        let coord3 = winningRow[2]

        if plays[coord1[0]][coord1[1]] == plays[coord2[0]][coord2[1]] &&
            plays[coord2[0]][coord2[1]] == plays[coord3[0]][coord3[1]] &&
            plays[coord1[0]][coord1[1]] != "" {
            return plays[coord1[0]][coord1[1]]
        }
        return ""
    }

    internal func clearBoard() {
        for button in buttons {
            button.setImage(nil, for: [])
        }
        setTurn(player: "O")

        for i in [0, 1, 2] {
            for j in [0, 1, 2] {
                plays[i][j] = ""
            }
        }
    }

    internal func setTurn(player:String) {
        whoseTurn = player
        turnLabel.text = "\(player)'s turn"
    }

}

