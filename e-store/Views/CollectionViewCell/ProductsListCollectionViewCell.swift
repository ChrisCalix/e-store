//
//  ProductListCollectionViewCell.swift
//  e-store
//
//  Created by Sonic on 2/3/23.
//

import UIKit

class ProductsListCollectionViewCell: UICollectionViewCell {
    
    let card: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imageBG: UIView = {
        let bg = UIView()
        bg.backgroundColor = .systemGray6
        bg.clipsToBounds = true
        bg.translatesAutoresizingMaskIntoConstraints = false
        bg.layer.cornerRadius = 5
        return bg
    }()
    
    let image: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
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
    
    
    
    var product: FeedProduct?
    var imageDataTask: URLSessionDataTask?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(card)
        card.addSubview(imageBG)
        imageBG.addSubview(image)
        card.addSubview(ammountLabel)
        card.addSubview(nameLabel)
        
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
            self.nameLabel.bottomAnchor.constraint(equalTo: self.card.bottomAnchor)
            
        ])
        
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupCell(product: FeedProduct) {
        self.product = product
        guard let url = URL(string: product.url) else { return }
        
        imageDataTask = image.loadFrom(url) { [weak self] image in
            guard let self else { return }
            self.image.image = image
        }
        
        ammountLabel.text = product.current_value
        nameLabel.text = product.name
    }
}

extension UIImageView {
    func loadFrom(_ url: URL, completion: @escaping (_ image: UIImage?) -> ()) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data else {
                completion(nil)
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }
        task.resume()
        return task
    }
}
