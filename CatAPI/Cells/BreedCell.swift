//
//  BreedCell.swift
//  CatAPI
//
//  Created by Evgeny on 3.09.23.
//

import UIKit

class BreedsCell: UICollectionViewCell {
    static let identifier = "BreedCell"
    let containerView = UIView()
    let imageView = UIImageView()
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        setupViews()
//        setupConstraints()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        contentView.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        // Настройка вида ячейки
        imageView.contentMode = .scaleToFill
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        
        // Добавление вида на контейнер
        containerView.addSubview(label)
        containerView.addSubview(imageView)
        containerView.backgroundColor = .red
        contentView.addSubview(containerView)
        }
}
