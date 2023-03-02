//
//  ViewController.swift
//  e-store
//
//  Created by Sonic on 1/3/23.
//

import UIKit

class ProductsListViewController: UICollectionViewController {
    
    private var viewModel: ProductListViewModel?
    
    convenience init(viewModel: ProductListViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        self.initializeNavigationbarItems()
        self.initializeCollectionView()
        
        viewModel?.getOffersProduct()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.products.value?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueCell(in: collectionView, at: indexPath)
        if let product = viewModel?.getProduct(at: indexPath) {
            cell.setupCell(product: product, target: self)
        }
        return cell
    }
    
    private func dequeueCell(in collectionView: UICollectionView, at indexPath: IndexPath) -> ProductsListCollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ProductsListCollectionViewCell else {
            return ProductsListCollectionViewCell()
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ProductDetailViewController()
        if let product = viewModel?.getProduct(at: indexPath) {
            vc.setupVC(product)
        }
        
        self.show(vc, sender: nil)
       
    }
    
    private func initializeNavigationbarItems() {
        self.navigationItem.title = "E-Store"
    }
    
    private func initializeCollectionView() {
        
        collectionView.register(ProductsListCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(setContriantsForCollectionView())
    }
    
    private func setContriantsForCollectionView() -> [NSLayoutConstraint] {
        return  [
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 12),
            collectionView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -12)
        ]
    }
}
