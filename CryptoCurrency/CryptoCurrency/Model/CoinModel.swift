//
//  CoinModel.swift
//  CryptoCurrency
//
//  Created by Ana Carolina Martins Pessoa on 14/02/22.
//

import Foundation

//MARK: - Coin

struct CoinModel: Codable {
    var coins: [CoinElement]
}


//MARK: Coin Covenience Initializers and mutators

extension CoinModel {
    init(){
        self.coins = []
    }
}

//MARK: -CoinElement

struct CoinElement: Codable, Identifiable, Equatable {
    
    var id: String
    var icon: String
    var name, symbol : String
    var rank: Int
    var price, priceBtc, volume, marketCap: Double
    var availableSupply, totalSupply, priceChange1H, priceChange1D: Double
    var priceChange1W: Double
    var websiteURL: String
    var twitterURL: String?
    var exp: [String]
    var contractAdress: String?
    var decimals: Int?
    
    enum CodingKeys: String, CodingKey {
        case icon, name, symbol, rank, price, priceBtc, volume, marketCap, availableSupply, totalSupply, id
        case priceChange1H = "priceChange1h"
        case priceChange1D = "priceChange1d"
        case priceChange1W = "priceChange1w"
        case websiteURL = "websiteUrl"
        case twitterURL = "twitterUrl"
        case exp, contractAdress, decimals
    }
}

//MARK: CoinElement convenience initializers and mutators

extension CoinElement {
    init () {
        self.id = ""
        self.icon = ""
        self.name = ""
        self.symbol = ""
        self.rank = 0
        self.price = 0
        self.priceBtc = 0
        self.volume = 0
        self.marketCap = 0
        self.availableSupply = 0
        self.totalSupply = 0
        self.priceChange1H = 0
        self.priceChange1D = 0
        self.priceChange1W = 0
        self.websiteURL = ""
        self.twitterURL = ""
        self.exp = []
        self.contractAdress = ""
        self.decimals = 0
    }
    
}
