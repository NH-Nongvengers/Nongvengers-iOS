//
//  dDayTVC.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/11.
//

import UIKit

class dDayTVC: UITableViewCell {
    
    // MARK: - Init
    @IBOutlet weak var dDayLabel: UILabel! {
        didSet {
            self.dDayLabel.textColor = .salmon
        }
    }
    
    @IBOutlet weak var setBudgetButton: UIButton! {
        didSet {
            
            self.setBudgetButton.makeRounded(cornerRadius: 11)
            
            self.setBudgetButton.setBorder(borderColor: .salmon, borderWidth: 1)
            
            self.textLabel?.textColor = .salmon
        }
    }
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    
    // MARK: - Action
    // 예산 설정하기 뷰로 이동 Action
    @IBAction func setBudget(_ sender: Any) {
        
        let sb = UIStoryboard.init(name: "SettingBudget", bundle: nil)
        
        guard let dvc = sb.instantiateViewController(withIdentifier: "SettingBudgetVC") as? SettingBudgetVC else {
            return
        }
        
        self.window?.rootViewController?.present(dvc, animated: true, completion: nil)
    }
    
}
