//
//  SavingAutoVC.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/13.
//

import UIKit

class SavingAutoVC: UIViewController {
    
    //MARK: - Init
    
    @IBOutlet weak var firstButton: UIButton! {
        didSet {
            self.firstButton.setBorder(borderColor: .veryLightPinkTwo, borderWidth: 1)
            self.firstButton.makeRounded(cornerRadius: 3)
        }
    }
    
    @IBOutlet weak var secondButton: UIButton!{
        didSet {
            
            self.secondButton.setBorder(borderColor: .veryLightPinkTwo, borderWidth: 1)
            self.secondButton.makeRounded(cornerRadius: 3)
        }
    }
    
    @IBOutlet weak var thirdButton: UIButton!{
        didSet {
            
            self.thirdButton.setBorder(borderColor: .veryLightPinkTwo, borderWidth: 1)
            self.thirdButton.makeRounded(cornerRadius: 3)
        }
    }
    
    @IBOutlet weak var fourthButton: UIButton!{
        didSet {
            
            self.fourthButton.setBorder(borderColor: .veryLightPinkTwo, borderWidth: 1)
            self.fourthButton.makeRounded(cornerRadius: 3)
        }
    }
    
    @IBOutlet weak var fifthButton: UIButton!{
        didSet {
            
            self.fifthButton.setBorder(borderColor: .veryLightPinkTwo, borderWidth: 1)
            self.fifthButton.makeRounded(cornerRadius: 3)
        }
    }
    
    @IBOutlet weak var sixthButton: UIButton!{
        didSet {
            
            self.sixthButton.setBorder(borderColor: .veryLightPinkTwo, borderWidth: 1)
            self.sixthButton.makeRounded(cornerRadius: 3)
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            let attributedString = NSMutableAttributedString(string: "원하는 주기로 원하는 금액을\n자동으로 저축해보세요!🙆‍♂️", attributes: [
                .font: UIFont(name: "SpoqaHanSansNeo-Bold", size: 20.0)!,
                .foregroundColor: UIColor.black
            ])
            attributedString.addAttribute(.foregroundColor, value: UIColor.salmon, range: NSRange(location: 16, length: 7))
            
            self.titleLabel.attributedText = attributedString
        }
    }
    
    
    @IBOutlet weak var doneButton: UIButton! {
        didSet {
            self.doneButton.makeRounded(cornerRadius: 22.5)
            self.doneButton.backgroundColor = .salmon
        }
    }
    
    @IBOutlet weak var everyDayButton: UIButton!
    
    
    @IBOutlet weak var everyWeekButton: UIButton!
    
    @IBOutlet weak var buttonView: UIView! {
        didSet {
            self.buttonView.makeRounded(cornerRadius: 10)
            self.buttonView.setBorder(borderColor: .veryLightPinkTwo, borderWidth: 1)
        }
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.everyDayButton.isSelected = true
        
        self.firstButton.isSelected = true
        self.firstButton.setBorder(borderColor: .salmon, borderWidth: 1)
        
    }
    
    
    //MARK: - Action
    @IBAction func back(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func everyDaySelected(_ sender: Any) {
        everyDayButton.isSelected = true
        everyWeekButton.isSelected = false
    }
    
    @IBAction func everyWeekSelected(_ sender: Any) {
        everyDayButton.isSelected = false
        everyWeekButton.isSelected = true
    }
    
}
