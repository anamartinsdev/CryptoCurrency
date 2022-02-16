//
//  CryptoCurrencyApp.swift
//  CryptoCurrency
//
//  Created by Ana Carolina Martins Pessoa on 14/02/22.
//

import SwiftUI

@main
struct CryptoCurrencyApp: App {
    var body: some Scene {
        WindowGroup {
            ZStack{
                NavigationView {
                    ContentView()
                        .navigationBarHidden(true)
                }
                .navigationViewStyle(StackNavigationViewStyle())
            }
         
        }
    }
}
