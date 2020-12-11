//
//  monthlyHistoryTVC.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/12.
//

import UIKit

class monthlyHistoryTVC: UITableViewCell {

    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var useLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var indicatorView: UIView! {
        didSet {
            self.indicatorView.makeRounded(cornerRadius: 4.5)
            self.indicatorView.backgroundColor = .aquaMarine
        }
    }
    
    @IBOutlet weak var bottomLine: UIView!
    
    @IBOutlet weak var topLine: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

}
