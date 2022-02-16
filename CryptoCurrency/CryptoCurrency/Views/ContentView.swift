//
//  ContentView.swift
//  CryptoCurrency
//
//  Created by Ana Carolina Martins Pessoa on 14/02/22.
//

import SwiftUI
import MobileCoreServices

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
            VStack (alignment: .center, spacing: 60) {
                if !shouldHide {
                    HStack (alignment: .center, spacing: 90) {
                        Spacer()
                        Button("Start", action: {
                            states = viewModel.listCoin
                            shouldHide = true
                        })
                            .frame(width: 200, height: 50)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(8)
                            .opacity(shouldHide ? 0 : 1)
                            .shadow(color: .gray, radius: 4, x: 0.0, y: 0.0)
                        Spacer()
                    }
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                }
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
                                Text(coin.price.asCurrencyWith6Decimals()).fontWeight(.semibold)
                                    .font(.system(size: 14))
                                    .padding(6)
                            }
                            .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
                            Button("", action: {
                            }).sheet(isPresented: $showingSheet, onDismiss: {
                                insertCoin()
                            }, content: {
                                SelectAssetView(viewModel: viewModel)
                            })
                        }
                    }
                    .onDelete(perform: onDelete)
                    .onMove(perform: onMove)
                }
                .colorScheme(colorScheme)
                .navigationTitle("Crypto Currency")
                .navigationViewStyle(.automatic)
                .navigationBarItems(leading: addButton, trailing: EditButton())
                .environment(\.editMode, $editMode)
                .listStyle(PlainListStyle())
                .onAppear() {
                    self.viewModel.loadCoins(limit: "10")
                    self.viewModel.getListAssets(limit: "30")
                }
                .refreshable{
                    await reloadList()
                }
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
        if !states.coins.contains(viewModel.selectedAssetSymbol) {
            states.coins.append(viewModel.selectedAssetSymbol)
        }
    }
    private func reloadList() async {
        if states.coins.isEmpty {
            states = viewModel.listCoin
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
