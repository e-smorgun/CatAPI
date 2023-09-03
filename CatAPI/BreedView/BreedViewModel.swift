//
//  BreedListViewModel.swift
//  CatAPI
//
//  Created by Evgeny on 3.09.23.
//

import Foundation
import UIKit

class BreedViewModel {
    var currentPage = 0
    var isLoading = false
    let breedService = BreedService()
    var breeds = [CatsBreed]()
    
    func fetchBreeds(completion: @escaping () -> Void) {
        if isLoading { return }
        isLoading = true
        
        breedService.fetchBreeds(page: currentPage) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let breeds):
                    self.breeds.append(contentsOf: breeds)
                    completion()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func loadImage(at url: URL, into imageView: UIImageView) {
        getImage(with: url) { image in
            if let image = image {
                DispatchQueue.main.async {
                    imageView.image = image
                }
            } else {
                DispatchQueue.main.async {
                    imageView.image = UIImage(named: "Error")
                }
            }
        }
    }
}
