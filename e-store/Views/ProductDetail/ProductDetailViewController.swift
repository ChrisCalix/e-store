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
    
    private let favoriteBarbutton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(systemName: "heart"), for: .normal)
        btn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn.tintColor = .red
        return btn
    }()
    
    @objc func makeFavorite() {
        self.product?.isFavoritte.toggle()
        self.favoriteBarbutton.setImage(UIImage(systemName: (product?.isFavoritte ?? false) ? "heart.fill" : "heart"), for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
    }
    
    private func setupViews() {
        
        initializeBarItems()
        
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(stackView)
        
        loadStackView(views: [nameLabel,
                              imageView,
                              currentValueLabel,
                              descriptionLabel,
                              termsLabel])
        
        NSLayoutConstraint.activate( setContriantsForStaclView() )
        
        guard let product else { return }
        self.fillValuesFromProduct(product: product)
    }
    
    private func fillValuesFromProduct(product: ProductModel) {
        nameLabel.text = product.name.uppercased()
        descriptionLabel.text = product.description.uppercased()
        currentValueLabel.text = product.current_value.uppercased()
        termsLabel.text = product.terms.uppercased()
        
        guard let url = URL(string: product.url) else { return }
        imageDataTask = imageView.loadFrom(url)
    }
    
    private func initializeBarItems() {
        
        self.navigationItem.title = "Detail's Product"
        favoriteBarbutton.addTarget(self, action: #selector(makeFavorite), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: favoriteBarbutton)
    }
    
    public func setupVC(_ product: ProductModel) {
        
        self.product = product
    }
    
    private func setContriantsForStaclView() -> [NSLayoutConstraint] {
        return [
            stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20)
        ]
    }
    
    private func loadStackView(views: [UIView]) {
        for view in views {
            stackView.addArrangedSubview(view)
        }
    }
}
