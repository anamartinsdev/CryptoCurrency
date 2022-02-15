//
//  CoinService.swift
//  CryptoCurrency
//
//  Created by Ana Carolina Martins Pessoa on 14/02/22.
//

import Foundation

enum CoinService {
    case getCoins
    case listAssets
}

extension CoinService: Service {
    
    var path: String {
            return "/public/v1/coins"
        }
    
    var method: ServiceMethod {
            return .get
        }
    var parameters: [String : Any]? {
        switch self {
        case .getCoins:
            return ["skip": "0", "limit":"10", "currency":"USD"]
        case .listAssets:
            return ["skip": "0", "limit":"25", "currency":"USD"]
        }
    }
}
