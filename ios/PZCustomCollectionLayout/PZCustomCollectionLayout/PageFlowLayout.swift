//
//  PageFlowLayout.swift
//  PZCustomCollectionLayout
//
//  Created by parkinwu on 16/9/18.
//  Copyright © 2016年 parkinwu. All rights reserved.
//

import UIKit

class PageFlowLayout: UICollectionViewLayout {
    
    
    var contentSize: CGSize = CGSize(width: 0, height: 0)
    
    
    override func prepare() {
        super.prepare()
        
    }
    
    
    override var collectionViewContentSize: CGSize {
        get {
            return CGSize(width: 1000, height: 1000)
        }
    }
    
    // 废弃掉已经计算好的布局
    override func invalidateLayout(with context: UICollectionViewLayoutInvalidationContext) {
        super.invalidateLayout(with: context)
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attrs: [UICollectionViewLayoutAttributes] = []
        if let visibleCells = collectionView?.visibleCells {
            
            for cell in visibleCells {
                if let indexPath = collectionView?.indexPath(for: cell),
                   let attr = self.layoutAttributesForItem(at: indexPath),
                   cell.frame.intersects(rect)  {
                   
                    attrs.append(attr)
                    
                }
                
            }
        }
       return attrs
    }
    
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attr.size = CGSize(width: 50, height: 50)
        attr.center = CGPoint(x: 50 * indexPath.row + 25, y: 50 * indexPath.row + 25)
        return attr
    }
    
    
    
}
