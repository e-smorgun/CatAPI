//
//  ViewController.swift
//  CatAPI
//
//  Created by Evgeny on 2.09.23.
//

import UIKit
import SafariServices

class BreedViewController: UIViewController {
    
    private let viewModel = BreedViewModel()
    private let breedView = BreedView()
    
    let itemsPerRow: CGFloat = 2
    let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    var isDarkModeEnabled = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchBreeds()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        let darkModeButton = UIButton(type: .system)
            darkModeButton.setTitle("Toggle Dark Mode", for: .normal)
            darkModeButton.addTarget(self, action: #selector(darkModeButtonTapped), for: .touchUpInside)
            view.addSubview(darkModeButton)
            darkModeButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                // Adjust the button's constraints as needed
                darkModeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
                darkModeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            ])
        
        breedView.collectionView.delegate = self
        breedView.collectionView.dataSource = self
        view.addSubview(breedView)
        breedView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            breedView.topAnchor.constraint(equalTo: darkModeButton.bottomAnchor),
            breedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            breedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            breedView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc private func darkModeButtonTapped() {
        toggleDarkMode()
    }
    
    func toggleDarkMode() {
        isDarkModeEnabled.toggle()
        breedView.collectionView.backgroundColor = isDarkModeEnabled ? .black : .white
        view.backgroundColor = isDarkModeEnabled ? .black : .white
    }

    private func fetchBreeds() {
        viewModel.fetchBreeds { [weak self] in
            self?.breedView.collectionView.reloadData()
        }
    }
}

extension BreedViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.breeds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BreedCell", for: indexPath)
        configureCell(cell, forItemAt: indexPath)
        return cell
    }
    
    func configureCell(_ cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.backgroundColor = .lightGray
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        let imageURL = URL(string: "https://cdn2.thecatapi.com/images/\(viewModel.breeds[indexPath.item].referenceImageId).jpg")!
        
        let imageView = createImageView(for: cell.contentView.bounds)
        viewModel.loadImage(at: imageURL, into: imageView)
        
        let nameLabel = createNameLabel(for: cell.contentView.bounds, indexPath: indexPath)
        
        cell.layer.cornerRadius = 10
        cell.contentView.addSubview(imageView)
        cell.contentView.addSubview(nameLabel)
    }
    
    func createImageView(for frame: CGRect) -> UIImageView {
        let imageView = UIImageView(frame: frame)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }
    
    func createNameLabel(for frame: CGRect, indexPath: IndexPath) -> UILabel {
        let nameLabel = UILabel(frame: CGRect(x: 0, y: frame.height - 40, width: frame.width, height: 40))
        nameLabel.textAlignment = .center
        nameLabel.backgroundColor = .white
        nameLabel.text = viewModel.breeds[indexPath.item].name
        nameLabel.textColor = .black
        nameLabel.layer.opacity = 0.8
        return nameLabel
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem) // Размер ячейки
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let breed = viewModel.breeds[indexPath.item]
        let safariViewController = SFSafariViewController(url: URL(string: breed.wikipediaUrl)!)
        safariViewController.modalPresentationStyle = .overFullScreen
        present(safariViewController, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastItem = viewModel.breeds.count - 1
        if indexPath.item == lastItem && !viewModel.isLoading {
            viewModel.currentPage += 1
            fetchBreeds()
        }
    }
}
