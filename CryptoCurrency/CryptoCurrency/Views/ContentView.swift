//
//  ContentView.swift
//  CryptoCurrency
//
//  Created by Ana Carolina Martins Pessoa on 14/02/22.
//

import SwiftUI
import MobileCoreServices

struct Item: Identifiable{
    let id = UUID()
    let title: String
}

struct ContentView: View {
    //MARK: - Variables/Constants
    private var viewModel = CoinViewModel()
    @State private var editMode = EditMode.inactive
    @State private var showingSheet = false
    @State var shouldHide = false
    @State var states = CoinModel()
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading, spacing: 6) {
                List {
                    ForEach(states.coins) { coin in
                        HStack{
                            VStack {
                                HStack(spacing:0){
                                    AsyncImage(url: URL(string: coin.icon)) { image in image.resizable()
                                    } placeholder: {
                                        ProgressView()
                                    } .frame(width: 30, height: 30)
                                        .padding(8)
                                    VStack(alignment: .leading) {
                                        Text(coin.symbol.uppercased())
                                            .fontWeight(.bold).font(.headline)
                                            .padding(.leading,6)
                                        Text(coin.name).fontWeight(.regular).font(.system(size:14))
                                    }.padding(6)
                                }
                        }
                        Spacer()
                            VStack(alignment: .trailing){
                                Text(String(coin.price)).fontWeight(.semibold)
                                    .font(.system(size: 14))
                                    .padding(6)
                            }
                            .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
                            Button("", action: {
                            }).sheet(isPresented: $showingSheet, onDismiss: {insertCoin()
                            }, content: {
                                SelectAssetView(viewModel: viewModel)
                            })
                        }
                    }
                    .onDelete(perform: onDelete)
                    .onMove(perform: onMove)
                }
                .onAppear() {
                    self.viewModel.loadCoins(limit: "10")
                    self.viewModel.getListAssets(limit: "25")
                    print(viewModel.listCoin)
                }
                .navigationBarTitle(Text("Crypto Currency"), displayMode: .automatic)
                .navigationBarItems(leading: EditButton(), trailing: addButton)
                .colorScheme(colorScheme)
                .environment(\.editMode, $editMode)
            }
        }
    }
    private var addButton: some View {
        return AnyView(Button(action: onAdd) { Image(systemName: "plus") })
    }
    
    private func onAdd() {
        showingSheet.toggle()
    }
    
    private func onDelete(offsets: IndexSet) {
        states.coins.remove(atOffsets: offsets)
    }
    
    private func onMove (source: IndexSet, destination: Int) {
        states.coins.move(fromOffsets: source, toOffset: destination)
    }
    
    private func insertCoin() {
        if !states.coins.contains(viewModel.selectedAssetSymbol){
            states.coins.append(viewModel.selectedAssetSymbol)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            ContentView().preferredColorScheme($0)
        }
    }
}
