//
//  AddToBasketButton.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 10/7/23.
//

import UIKit

class AddToBasketCustomButton: UIButton {
    
    lazy var basketIcon: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(systemName: "basket.fill")
        imageView.tintColor = .white
        return imageView
    }()
    
    lazy var addLabel: UILabel = {
        var label = UILabel()
        label.text = "Add Beer"
        label.font = UIFont(name: "Avenir Next Bold", size: 14)
        label.textColor = .white
        
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

extension AddToBasketCustomButton {
  
    private func setUpUI() {
        setUpSubviews()
        setUpConstraints()
        backgroundColor =  UIColor(cgColor: CGColor(
                                            red: 111/265,
                                          green: 64/265,
                                           blue: 181/265,
                                          alpha: 0.4))
        layer.cornerRadius = 15
    }
    
    private func setUpSubviews() {
        addSubview(basketIcon)
        addSubview(addLabel)
    }
    
    private func setUpConstraints() {
        basketIcon.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.right.equalToSuperview().inset(30)
            maker.width.height.equalTo(21)
        }
        
        addLabel.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.left.equalToSuperview().offset(30)
        }
    }
}


