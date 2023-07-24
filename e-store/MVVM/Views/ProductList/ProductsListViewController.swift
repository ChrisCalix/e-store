//
//  ViewController.swift
//  e-store
//
//  Created by Sonic on 1/3/23.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ProductsListViewController: UIViewController{
    
    var viewModel: ProductListViewModel!
    var collectionView: UICollectionView!
    
    var dataSource = RxCollectionViewSectionedReloadDataSource<ProductsSection>(configureCell: { ds, cv, ip, item in
           switch item {
           case let .product(value):
               let cell = cv.dequeueReusableCell(withReuseIdentifier: "cell", for: ip) as! ProductsListCollectionViewCell
               cell.setupCell(product: value, target: ProductsListViewController.self)
               return cell
           }
       })
       
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        self.initializeNavigationbarItems()
        self.initializeCollectionView()
        
        viewModel.getOffersProduct()
        viewModel
            .products
            .bind(to:
                    collectionView.rx.items(dataSource: dataSource)
            ).disposed(by: bag)
        
        collectionView.rx.modelSelected(ProductModel.self)
            .subscribe(onNext: {
                switch $0 {
                case let .product(value):
                    let vc = ProductDetailViewController()
                    vc.viewModel = ProductDetailViewModel(product: value)
                    
//                    vc.pressOnFavorite = { [indexPath] isFavorite, product in
//                        self.viewModel?.updateProduct(at: indexPath)
//                        DispatchQueue.main.async {
//                            self.collectionView.reloadItems(at: [indexPath])
//                        }
//                    }
                    self.show(vc, sender: nil)
                }
            })
            .disposed(by: bag)
    }
    
    private func initializeNavigationbarItems() {
        self.navigationItem.title = "E-Store"
    }
    
    private func initializeCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .zero
        layout.itemSize = collectionViewCGSize()
        layout.minimumLineSpacing = 24
        layout.minimumInteritemSpacing = 8
        
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        
        view.addSubview(collectionView)
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
    
    func collectionViewCGSize() -> CGSize {
        let columns: CGFloat = 2
       let spacing: CGFloat = 8
       let totalHorizontalSpacing = (columns - 1) * spacing

       let itemWidth = (self.view.bounds.width-40 - totalHorizontalSpacing) / columns
       let itemSize = CGSize(width: itemWidth, height: itemWidth * 0.8)

       return itemSize
    }
}
