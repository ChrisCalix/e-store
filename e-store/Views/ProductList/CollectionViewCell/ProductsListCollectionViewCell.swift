//
//  ProductListCollectionViewCell.swift
//  e-store
//
//  Created by Sonic on 2/3/23.
//

import UIKit

class ProductsListCollectionViewCell: UICollectionViewCell {
    
    private let card: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageBG: UIView = {
        let bg = UIView()
        bg.backgroundColor = .systemGray6
        bg.clipsToBounds = true
        bg.translatesAutoresizingMaskIntoConstraints = false
        bg.layer.cornerRadius = 5
        return bg
    }()
    
    private let image: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 12
        return iv
    }()
    
    let ammountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 12)
        // #4A4A4A
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont(name: "AvenirNext-Regular", size: 11)
        label.sizeToFit()
        return label
    }()
    
    let favoriteButton: UIButton = {
        let btn = UIButton()
        let image = UIImage(systemName: "heart")
        btn.frame = CGRectMake(0, 0, 20, 20)
        btn.setImage(image, for: .normal)
        btn.tintColor = .red
        btn.contentMode = .scaleAspectFit
        // add target
        return btn
    }()
    
    private var imageDataTask: URLSessionDataTask?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(card)
        card.addSubview(imageBG)
        imageBG.addSubview(image)
        card.addSubview(ammountLabel)
        card.addSubview(nameLabel)
        image.addSubview(favoriteButton)
        
        
        NSLayoutConstraint.activate([
            self.card.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor),
            self.card.bottomAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor),
            self.card.rightAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.rightAnchor),
            self.card.leftAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leftAnchor),
            
            self.imageBG.topAnchor.constraint(equalTo: self.card.topAnchor),
            self.imageBG.leftAnchor.constraint(equalTo: self.card.leftAnchor),
            self.imageBG.rightAnchor.constraint(equalTo: self.card.rightAnchor),
            self.imageBG.heightAnchor.constraint(equalToConstant: 100),
            
            self.image.topAnchor.constraint(equalTo: self.imageBG.topAnchor, constant: 6),
            self.image.bottomAnchor.constraint(equalTo: self.imageBG.bottomAnchor, constant: -6),
            self.image.leftAnchor.constraint(equalTo: self.imageBG.leftAnchor, constant: 6),
            self.image.rightAnchor.constraint(equalTo: self.imageBG.rightAnchor, constant: -6),
            
            self.ammountLabel.topAnchor.constraint(equalTo: self.imageBG.bottomAnchor, constant: 8),
            self.ammountLabel.leftAnchor.constraint(equalTo: self.card.leftAnchor),
            self.ammountLabel.rightAnchor.constraint(equalTo: self.card.rightAnchor),
            
            self.nameLabel.topAnchor.constraint(equalTo: self.ammountLabel.bottomAnchor, constant: 3),
            self.nameLabel.leftAnchor.constraint(equalTo: self.card.leftAnchor),
            self.nameLabel.rightAnchor.constraint(equalTo: self.card.rightAnchor),
            self.nameLabel.bottomAnchor.constraint(equalTo: self.card.bottomAnchor),
            
            self.favoriteButton.topAnchor.constraint(equalTo: self.image.topAnchor),
            self.favoriteButton.rightAnchor.constraint(equalTo: self.image.rightAnchor),
            self.favoriteButton.heightAnchor.constraint(equalToConstant: 20),
            self.favoriteButton.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.image.image = nil
        imageDataTask?.cancel()
    }
                                 
    @objc func makeFavorite() {
        print("join button")
        self.favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func setupCell(product: ProductModel, target: Any?) {
        guard let url = URL(string: product.url) else { return }
        
        imageDataTask = image.loadFrom(url)
        
        ammountLabel.text = product.current_value
        nameLabel.text = product.name
        favoriteButton.isHidden = !product.isFavoritte
    }
}


