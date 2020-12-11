//
//  monthlyUseTVC.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/11.
//

import UIKit

class monthlyUseTVC: UITableViewCell {

    // MARK: - Init
    @IBOutlet weak var monthlyUseView: UIView! {
        didSet {
            self.monthlyUseView.makeRounded(cornerRadius: 10)
            self.monthlyUseView.backgroundColor = .salmon
        }
    }
    
    @IBOutlet weak var monthLabel: UILabel!
    
    @IBOutlet weak var monthlyUseLabel: UILabel!
    
    @IBOutlet weak var budgetLabel: UILabel!
    
    @IBOutlet weak var availableLabel: UILabel!
    
    @IBOutlet weak var animationView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: - Action
    
    @IBAction func monthlyUse(_ sender: Any) {
        print("CLICKED: 달 별 사용금액 버튼")
    }
    
}
