//
//  BeerInfoViewController.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 10/7/23.
//

import UIKit
import SnapKit
import Kingfisher

class BeerInfoViewController: UIViewController {
    
    private var beer: BeerElement?
    
    var beerPresentorDelegate: BeerInfoPresentorDelegate?
    
    init(beer: BeerElement?) {
        super.init(nibName: nil, bundle: nil)
        self.beer = beer
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var containerView: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(
                               red: 0.9,
                               green: 0.9,
                               blue: 0.9,
                               alpha: 0.55)
        view.layer.cornerRadius = 25
        view.layer.shadowOffset = .init(width: 2, height: 6)
        view.layer.shadowOpacity = 0.4
        return view
    }()
    
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
        label.font = UIFont(name: "Avenir Next Bold", size: 20)
        return label
    }()
    
    private lazy var taglineLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "Avenir Next", size: 15)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private lazy var descriptionTextView: UITextView = {
        var textView = UITextView()
        textView.font = UIFont(name: "Avenir Next", size: 17)
        textView.showsVerticalScrollIndicator = false
        textView.backgroundColor = .clear
        textView.isEditable = false
        return textView
    }()
    
    private lazy var contributorLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "Avenir Next Bold", size: 12)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    private lazy var brewersTipsLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "Avenir Next", size: 15)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private lazy var addToBasketButton: AddToBasketCustomButton = {
        var button = AddToBasketCustomButton()
        button.addTarget(self, action: #selector(addToBasket), for: .touchUpInside)
        return button
    }()
    
    private lazy var alert: UIAlertController = {
        var alert = UIAlertController (title: "Added to cart", message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        return alert
    }()
    
    override func loadView() {
        super.loadView()
        setUpUI()
    }
}

extension BeerInfoViewController {
    
    @objc
    private func addToBasket() {
        guard let beer = beer else { return }
        buttonTouched(object: beer)
        present(alert, animated: true, completion: nil)
    }
    
    private func setUpUI() {
        setUpSubviews()
        setUpConstraints()
        displayInfo(beer: beer!)
        view.backgroundColor = .white
    }
    
    private func setUpSubviews() {
        view.addSubview(containerView)
        containerView.addSubview(productImage)
        containerView.addSubview(productLabel)
        containerView.addSubview(borderLineView)
        containerView.addSubview(taglineLabel)
        containerView.addSubview(contributorLabel)
        containerView.addSubview(brewersTipsLabel)
        view.addSubview(descriptionTextView)
        view.addSubview(addToBasketButton)
    }
    
    private func setUpConstraints() {
        containerView.snp.makeConstraints { maker in
            maker.top.equalToSuperview()
            maker.left.right.equalToSuperview()
            maker.height.equalTo(400)
        }
        
        productImage.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(70)
            maker.right.equalToSuperview().inset(10)
            maker.width.equalTo(150)
            maker.height.equalTo(350)
        }
        
        productLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(100)
            maker.left.equalToSuperview().offset(40)
            maker.right.equalTo(productImage.snp.left).offset(-10)
        }
        
        borderLineView.snp.makeConstraints { maker in
            maker.top.equalTo(productLabel.snp.bottom).offset(10)
            maker.left.equalTo(productLabel)
            maker.width.equalTo(productLabel)
            maker.height.equalTo(2)
        }
        
        taglineLabel.snp.makeConstraints { maker in
            maker.top.equalTo(borderLineView.snp.bottom).offset(10)
            maker.left.equalTo(productLabel)
            maker.right.equalTo(productImage.snp.left).offset(-5)
        }
        
        descriptionTextView.snp.makeConstraints { maker in
            maker.top.equalTo(containerView.snp.bottom).offset(30)
            maker.left.equalToSuperview().offset(20)
            maker.right.equalToSuperview().inset(20)
            maker.height.equalTo(235)
        }
        
        contributorLabel.snp.makeConstraints { maker in
            maker.top.equalTo(brewersTipsLabel.snp.bottom).offset(10)
            maker.left.equalTo(productLabel)
            maker.width.equalTo(160)
        }
        
        brewersTipsLabel.snp.makeConstraints { maker in
            maker.top.equalTo(taglineLabel.snp.bottom).offset(10)
            maker.left.equalTo(productLabel)
            maker.right.equalTo(productImage.snp.left).offset(-5)
            maker.height.equalTo(100)
        }
        
        addToBasketButton.snp.makeConstraints { maker in
            maker.bottom.equalToSuperview().inset(50)
            maker.left.equalToSuperview().offset(30)
            maker.right.equalToSuperview().inset(30)
            maker.height.equalTo(60)
        }
    }
    
    private func displayInfo(beer: BeerElement) {
        productLabel.text = beer.name?.uppercased()
        descriptionTextView.text = beer.description
        taglineLabel.text = beer.tagline?.uppercased()
        contributorLabel.text = beer.contributedBy?.uppercased()
        brewersTipsLabel.text = beer.brewersTips
        productImage.kf.setImage(with: URL(string: beer.imageURL ?? ""))
    }
}

extension BeerInfoViewController: BeerInfoVCDelegate {
    func buttonTouched(object: BeerElement) {
        let model = object.toBeerElementDTO()
        self.beerPresentorDelegate?.addBeerToTheBasket(object: model)
    }
}

