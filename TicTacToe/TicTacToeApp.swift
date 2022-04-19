//
//  TicTacToeApp.swift
//  TicTacToe
//
//  Created by Vladislav Gorovenko on 19.04.2022.
//

import SwiftUI

@main
struct TicTacToeApp: App {
    var body: some Scene {
        WindowGroup {
            let viewModel = TicTacToeViewModel()
            ContentView(viewModel: viewModel)
        }
    }
}
