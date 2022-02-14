//
//  ContentView.swift
//  CryptoCurrency
//
//  Created by Ana Carolina Martins Pessoa on 14/02/22.
//

import SwiftUI

struct ContentView: View {
    //MARK: - Variables/Constants
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading, spacing: 6) {
                List {
                    Text("Bitcoin").fontWeight(.bold).font(.system(size: 20))
                    Text("Etherum").fontWeight(.bold).font(.system(size: 20))
                    Text("Axie Infinity").fontWeight(.bold).font(.system(size: 20))
                }
                .navigationBarTitle(Text("Crypto Currency"), displayMode: .automatic)
                .navigationBarItems(leading: EditButton(), trailing: addButton)
                .colorScheme(colorScheme)
            }
        }
    }
    private var addButton: some View {
        return AnyView(Button(action: onAdd) { Image(systemName: "plus") })
    }
    private func onAdd() {
        print("Button presed")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            ContentView().preferredColorScheme($0)
        }
    }
}
