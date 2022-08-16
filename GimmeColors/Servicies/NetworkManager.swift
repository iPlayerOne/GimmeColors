//
//  NetworkManager.swift
//  GimmeColors
//
//  Created by ikorobov on 11.08.2022.
//

import Foundation
import Alamofire

enum Link: String {
    case singleURL = "https://www.thecolorapi.com/id?rgb="
    case schemeURL = "https://www.thecolorapi.com/scheme?rgb="
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func getURLString(for link: Link, r: Int, g: Int, b: Int) -> String {
        let newUrl = "\(link.rawValue)\(r),\(g),\(b)"
        return newUrl
    }
    
    func fetchColor(from url: String, completion: @escaping(Result<Color, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                    case .success(let value):
                        let color = Color.getSingleColor(from: value)
                        print(color)
                        completion(.success(color))
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
    }
    
    func fetchScheme(from url: String, completion: @escaping(Result<Scheme, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                    case .success(let value):
                        let scheme = Scheme.getScheme(from: value)
                        print(scheme)
                        completion(.success(scheme))
                    case .failure(let error):
                        completion(.failure(error))
                }
                
            }
    }
    
//    func fetch<T: Decodable>(_ type: T.Type, from url: String?, completion: @escaping(Result<T,NetworkError>) -> Void) {
//        guard let url = URL(string: url ?? "") else {
//            completion(.failure(.invalidURL))
//            return
//        }
        
//        URLSession.shared.dataTask(with: url) { (data, _, error) in
//            guard let data = data else {
//                completion(.failure(.noData))
//                return
//            }
//            do {
//                let decoder = JSONDecoder()
//                let type = try decoder.decode(T.self, from: data)
//                DispatchQueue.main.async {
//                    completion(.success(type))
//                }
//            } catch {
//                completion(.failure(.decodingError))
//            }
//        }.resume()
//    }
}
