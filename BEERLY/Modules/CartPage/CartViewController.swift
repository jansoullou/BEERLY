//
//  CartViewController.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 10/7/23.
//

import UIKit
import SnapKit

class CartViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var presentorToVC: CartPresentorToVC?
    var presentorToService: CartPresentorToService?
    
    private var addedBeersList = [BeerElement]()
    
    private lazy var headerLabel: UILabel = {
        var label = UILabel()
        label.text = "MY CART"
        label.font = UIFont(name: "Avenir Next Bold", size: 30)
        label.textColor = .white
        label.textAlignment = .left
        label.layer.shadowOffset = .init(width: 5, height: 5)
        label.layer.shadowOpacity = 0.5
        return label
    }()
    
    private lazy var addedBeersCollectionView: UICollectionView = {
        var viewLayout = UICollectionViewFlowLayout()
        viewLayout.itemSize = CGSize(width: view.frame.width, height: 280)
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.dataSource = self
        collectionView.register(AddedDrinkCollectionViewCell.self, forCellWithReuseIdentifier: AddedDrinkCollectionViewCell.reuseIdentifier
        )
        return collectionView
    }()
    
    private lazy var orderButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = UIColor(
                                 red: 0.88,
                                 green: 0.868,
                                 blue: 0.962,
                                 alpha: 0.9)
        button.layer.cornerRadius = 15
        button.layer.shadowOffset = .init(width: 5, height: 5)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowColor = UIColor.lightGray.cgColor
        
        button.setTitle("Order", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Bold", size: 20)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.layer.shadowOffset = .init(width: 2, height: 2)
        button.titleLabel?.layer.shadowOpacity = 1
        button.titleLabel?.layer.shadowColor = UIColor.gray.cgColor
        
        button.addTarget(self, action: #selector(getOrderButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var deleteAllButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = UIColor(
                                 red: 240/265,
                                 green: 240/265,
                                 blue: 240/265,
                                 alpha: 0.8)
        button.layer.cornerRadius = 15
        button.layer.shadowOffset = .init(width: 5, height: 5)
        button.layer.shadowOpacity = 0.8
        button.layer.shadowColor = UIColor.darkGray.cgColor
        
        button.setTitle("Clean", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Bold", size: 20)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.layer.shadowOffset = .init(width: 2, height: 2)
        button.titleLabel?.layer.shadowOpacity = 1
        button.titleLabel?.layer.shadowColor = UIColor.lightGray.cgColor
        
        button.addTarget(self, action: #selector(deleteAll), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var alert: UIAlertController = {
        var alert = UIAlertController (title: "Your order is accepted", message: "Wait for the call. Your phone number: \(appDelegate.userAddInfo?.phoneNum)", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        return alert
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        fetchProducts()
        presentorToVC?.sendProducts()
    }
    
    override func loadView() {
        super.loadView()
        setUpUI()
    }
    
    @objc
    func getOrderButton() {
        present(alert, animated: true)
        do {
            try presentorToService?.deleteAll()
        } catch {
            print(error.localizedDescription)
        }
        
        addedBeersList = [BeerElement]()
        addedBeersCollectionView.reloadData()
    }
    
    @objc
    func deleteAll() {
        do {
            try presentorToService?.deleteAll()
        } catch {
            print(error.localizedDescription)
        }
        
        addedBeersList = [BeerElement]()
        addedBeersCollectionView.reloadData()
    }
}

extension CartViewController {
    private func setUpUI() {
        setUpSubviews()
        setUpConstraints()
        view.backgroundColor = UIColor(
                               red: 0.958,
                               green: 0.958,
                               blue: 0.958,
                               alpha: 1)
    }
    
    private func setUpSubviews() {
        view.addSubview(headerLabel)
        view.addSubview(addedBeersCollectionView)
        view.addSubview(orderButton)
        view.addSubview(deleteAllButton)
    }
    
    private func setUpConstraints() {
        headerLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(80)
            maker.centerX.equalToSuperview()
        }
        
        addedBeersCollectionView.snp.makeConstraints { maker in
            maker.top.equalTo(headerLabel.snp.bottom).offset(30)
            maker.left.right.equalToSuperview()
            maker.bottom.equalTo(orderButton.snp.top).offset(-35)
        }
        
        orderButton.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(20)
            maker.width.equalTo(205)
            maker.bottom.equalToSuperview().offset(-100)
            maker.height.equalTo(50)
        }
        
        deleteAllButton.snp.makeConstraints { maker in
            maker.right.equalToSuperview().offset(-20)
            maker.width.equalTo(135)
            maker.bottom.equalToSuperview().offset(-100)
            maker.height.equalTo(50)
        }
    }
}

extension CartViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        addedBeersList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell( withReuseIdentifier: AddedDrinkCollectionViewCell.reuseIdentifier, for: indexPath
        ) as? AddedDrinkCollectionViewCell else { fatalError() }
        guard !addedBeersList.isEmpty else { fatalError() }
        let beer = addedBeersList[indexPath.row]
        cell.displayInfo(product: beer)
        return cell
    }
}

extension CartViewController: CartVCToPresentor{
    func receiveProducts(products: [BeerElement]) {
        addedBeersList = products
        DispatchQueue.main.async {
            self.addedBeersCollectionView.reloadData()
        }
    }
    
    func fetchProducts() {
        presentorToService?.fetchProductsToList()
    }
}

