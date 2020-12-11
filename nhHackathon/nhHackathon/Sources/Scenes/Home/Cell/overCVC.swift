//
//  overCVC.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/12.
//

import UIKit

class overCVC: UICollectionViewCell {
    
    @IBOutlet weak var categoryImage: UIImageView!
    
    @IBOutlet weak var categoryLabel: UILabel! {
        didSet {
            self.categoryLabel.textColor = .black
        }
    }
    
    @IBOutlet weak var percentLabel: UILabel! {
        didSet {
            self.percentLabel.textColor = .salmon
        }
    }
    
    @IBOutlet weak var budgetLabel: UILabel! {
        didSet {
            self.budgetLabel.textColor = .greyishBrown
        }
    }
    
    @IBOutlet weak var useLabel: UILabel! {
        didSet {
            self.useLabel.textColor = .greyishBrown
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.makeRounded(cornerRadius: 10)
        
        self.contentView.setBorder(borderColor: .veryLightPinkTwo, borderWidth: 1)
        
        
    }
}
