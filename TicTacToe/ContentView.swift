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
            
        }
    }
}

struct LabelOfTheGame: View {
    var body: some View {
        VStack {
            Text("Крестики")
                .fontWeight(.heavy)
                .font(.system(size: 30))
            Text("NOLIKI")
                .font(.system(size: 20))
                .foregroundColor(.red)
                .fontWeight(.bold)
        }
        

    }
}

struct CurrentPlayer: View {
    var player: TicTacToeViewModel.PlayerType
    
    var body: some View {
        Text("Игрок \(XorO(player))")
            .fontWeight(.heavy)
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
        let someGridItem = GridItem(.flexible(minimum: 70, maximum: 70))
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
                    RoundedRectangle(cornerRadius: 10)
                        .stroke()
                        .frame(width: 70, height: 70, alignment: .center)
                    Text(cell.state.rawValue)
                        .foregroundColor(.black)
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
