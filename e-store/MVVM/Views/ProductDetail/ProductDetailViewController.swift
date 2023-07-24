//
//  ProductDetailViewController.swift
//  e-store
//
//  Created by Sonic on 2/3/23.
//

import UIKit
import RxSwift
import RxCocoa

class ProductDetailViewController: UIViewController {
    private var imageDataTask: URLSessionDataTask?
    var pressOnFavorite: ((Bool, Product?) -> Void)?
    
    var viewModel: ProductDetailViewModel?
    let bag = DisposeBag()
    
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
//        self.product?.isFavoritte.toggle()
//        pressOnFavorite?(product?.isFavoritte ?? false, product)
        self.renderFavoriteStateButton()
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
        
        self.fillValuesFromProduct()
    }
    
    private func fillValuesFromProduct() {
        
        viewModel?.loadImage()
            .map({ UIImage(data: $0)})
            .bind(to: imageView.rx.image)
            .disposed(by: bag)
        
        viewModel?.loadDescription()
            .bind(to: descriptionLabel.rx.text)
            .disposed(by: bag)
        
        viewModel?.loadCurrentValue()
            .bind(to: currentValueLabel.rx.text)
            .disposed(by: bag)
        
        viewModel?.loadTitle()
            .bind(to: nameLabel.rx.text)
            .disposed(by: bag)
        
        viewModel?.loadTermsValue()
            .bind(to: termsLabel.rx.text)
            .disposed(by: bag)
        
        renderFavoriteStateButton()
    }
    
    private func renderFavoriteStateButton() {
//        self.favoriteBarbutton.setImage(UIImage(systemName: (product?.isFavoritte ?? false) ? "heart.fill" : "heart"), for: .normal)
    }
    
    private func initializeBarItems() {
        
        self.navigationItem.title = "Detail's Product"
        favoriteBarbutton.addTarget(self, action: #selector(makeFavorite), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: favoriteBarbutton)
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
