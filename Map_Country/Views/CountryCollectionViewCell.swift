//
//  CountryCollectionViewCell.swift
//  Map_Country
//
//  Created by Nikita Gura on 5/8/19.
//  Copyright © 2019 Nikita Gura. All rights reserved.
//

import UIKit

class CountryCollectionViewCell: UICollectionViewCell {
    
    //MARK: Variables
    private lazy var labelCountry = UILabel()
    
    public var country: Country?{
        didSet{
            labelCountry.text = country?.name
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewCell()
        setupLabelCountry()
        addSubview(labelCountry)
        setupLayout()
    }
    
    //MARK: Methods
    
    private func setupViewCell(){
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8.0
    }
    
    private func setupLabelCountry(){
        labelCountry.font = UIFont.boldSystemFont(ofSize: 16)
        labelCountry.textAlignment = .center
    }
    
    private func setupLayout(){
        labelCountry.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            labelCountry.widthAnchor.constraint(equalTo: widthAnchor),
            labelCountry.heightAnchor.constraint(equalTo: heightAnchor),
            labelCountry.leadingAnchor.constraint(equalTo: leadingAnchor),
            labelCountry.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
