//
//  SaveToPigVC.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/12.
//

import UIKit

class SaveToPigVC: UIViewController {
    
    //MARK: - Init
    
    @IBOutlet weak var questionLabel: UILabel! {
        didSet {
            let attributedString = NSMutableAttributedString(string: "얼마를 저금통에 넣을까요?", attributes: [
                .font: UIFont(name: "SpoqaHanSansNeo-Bold", size: 20.0)!,
                .foregroundColor: UIColor.black
            ])
            
            attributedString.addAttribute(.foregroundColor, value: UIColor.salmon, range: NSRange(location: 4, length: 3))
            
            self.questionLabel.attributedText = attributedString
            
        }
    }
    
    @IBOutlet weak var animationView: UIView!
    
    @IBOutlet weak var saveAmountLabel: UIView! {
        didSet {
            self.saveAmountLabel.makeRounded(cornerRadius: 60)
            self.saveAmountLabel.backgroundColor = .duckEggBlue
        }
    }
    
    @IBOutlet weak var fillPigButton: UIButton! {
        didSet {
            self.fillPigButton.makeRounded(cornerRadius: 22.5)
            self.fillPigButton.backgroundColor = .salmon
        }
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: - Action
    @IBAction func close(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
