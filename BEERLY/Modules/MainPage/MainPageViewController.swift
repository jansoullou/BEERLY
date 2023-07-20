//
//  MainPageViewController.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 10/7/23.
//

import UIKit
import SnapKit

class MainPageViewController: UIViewController {
    
    var mainPagePresentorDelegate: MainPagePresenterDelegate?
    
    private var beerList = [BeerElement]()
    private var currentPage = 1
    private let totalPage = 13
    
    private lazy var headerLabel: UILabel = {
        var label = UILabel()
        label.text = "BEERSHOP"
        label.font = UIFont(name: "Avenir Next Bold", size: 30)
        label.textColor = .white
        label.textAlignment = .left
        label.layer.shadowOffset = .init(width: 5, height: 5)
        label.layer.shadowOpacity = 1
        return label
    }()
    
    private lazy var menuCollectionView: UICollectionView = {
        var viewLayout = UICollectionViewFlowLayout()
        viewLayout.itemSize = CGSize(width: view.frame.width, height: 320)
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            BeerCollectionViewCell.self,
            forCellWithReuseIdentifier: BeerCollectionViewCell.reuseIdentifier
        )
        collectionView.register(
            LoadingCollectionViewCell.self,
            forCellWithReuseIdentifier: LoadingCollectionViewCell.reuseIdentifier
        )

        return collectionView
    }()
    
    private lazy var balanceViewGradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [UIColor.white.cgColor,
                           UIColor(
                           red: 0.962,
                           green: 0.868,
                           blue: 0.962,
                           alpha: 0.85)
                           .cgColor
        ]
        gradient.startPoint = CGPoint(x: 0.7, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.frame = view.bounds
        return gradient
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainPagePresentorDelegate?.getBeerList(page: currentPage)
    }
    
    override func loadView() {
        super.loadView()
        setUpUI()
    }
}

extension MainPageViewController {
    
    private func setUpUI() {
        setUpSubviews()
        setUpConstraints()
        setUpSublayers()
        view.backgroundColor = .white
    }
    
    private func setUpSubviews() {
        view.addSubview(headerLabel)
        view.addSubview(menuCollectionView)
    }
    
    private func setUpSublayers() {
        view.layer.insertSublayer(balanceViewGradient, at: 0)
    }
    
    private func setUpConstraints() {
        headerLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(80)
            maker.centerX.equalToSuperview()
        }
       
        menuCollectionView.snp.makeConstraints { maker in
            maker.top.equalTo(headerLabel.snp.bottom).offset(50)
            maker.leading.trailing.equalToSuperview()
            maker.bottom.equalToSuperview().inset(100)
        }
    }
}

extension MainPageViewController: MainPageControllerDelegate {
    func recieveBeer(beers: [BeerElement]) {
        beerList += beers
        DispatchQueue.main.async {
            self.menuCollectionView.reloadData()
        }
    }
    
    func recieveError(error: Error) {
        print(error.localizedDescription)
    }
}

extension MainPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        beerList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if currentPage < totalPage && indexPath.row == beerList.count - 1 {
            guard let cell = collectionView.dequeueReusableCell( withReuseIdentifier: LoadingCollectionViewCell.reuseIdentifier, for: indexPath
            ) as? LoadingCollectionViewCell else { fatalError() }
            cell.loadingIndicator.startAnimating()
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell( withReuseIdentifier: BeerCollectionViewCell.reuseIdentifier, for: indexPath
            ) as? BeerCollectionViewCell else { fatalError() }
            guard !beerList.isEmpty else { fatalError() }
            let beer = beerList[indexPath.row]
            cell.displayInfo(product: beer)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if currentPage < totalPage && indexPath.row == beerList.count - 1 {
            currentPage += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.mainPagePresentorDelegate?.getBeerList(page: self.currentPage)
            }
        }
    }
}

extension MainPageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let beerInfoVC = BeerInfoPageConfigurator.build(beer: beerList[indexPath.row])
        present(beerInfoVC, animated: true)
    }
}


