//
//  LoadingCollectionViewCell.swift
//  BEERLY
//
//  Created by Zhansuluu Kydyrova on 17/7/23.
//

import UIKit
import SnapKit

class LoadingCollectionViewCell: UICollectionViewCell {
    
    static var reuseIdentifier = String(describing: LoadingCollectionViewCell.self)
    
    let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        setUpSubviews()
        setupConstraints()
    }
    
    private func setUpSubviews() {
        addSubview(loadingIndicator)
    }
    
    private func setupConstraints() {
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
