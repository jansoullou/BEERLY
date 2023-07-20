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
    
    private func fetchData<T: Codable>(url: URL, completion: @escaping (Result<[T], Error>) -> Void) {
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
            
            if var model: [T] = CodeHelper.decodeDataToObject(data: data) {
                completion(.success(model))
            }
        }
        task.resume()
    }
}
    
extension NetworkLayer: MainPageNetworkLayerProtocol {
    func fetchData(page: Int, completion: @escaping (Result<[BeerElement], Error>) -> Void) {
        let apiType = ApiType.fetchAllDrinks
        var components = apiType.components

        components.queryItems = [
            URLQueryItem(name: "page", value: "\(page)")
        ]
        
        guard let url = components.url else {
            print("URL is nil")
            return
        }
        print(url)
        
        fetchData(url: url, completion: completion)
    }
}

extension NetworkLayer: SearchPageNetworkLayerProtocol {
    func fetchFilteredBeerList(search: String, completion: @escaping (Result<[BeerElement], Error>) -> Void) {
          let apiType = ApiType.fetchAllDrinks
          var components = apiType.components
          
          components.queryItems = [
              URLQueryItem(name: "beer_name", value: search)
          ]
          
          guard let url = components.url else {
              print("URL is nil")
              return
          }
          print(url)
          
          fetchData(url: url, completion: completion)
      }
}
