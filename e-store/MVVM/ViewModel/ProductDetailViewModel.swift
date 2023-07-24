//
//  ProductDetailViewModel.swift
//  e-store
//
//  Created by Sonic on 23/7/23.
//

import Foundation
import RxSwift
import RxCocoa

struct ProductDetailViewModel {
    var product: Observable<Product>
    let url: URL
    
    init(product: Product) {
        self.product = Observable.just(product)
        url = URL(string: product.url)!
    }
    
    func loadImage() -> Observable<Data> {
        Observable.create { obs in
            URLSession.shared.rx.response(request: URLRequest(url: self.url)).debug("rxrequest").subscribe(onNext: { response in
                return obs.onNext(response.data)
            })
        }
    }
    
    func loadTitle() -> Observable<String> {
        product.map {
            $0.name.uppercased()
        }
    }
    
    func loadDescription() -> Observable<String> {
        product.map {
            $0.description.uppercased()
        }
    }
    
    func loadCurrentValue() -> Observable<String> {
        product.map {
            $0.current_value.uppercased()
        }
    }
    
    func loadTermsValue() -> Observable<String> {
        product.map {
            $0.terms.uppercased()
        }
    }
}
