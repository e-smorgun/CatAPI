//
//  Cats.swift
//  CatAPI
//
//  Created by Evgeny on 2.09.23.
//

import Foundation

struct CatsBreed: Codable {
    let name: String
    let wikipediaUrl: String
    let referenceImageId: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case wikipediaUrl = "wikipedia_url"
        case referenceImageId = "reference_image_id"
    }
    
    init(name: String, wikipediaUrl: String, referenceImageId: String) {
        self.name = name
        self.wikipediaUrl = wikipediaUrl
        self.referenceImageId = referenceImageId
    }
}
