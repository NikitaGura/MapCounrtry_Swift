//
//  CountriesCollectionViewFlowLayuot.swift
//  Map_Country
//
//  Created by Nikita Gura on 5/8/19.
//  Copyright © 2019 Nikita Gura. All rights reserved.
//

import UIKit

class CountriesCollectionViewFlowLayuot: UICollectionViewFlowLayout {
    override func prepare() {
        guard let cv = collectionView else {return}
        itemSize = CGSize(width: cv.bounds.inset(by: cv.layoutMargins).size.width, height: 60)
        sectionInset = UIEdgeInsets(top: minimumInteritemSpacing, left: 0, bottom: 0, right: 0)
        sectionInsetReference = .fromSafeArea
    }
}
