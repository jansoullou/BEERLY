//
//  SearchPageViewController.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 17/7/23.
//

import UIKit
import SnapKit

class SearchPageViewController: UIViewController {
    
    var presentorDelegate: SearchPagePresenterDelegate?
    
    private var beerList = [BeerElement]()
    private let search: UISearchBar = {
        let search = UISearchBar()
        search.searchTextField.placeholder = "Search Menu"
        search.searchTextField.textAlignment = .center
        search.searchTextField.font = .systemFont(ofSize: 17, weight: .thin)
        return search
    }()
    
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
            FilteredBeerCollectionViewCell.self,
            forCellWithReuseIdentifier: FilteredBeerCollectionViewCell.reuseIdentifier
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
        search.delegate = self
    }
    
    override func loadView() {
        super.loadView()
        setUpUI()
    }
}

extension SearchPageViewController {
    private func setUpUI() {
        setUpSubviews()
        setUpConstraints()
        setUpSublayers()
        view.backgroundColor = .white
    }
    
    private func setUpSubviews() {
        view.addSubview(headerLabel)
        view.addSubview(search)
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
        
        search.snp.makeConstraints { maker in
            maker.top.equalTo(headerLabel.snp.bottom).offset(20)
            maker.left.equalToSuperview().offset(20)
            maker.right.equalToSuperview().offset(-20)
            maker.height.equalTo(40)
        }
        
        menuCollectionView.snp.makeConstraints { maker in
            maker.top.equalTo(headerLabel.snp.bottom).offset(50)
            maker.leading.trailing.equalToSuperview()
            maker.bottom.equalToSuperview().inset(100)
        }
    }
}

extension SearchPageViewController: SearchPageControllerDelegate {
    func recieveFilteredBeers(beers: [BeerElement]) {
        beerList = beers
        DispatchQueue.main.async {
            self.menuCollectionView.reloadData()
        }
    }
    
    func recieveError(error: Error) {
        print(error.localizedDescription)
    }
}

extension SearchPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        beerList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell( withReuseIdentifier: FilteredBeerCollectionViewCell.reuseIdentifier, for: indexPath
        ) as? FilteredBeerCollectionViewCell else { fatalError() }
        let beer = beerList[indexPath.row]
        cell.displayInfo(product: beer)
        return cell
    }
}

extension SearchPageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let beerInfoVC = BeerInfoPageConfigurator.build(beer: beerList[indexPath.row])
        present(beerInfoVC, animated: true)
    }
}

extension SearchPageViewController: UISearchBarDelegate {
    func searchBar(
        _ searchBar: UISearchBar,
        textDidChange searchText: String
    ) {
        if searchText == "" {
            beerList.removeAll()
            menuCollectionView.reloadData()
        } else {
            presentorDelegate?.getFilteredBeerList(search: searchText)
        }
    }
}

