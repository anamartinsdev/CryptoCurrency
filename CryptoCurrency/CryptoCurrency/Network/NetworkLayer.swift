//
//  NetworkLayer.swift
//  CryptoCurrency
//
//  Created by Ana Carolina Martins Pessoa on 14/02/22.
//

import Foundation
import SwiftUI

enum ServiceMethod: String {
    case get = "GET"
    case post = "POST"
}

enum ServiceState {
    case request
    case response(Result<Data, Error>)
}

protocol Service {
    var baseURL: String { get }
    var path: String { get }
    var parameters: [String: Any]? { get }
    var method: ServiceMethod { get }
}

extension Service {
    var baseURL: String {
        return "https://api.coinstats.app"
    }
    
    private var url: URL? {
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.path = path
        if case .get = method{
            if let parameters = parameters as? [String:String]{
                urlComponents?.queryItems = parameters.map {
                    URLQueryItem(name: $0.key, value: $0.value) }
                }
            }
        return urlComponents?.url
        
        }
    
    public var urlRequest: URLRequest {
        guard let url = self.url else{
            return URLRequest(url: NSURL() as URL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        return request
    }

    public var urlString: String{
        return "\(urlRequest)"
    }
}
