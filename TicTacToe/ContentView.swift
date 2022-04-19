//
//  ContentView.swift
//  TicTacToe
//
//  Created by Vladislav Gorovenko on 19.04.2022.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            LabelOfTheGame()
                .padding(.top, 20)
                Spacer()
            CurrentPlayer()
            Board()
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
    var body: some View {
        Text("Игрок X")
            .fontWeight(.heavy)
    }
}


struct Board: View {
    var body: some View {
        Cells()
    }
}

struct Cells: View {
    var body: some View {
        VStack {
            HStack {
                Cell(state: "a1")
                Cell(state: "a2")
                Cell(state: "a3")
            }
            
            HStack {
                Cell(state: "b1")
                Cell(state: "b2")
                Cell(state: "b3")
            }
            HStack {
                Cell(state: "c1")
                Cell(state: "c2")
                Cell(state: "c3")
            }
        }
    }
}

struct Cell: View {
    var state: String?

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 90, height: 100, alignment: .center)
            if let someState = state {
                Text(someState)
                    .foregroundColor(.white)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
