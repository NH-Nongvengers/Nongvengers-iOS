//
//  myUseTVC.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/11.
//

import UIKit

class myUseTVC: UITableViewCell {

    var index: Int = 0
    
    @IBOutlet weak var categoryImage: UIImageView!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var leftLabel: UILabel!
    
    @IBOutlet weak var useLabel: UILabel!
    
    @IBOutlet weak var percentView: UIView! {
        didSet {
            self.percentView.setBorder(borderColor: .aquaMarine, borderWidth: 1)
            self.percentView.makeRounded(cornerRadius: 6.5)
        }
    }
    
    @IBOutlet weak var percentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
