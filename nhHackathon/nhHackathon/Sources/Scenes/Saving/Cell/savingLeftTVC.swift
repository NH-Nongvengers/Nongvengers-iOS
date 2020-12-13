//
//  savingLeftTVC.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/13.
//

import UIKit

class savingLeftTVC: UITableViewCell {

    @IBOutlet weak var whereLabel: UILabel!
    
    @IBOutlet weak var plusLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var sumLabel: UILabel!
    
    @IBOutlet weak var dotView: UIView! {
        didSet {
            self.dotView.backgroundColor = .aquaMarine
            self.dotView.makeRounded(cornerRadius: 4.5)
        }
    }
    
    @IBOutlet weak var topView: UIView! {
        didSet {
            self.topView.backgroundColor = .veryLightPinkTwo
        }
    }
    
    @IBOutlet weak var bottomView: UIView! {
        didSet {
            self.bottomView.backgroundColor = .veryLightPinkTwo
        }
    }
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
