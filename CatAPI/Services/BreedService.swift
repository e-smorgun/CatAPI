//
//  CatService.swift
//  CatAPI
//
//  Created by Evgeny on 2.09.23.
//

import Foundation

class BreedService {
    private let dataService = DataService()

    func fetchBreeds(page: Int, limit: Int = 10, completion: @escaping (Result<[CatsBreed], Error>) -> Void) {
        let urlString: String = "https://api.thecatapi.com/v1/breeds?limit=\(limit)&page=\(page)"
        let url = URL(string: urlString)!
        dataService.fetchModel(from: url, completion: completion)
    }
}
