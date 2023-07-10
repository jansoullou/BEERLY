//
//  BeerCollectionViewCell.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 10/7/23.
//

import UIKit
import SnapKit
import Kingfisher

class BeerCollectionViewCell: UICollectionViewCell {
    
    static var reuseIdentifier = String(describing: BeerCollectionViewCell.self)
    
    var drink: BeerElement?
    
    private lazy var productImage: UIImageView! = {
        var productImage = UIImageView()
        productImage.contentMode = .scaleAspectFit
        productImage.clipsToBounds = true
        productImage.layer.shadowOffset = .init(width: 15, height: 10)
        productImage.layer.shadowOpacity = 0.4
        productImage.layer.shadowColor = UIColor.gray.cgColor
        return productImage
    }()
    
    private lazy var borderLineView: UIView = {
        var view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var productLabel: UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir Next Bold", size: 15)
        return label
    }()
    
    private lazy var taglineLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "Avenir Next", size: 11)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "Avenir Next", size: 11)
        label.textColor = UIColor(cgColor: CGColor(
            red: 111/265,
            green: 64/265,
            blue: 181/265,
            alpha: 0.85))
        label.numberOfLines = 12
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BeerCollectionViewCell {
    
    private func setUpUI() {
        setUpSubviews()
        setUpConstraints()
    }
    
    private func setUpSubviews() {
        addSubview(productImage)
        addSubview(productLabel)
        addSubview(borderLineView)
        addSubview(taglineLabel)
        addSubview(descriptionLabel)
    }
    
    private func setUpConstraints() {
        productImage.snp.makeConstraints{ maker in
            maker.top.equalToSuperview().offset(10)
            maker.left.equalToSuperview().offset(10)
            maker.height.equalTo(220)
            maker.width.equalTo(150)
        }
        
        productLabel.snp.makeConstraints{ maker in
            maker.top.equalToSuperview().offset(15)
            maker.left.equalTo(productImage.snp.right).offset(10)
            maker.right.equalToSuperview()
        }
        
        borderLineView.snp.makeConstraints { maker in
            maker.top.equalTo(productLabel.snp.bottom).offset(10)
            maker.left.equalTo(productLabel)
            maker.right.equalTo(productLabel).inset(50)
            maker.height.equalTo(2)
        }
        
        taglineLabel.snp.makeConstraints { maker in
            maker.top.equalTo(borderLineView.snp.bottom).offset(10)
            maker.left.right.equalTo(productLabel)
        }
        
        descriptionLabel.snp.makeConstraints { maker in
            maker.top.equalTo(taglineLabel.snp.bottom).offset(10)
            maker.left.right.equalTo(productLabel)
        }
    }
    
    func displayInfo(product: BeerElement) {
        drink = product
        productLabel.text = product.name?.uppercased()
        taglineLabel.text = product.tagline?.uppercased()
        descriptionLabel.text = product.description?.uppercased()
        productImage.kf.setImage(with: URL(string: product.imageURL ?? ""))
    }
}




