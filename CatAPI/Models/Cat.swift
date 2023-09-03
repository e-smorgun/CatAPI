//
//  Cat.swift
//  CatAPI
//
//  Created by Evgeny on 2.09.23.
//

import Foundation

struct CatModel: Codable {
    let id: String
    let url: String
    let breeds: [BreedModel]
    let width: Int
    let height: Int
}

struct BreedModel: Codable {
    let name: String
    let wikipediaURL: String
}
