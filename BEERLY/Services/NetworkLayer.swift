//
//  NetworkLayer.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 10/7/23.
//

import Foundation

final class NetworkLayer {
    
    static let shared = NetworkLayer()
    
    enum ApiType {
        case fetchAllDrinks
        case fetchRandomBeer
        
        var host: String {
            "api.punkapi.com"
        }
        
        var path: String {
            switch self {
            case .fetchAllDrinks:
                return "/v2/beers"
            case .fetchRandomBeer:
                return "/v2/random"
            }
        }
        
        var components: URLComponents {
            var components = URLComponents()
            components.scheme = "https"
            components.host = host
            components.path = path
            
            return components
        }
    }
}
    
extension NetworkLayer: MainPageNetworkLayerProtocol {
    func fetchData(completion: @escaping (Result<[BeerElement], Error>) -> Void) {
        let apiType = ApiType.fetchAllDrinks
        let components = apiType.components

        guard let url = components.url else {
            print("URL is nil")
            return
        }
        print(url)
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            guard data != nil else {
                completion(.failure(error!))
                return
            }
            
            if let model: [BeerElement] = CodeHelper.decodeDataToObject(data: data) {
                completion(.success(model))
            }
        }
        task.resume()
    }
}

