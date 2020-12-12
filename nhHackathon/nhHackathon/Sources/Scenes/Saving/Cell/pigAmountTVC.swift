//
//  pigAmountTVC.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/12.
//

import UIKit

class pigAmountTVC: UITableViewCell {

    @IBOutlet weak var containView: UIView! {
        didSet {
            self.containView.setBorder(borderColor: .veryLightPinkTwo, borderWidth: 1)
            self.containView.makeRounded(cornerRadius: 5)
            self.containView.backgroundColor = .white
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            self.titleLabel.textColor = .aquaMarine
        }
    }
    
    @IBOutlet weak var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
