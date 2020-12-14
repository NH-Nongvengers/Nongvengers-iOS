//
//  savingMonthlyUseTVC.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/12.
//

import UIKit

class savingMonthlyUseTVC: UITableViewCell {

    @IBOutlet weak var containView: UIView! {
        didSet {
            self.containView.setBorder(borderColor: .veryLightPinkTwo, borderWidth: 1)
            self.containView.makeRounded(cornerRadius: 5)
        }
    }
    
    @IBOutlet weak var monthLabel: UILabel! {
        didSet {
            self.monthLabel.textColor = .aquaMarine
        }
    }
    
    @IBOutlet weak var useLabel: UILabel! {
        didSet {
            self.useLabel.textColor = .black
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
