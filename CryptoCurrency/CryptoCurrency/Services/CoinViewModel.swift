//
//  CoinViewModel.swift
//  CryptoCurrency
//
//  Created by Ana Carolina Martins Pessoa on 15/02/22.
//

import Foundation
import Combine

final class CoinViewModel: ObservableObject {
    
    enum State {
        case loading, empty
        case error(CustomError)
    }

//MARK: - Variables
@Published var listCoin: CoinModel = CoinModel()
@Published var listAssets: CoinModel = CoinModel()
@Published var selectedAssetSymbol: CoinElement = CoinElement()
@Published var currentState: State = State.empty
    
private var provider: ServiceProvider<CoinService>?
    
//MARK: -Initializer

init(provider:ServiceProvider<CoinService> = ServiceProvider<CoinService>()) {
    self.provider = provider
    }
    
//MARK: - Public Functions
    func resetData() {
        currentState = State.empty
        loadCoins (limit:"10")
    }
    
    func loadCoins(limit:String) {
        provider?.load(service: .getCoins, completion: { [weak self] result in self?.currentState = .empty
            switch result {
            case .success(let items):
                self?.currentState = .loading
                self?.listCoin = items
            case .failure(let error):
                self?.currentState = .error(error)
            }
        })
    }
    
    func getListAssets(limit: String){
        provider?.load(service: .listAssets, completion: { [weak self] result in
            self?.currentState = .empty
            switch result {
            case .success(let items):
                self?.currentState = .loading
                self?.listAssets = items
            case .failure(let error):
                self?.currentState = .error(error)
            }
        })
    }
}
