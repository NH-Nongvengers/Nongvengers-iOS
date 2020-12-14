//
//  budgetCVC.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/13.
//

import UIKit

class budgetCVC: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var category: UILabel!
    
    @IBOutlet weak var textView: UIView! {
        didSet {
            self.textView.setBorder(borderColor: .veryLightPink, borderWidth: 1)
            self.textView.makeRounded(cornerRadius: 3)
        }
    }
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var average: UILabel!
    
    override func awakeFromNib() {
        
        self.contentView.makeRounded(cornerRadius: 10)
        
        self.contentView.setBorder(borderColor: .veryLightPinkTwo, borderWidth: 1)
    }
    
}

