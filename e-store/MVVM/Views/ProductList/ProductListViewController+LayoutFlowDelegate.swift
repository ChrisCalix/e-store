//
//  ProductListViewController+LayoutFlowDelegate.swift
//  e-store
//
//  Created by Sonic on 2/3/23.
//

import UIKit

//extension ProductsListViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        var columns: CGFloat
//        
//        let orientation = UIApplication.shared.connectedScenes.flatMap{ ($0 as? UIWindowScene)?.windows ?? [] }.first?.windowScene?.interfaceOrientation
//        
//        if orientation == .landscapeLeft || orientation == .landscapeRight {
//            columns = 4
//        } else {
//            columns = 2
//        }
//        
//        let spacing: CGFloat = 8
//        let totalHorizontalSpacing = (columns - 1) * spacing
//        
//        let itemWidth = (self.collectionView.bounds.width - totalHorizontalSpacing) / columns
//        let itemSize = CGSize(width: itemWidth, height: itemWidth * 0.8)
//        
//        return itemSize
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        24
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        8
//    }
//}
