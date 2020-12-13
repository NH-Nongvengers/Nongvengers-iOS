//
//  SaveToPigFinVC.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/12.
//

import UIKit
import SwiftOverlayShims
import SwiftGifOrigin

class SaveToPigFinVC: UIViewController {

    //MARK: - Init
    
    var addAmount: String = ""
    var totalAmount: String = ""
    
    @IBOutlet weak var addAmountLabel: UILabel!
    
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    @IBOutlet weak var announceLabel: UILabel! {
        didSet {
            
            let attributedString = NSMutableAttributedString(string: "저금통이 채워졌습니다!", attributes: [
              .font: UIFont(name: "SpoqaHanSansNeo-Bold", size: 20.0)!,
              .foregroundColor: UIColor.black
            ])
            attributedString.addAttribute(.foregroundColor, value: UIColor.salmon, range: NSRange(location: 0, length: 3))
            
            self.announceLabel.attributedText = attributedString
        }
    }
    
    
    @IBOutlet weak var animationView: UIView!
    
    @IBOutlet weak var gifView: UIImageView! {
        
        didSet {
            self.gifView.image = UIImage.gif(name: "savingFinish")
            
            do {
                let imageData = try Data(contentsOf: Bundle.main.url(forResource: "savingFinish", withExtension: "gif")!)
                self.gifView.image = UIImage.gif(data: imageData)
            } catch {
                print(error)
            }
            
        }
        
    }
    @IBOutlet weak var announceView: UIView! {
        didSet {
            self.announceView.setBorder(borderColor: .veryLightPinkTwo, borderWidth: 1)
            self.announceView.makeRounded(cornerRadius: 10)
        }
    }
    
    @IBOutlet weak var finishButton: UIButton! {
        didSet {
            self.finishButton.backgroundColor = .salmon
            self.finishButton.makeRounded(cornerRadius: 22.5)
        }
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addAmountLabel.text = addAmount + "원"
        self.totalAmountLabel.text = "총 " + totalAmount + "원"
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Action
    
    @IBAction func close(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        
        print("CLICKED: 저금통 채우기 완료 VC")
    }
    
}
