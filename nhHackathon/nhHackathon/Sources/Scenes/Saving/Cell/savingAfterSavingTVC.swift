//
//  savingAfterSavingTVC.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/12.
//

import UIKit

class savingAfterSavingTVC: UITableViewCell {
    
    @IBOutlet weak var outerView: UIView! {
        didSet {
            self.outerView.setBorder(borderColor: .veryLightPinkTwo, borderWidth: 1)
            
            self.outerView.makeRounded(cornerRadius: 5)
        }
    }
    
    @IBOutlet weak var monthLabel: UILabel! {
        didSet {
            self.monthLabel.textColor = .aquaMarine
        }
    }
    
    @IBOutlet weak var useLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
