//
//  DataService.swift
//  CatAPI
//
//  Created by Evgeny on 2.09.23.
//

import Foundation

class DataService {
    private var cache = NSCache<NSURL, NSData>()
    
    func fetchModel<T: Decodable>(from url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        
        if let cachedData = cache.object(forKey: url as NSURL) {
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: cachedData as Data)
                print(result)
                completion(.success(result))
                return
            } catch {
                // -------------
            }
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "Data is nil", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: data)
                print(result)
                self.cache.setObject(data as NSData, forKey: url as NSURL)
                completion(.success(result))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
}
