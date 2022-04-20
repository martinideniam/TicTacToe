//
//  TicTacToeViewModel.swift
//  TicTacToe
//
//  Created by Vladislav Gorovenko on 19.04.2022.
//

import Foundation

class TicTacToeViewModel: ObservableObject {
    
    typealias Model = TicTacToeModel<StateOfCell, PlayerType>
    
    @Published private(set) var model: Model
    
    var boardCells: Array<Model.BoardCell> {
        return model.boardCells
    }
    
    var currentPlayer: PlayerType
    var initialPlayer: PlayerType = .oPlayer
    @Published var notPlaying: Bool = false
    var message: Message = .draw
    var filledBoardCells: Array<Model.BoardCell> = []
    
    init() {
        model = TicTacToeViewModel.initGame()
        currentPlayer = initialPlayer
    }
    
    func tapCell(chosenCell: Model.BoardCell) {
        if chosenCell.state == .noState {
            for index in boardCells.indices {
                if boardCells[index].id == chosenCell.id {
                    if currentPlayer == .xPlayer {
                        model.modifyCell(state: StateOfCell.xState, index: index)
                        currentPlayer = .oPlayer
                    } else {
                        model.modifyCell(state: StateOfCell.oState, index: index)
                        currentPlayer = .xPlayer
                    }
                    filledBoardCells.append(chosenCell)
                }
            }
        }
        if someoneWon() {
            notPlaying = true
        }
        if gameIsOver() {
            notPlaying = true
        }
    }
    
    func someoneWon() -> Bool {
        var combinationOfCells = [String]()
        for cell in boardCells {
            if cell.state == .xState {
                combinationOfCells.append("x")
            } else if cell.state == .oState {
                combinationOfCells.append("o")
            } else {
                combinationOfCells.append("-")
            }
        }
        if let winner = checkIfCombinationHasWinner(combination: combinationOfCells) {
            if winner == "x" {
                message = .xWon
            } else {
                message = .oWon
            }
            return true
        }
        return false
    }
    
    func checkIfCombinationHasWinner(combination: Array<String>) -> String? {
        var whoWon: String?
        if combination[0] == combination[1] && combination[0] == combination[2] {
            if combination[0] != "-" {
                whoWon = combination[0]
            }
        }
        if combination[3] == combination[4] && combination[3] == combination[5] {
            if combination[3] != "-" {
                whoWon = combination[3]
            }
        }
        if combination[6] == combination[7] && combination[6] == combination[8] {
            if combination[6] != "-" {
                whoWon = combination[6]
            }
        }
        if combination[0] == combination[4] && combination[0] == combination[8] {
            if combination[0] != "-" {
                whoWon = combination[0]
            }
        }
        if combination[2] == combination[4] && combination[2] == combination[6] {
            if combination[2] != "-" {
                whoWon = combination[2]
            }
        }
        if combination[0] == combination[3] && combination[0] == combination[6] {
            if combination[0] != "-" {
                whoWon = combination[0]
            }
        }
        if combination[1] == combination[4] && combination[1] == combination[7] {
            if combination[1] != "-" {
                whoWon = combination[1]
            }
        }
        if combination[2] == combination[5] && combination[2] == combination[8] {
            if combination[2] != "-" {
                whoWon = combination[2]
            }
        }
        return whoWon
    }
    
    func gameIsOver() -> Bool {
        if filledBoardCells.count == 9 {
            return true
        }
        return false
    }
    
    private static func initGame() -> Model {
        TicTacToeModel<StateOfCell, PlayerType>.init {
            return StateOfCell.noState
        }
    }
    
    func startNewGame() {
        model = TicTacToeViewModel.initGame()
        if initialPlayer == .xPlayer {
            initialPlayer = .oPlayer
        } else {
            initialPlayer = .xPlayer
        }
        message = .draw
        filledBoardCells.removeAll()
    }
    
    enum StateOfCell: String {
        case noState = "", xState = "X", oState = "O"
    }
    
    enum PlayerType: String {
        case xPlayer = "X", oPlayer = "O"
    }
    
    enum Message {
        case draw, xWon, oWon
    }
}
