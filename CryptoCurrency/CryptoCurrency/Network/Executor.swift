//
//  Executor.swift
//  CryptoCurrency
//
//  Created by Ana Carolina Martins Pessoa on 14/02/22.
//

import Foundation

protocol ServiceExecutor: AnyObject {
    func execute<T: Service> (_ service: T, completion: @escaping (Result<Data, Error>) -> Void)
}

class Executor: ServiceExecutor {
    
    func execute<T: Service>(_ service: T, completion: @escaping (Result<Data, Error>) -> Void) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        session.dataTask(with: service.urlRequest) { (data, response, error) in
            if let error = error {
                print("Request failed")
                completion(.failure(error))
                
            }else if let data = data {
                print ("Request completed")
                completion(.success(data))
            }
        }.resume ()
    }
}
