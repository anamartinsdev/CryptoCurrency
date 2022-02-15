//
//  SelectAssetView.swift
//  CryptoCurrency
//
//  Created by Ana Carolina Martins Pessoa on 15/02/22.
//

import Foundation
import SwiftUI

struct SelectAssetView: View {
    //MARK: - Variables
    var viewModel: CoinViewModel = CoinViewModel()
    @State private var showingAlert = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.listAssets.coins.reversed()) { asset in
                    VStack {
                        HStack(spacing: 0) {
                            AsyncImage(url: URL(string: asset.icon)) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            } .frame(width: 30, height: 30)
                                .padding(8)
                            VStack (alignment: .leading) {
                                Text(asset.symbol.uppercased())
                                    .fontWeight(.bold).font(.system(size: 14))
                            }.padding(6)
                        }
                        Button ("", action: {
                            self.viewModel.selectedAssetSymbol = asset
                            if viewModel.listCoin.coins.contains(asset) {
                                showingAlert = true
                            } else {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        }).alert("Asset is on the list", isPresented: $showingAlert) {
                            Button("OK", role: .cancel) {}
                        }
                    }
                }
            }.frame(alignment: .leading)
                .navigationBarTitle(Text("Select Asset"), displayMode: .automatic)
        }
    }
}

struct SelectAssetView_Previews: PreviewProvider {
    static var previews: some View{
        ForEach(ColorScheme.allCases, id: \.self) {
            SelectAssetView().preferredColorScheme($0)
        }
    }
}
