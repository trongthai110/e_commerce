//
//  HeaderView.swift
//  e_commerce
//
//  Created by Nguyen Dang Trong Thai on 4/27/23.
//

import UIKit
import SnapKit

class HeaderView: UIView {
    
    var background = UIView()
    var lblCounting = UILabel()
    var btnGoToCart = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }
    
    func setupSubviews() {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .medium)
        let largeBoldDoc = UIImage(systemName: "cart.fill", withConfiguration: largeConfig)
        
        background.backgroundColor = .white
        
        lblCounting.text = "0"
        lblCounting.font = .italicSystemFont(ofSize: 15)
        lblCounting.textColor = .orange
        
        
        btnGoToCart.setImage(largeBoldDoc, for: .normal)
        btnGoToCart.tintColor = .orange
        
        self.addSubview(background)
        background.addSubview(lblCounting)
        background.addSubview(btnGoToCart)
        
    }
    
    override func layoutSubviews() {
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        lblCounting.snp.makeConstraints { make in
            make.centerY.equalTo(btnGoToCart.snp.centerY).offset(-10)
            make.right.equalTo(btnGoToCart.snp.left).offset(1)
            make.left.greaterThanOrEqualTo(10)
        }
        
        btnGoToCart.snp.makeConstraints { make in
            make.right.equalTo(background.snp.right).offset(-20)
            make.top.equalToSuperview().offset(30)
            make.bottom.greaterThanOrEqualTo(5)
        }
    }
}
