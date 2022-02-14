//
//  ServiceProvider.swift
//  CryptoCurrency
//
//  Created by Ana Carolina Martins Pessoa on 14/02/22.
//

import Foundation
import SwiftUI
import Combine

struct CoinModel: Codable {
    
}
struct ServiceProvider<T: Service> {
    
    private var executor: ServiceExecutor
    var listner: ((ServiceState) -> Void)?
    
    init (executor: ServiceExecutor = Executor()) {
        self.executor = executor
    }
    
    func load(
        service: T, decodeType: CoinModel.Type = CoinModel.self, deliverQueue: DispatchQueue = DispatchQueue.main, completion: ((Result<CoinModel, CustomError>) -> Void)?) {
            executor.execute(service) { response in
                switch response {
                case .success (let data):
                    if let resp = try? JSONDecoder().decode(CoinModel.self, from: data){
                        deliverQueue.async {
                            completion?(.success(resp))
                        }
                    }
                case .failure(let error): deliverQueue.async {
                    completion?(.failure(CustomError(error: error)))
                }
                }
            }
        }
}
