//
//  TicTacToeModel.swift
//  TicTacToe
//
//  Created by Vladislav Gorovenko on 19.04.2022.
//

import Foundation

struct TicTacToeModel<StateType, PlayerType> {
    
    var boardCells: Array<BoardCell>
    
    init(generateState: () -> StateType) {
        boardCells = []
        for _ in 0..<9 {
            let newState = generateState()
            boardCells.append(BoardCell(state: newState, id: UUID().uuidString))
        }
    }
    
    mutating func modifyCell(state: StateType, index: Int) {
        boardCells[index].state = state
        print(boardCells[index].state)
    }
    
    struct BoardCell: Identifiable {
        var state: StateType
        var id: String
    }
}
