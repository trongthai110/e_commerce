//
//  FooterView.swift
//  e_commerce
//
//  Created by Nguyen Dang Trong Thai on 4/28/23.
//

import UIKit
import SnapKit

class FooterView: UIView {
    
    var background = UIView()
    var lblTotal = UILabel()
    var lblPrice = UILabel()
    var lblPrivacy = UILabel()
    var btnGoToCheckOut = UIButton(type: .system)
    
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
        
        background.backgroundColor = .white
        
        lblTotal.text = ""
        lblTotal.font = .italicSystemFont(ofSize: 20)
        lblTotal.textColor = .black
        
        lblPrice.text = ""
        lblPrice.font = .italicSystemFont(ofSize: 15)
        lblPrice.textColor = .orange
        
        lblPrivacy.text = ""
        lblPrivacy.font = .systemFont(ofSize: 20)
        lblPrivacy.textColor = .black
        lblPrivacy.textAlignment = .center
        
        btnGoToCheckOut.backgroundColor = .black
        btnGoToCheckOut.tintColor = .white
        
        self.addSubview(background)
        background.addSubview(lblTotal)
        background.addSubview(lblPrice)
        background.addSubview(lblPrivacy)
        background.addSubview(btnGoToCheckOut)
        
    }
    
    override func layoutSubviews() {
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        lblTotal.snp.makeConstraints { make in
            make.top.equalTo(background.snp.top).offset(20)
            make.left.equalTo(background.snp.left).offset(20)
        }
        
        lblPrivacy.snp.makeConstraints { make in
            make.top.equalTo(background.snp.top).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(btnGoToCheckOut.snp.width).offset(-40)
        }
        
        lblPrice.snp.makeConstraints { make in
            make.top.equalTo(background.snp.top).offset(20)
            make.right.equalTo(background.snp.right).offset(-20)
        }
        
        btnGoToCheckOut.snp.makeConstraints { make in
            make.bottom.equalTo(background.snp.bottom).offset(-20)
            make.left.equalTo(background.snp.left).offset(20)
            make.right.equalTo(background.snp.right).offset(-20)
            make.top.greaterThanOrEqualTo(10)
            make.height.equalTo(50)
        }
    }
}
