//
//  ContentView.swift
//  TicTacToe
//
//  Created by Vladislav Gorovenko on 19.04.2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: TicTacToeViewModel
    var body: some View {
        VStack {
            LabelOfTheGame()
                .padding(.top, 20)
                Spacer()
            CurrentPlayer(player: viewModel.currentPlayer)
            Board(viewModel: viewModel)
                .padding(.top, 40)
            Spacer()
            .alert(
                "ИГРА ЗАКОНЧЕНА",
                isPresented: $viewModel.notPlaying,
                actions: {
                    Button("ЕЩЕ РАЗ", role: .cancel, action: {
                        viewModel.startNewGame()
                    })
                },
                message: {
                    switch viewModel.message {
                    case .draw: Text("Ничья.")
                        case .oWon: Text("O-игрок выйграл.")
                        case .xWon: Text("X-игрок выйграл.")
                    }
                })
        }
    }
}


struct LabelOfTheGame: View {
    var body: some View {
        VStack {
            Text("крестики")
                .fontWeight(.heavy)
                .font(.system(size: 30))
            Text("NOLIKI")
                .font(.system(size: 20))
                .foregroundColor(.red)
                .fontWeight(.bold)
                .kerning(8)
        }
    }
}

struct CurrentPlayer: View {
    var player: TicTacToeViewModel.PlayerType
    
    var body: some View {
        HStack(spacing:0) {
            Text("игрок: ")
                .fontWeight(.heavy)
            Text(XorO(player))
                .fontWeight(.heavy)
                .foregroundColor(.red)
        }

    }
    
    func XorO(_ player: TicTacToeViewModel.PlayerType) -> String {
        switch player {
            case .xPlayer:
                return "X"
            default:
                return "O"
        }
    }
}


struct Board: View {
    @ObservedObject var viewModel: TicTacToeViewModel
    var body: some View {
        Cells(viewModel: viewModel)
    }
}

struct Cells: View {
    @ObservedObject var viewModel: TicTacToeViewModel
    var body: some View {
        let someGridItem = GridItem(.flexible(minimum: 65, maximum: 65))
        let someGridItems = [someGridItem, someGridItem, someGridItem]
        LazyHGrid(rows: someGridItems, spacing: 10) {
            ForEach(viewModel.boardCells) { cell in
                Cell(cell: cell, viewModel: viewModel)
            }
        }
    }
}

struct Cell: View {
    var cell: TicTacToeViewModel.Model.BoardCell
    @ObservedObject var viewModel: TicTacToeViewModel
    var body: some View {
            Button {
                viewModel.tapCell(chosenCell: cell)
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(lineWidth: 3)
                        .frame(width: 60, height: 60, alignment: .center)
                        .foregroundColor(Color("Color"))
                    Text(cell.state.rawValue)
                        .font(.system(size: 30))
                        .foregroundColor(Color("Color"))
                        .bold()
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = TicTacToeViewModel()
        return ContentView(viewModel: viewModel)
    }
}
