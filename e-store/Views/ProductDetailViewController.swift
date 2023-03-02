//
//  ProductDetailViewController.swift
//  e-store
//
//  Created by Sonic on 2/3/23.
//

import UIKit

class ProductDetailViewController: UIViewController {
    var product: ProductModel?
    private var imageDataTask: URLSessionDataTask?
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = .systemBackground
        stack.spacing = 16
        return stack
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-SemiBold", size: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 12)
        label.textAlignment = .justified
        label.numberOfLines = 0
        return label
    }()
    
    let currentValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Bold", size: 12)
        
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    let termsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 12)
        label.textAlignment = .justified
        label.numberOfLines = 0
        return label
    }()
    
    private let imageView: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 12
        return iv
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Detail's Product"
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(stackView)
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(currentValueLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(termsLabel)
       
        
        nameLabel.text = product?.name.uppercased()
        descriptionLabel.text = product?.description.uppercased()
        currentValueLabel.text = product?.current_value.uppercased()
        termsLabel.text = product?.terms.uppercased()
        
        NSLayoutConstraint.activate( [
            stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20)
           
        ])
        
        guard let url = URL(string: product?.url ?? "") else { return }
        imageDataTask = imageView.loadFrom(url)
    }
    
    public func setupVC(_ product: ProductModel) {
        self.product = product

    }
}
