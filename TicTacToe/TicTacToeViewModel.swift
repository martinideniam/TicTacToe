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
    
    init() {
        model = TicTacToeViewModel.initGame()
        currentPlayer = initialPlayer
    }
    
    func tapCell(chosenCell: Model.BoardCell) {
        if chosenCell.state == .noState {
            for index in boardCells.indices {
                if boardCells[index].id == chosenCell.id {
                    if currentPlayer == .xPlayer {
                        print("X")
                        model.modifyCell(state: StateOfCell.xState, index: index)
                        currentPlayer = .oPlayer
                    } else {
                        print("O")
                        model.modifyCell(state: StateOfCell.oState, index: index)
                        currentPlayer = .xPlayer
                    }
                }
            }
        }
    }
    
    private static func initGame() -> Model {
        TicTacToeModel<StateOfCell, PlayerType>.init {
            return StateOfCell.noState
        }
    }
    
    enum StateOfCell: String {
        case noState = "", xState = "X", oState = "O"
    }
    
    enum PlayerType: String {
        case xPlayer = "X", oPlayer = "O"
    }
}
