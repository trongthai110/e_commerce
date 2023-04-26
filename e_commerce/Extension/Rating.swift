//
//  Rating.swift
//  e_commerce
//
//  Created by Nguyen Dang Trong Thai on 4/26/23.
//

import UIKit
import SnapKit

class RatingView: UIView{
    
    var starViews = [UIImageView]()
    var numberOfStars: Int = 5
    var currentValue: Int = 0{
        didSet{
            starViews.enumerated().forEach{ (idx, view) in
                if idx < currentValue{
                    view.image = highlightedImage
                }else{
                    view.image = normalImage
                }
                
            }
        }
    }
    
    private let normalImage = UIImage(named: "Star_Grey")
    private let highlightedImage = UIImage(named: "Star_Yellow")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .clear
        
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.distribution = .equalCentering
        hStack.spacing = 2
        
        stride(from: 0, to: numberOfStars, by: 1).forEach{ _ in
            let imgView = UIImageView()
            imgView.image = normalImage
            imgView.contentMode = .scaleAspectFit
            self.starViews.append(imgView)
            hStack.addArrangedSubview(imgView)
            imgView.snp.makeConstraints{
                $0.width.equalTo(imgView.snp.height)
            }
        }
        
        self.addSubview(hStack)
        hStack.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    
}
