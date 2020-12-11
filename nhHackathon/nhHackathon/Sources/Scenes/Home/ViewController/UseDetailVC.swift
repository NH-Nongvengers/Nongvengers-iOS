//
//  UseDetailVC.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/12.
//

import UIKit

class UseDetailVC: UIViewController {
    
    //MARK: - Init
    @IBOutlet weak var monthlyUseView: UIView!{
        didSet {
            self.monthlyUseView.makeRounded(cornerRadius: 10)
        }
    }
    
    @IBOutlet weak var monthLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var categoryImageView: UIImageView!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeRecognizer()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Action
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func swipeRecognizer() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
    }
    
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer){
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction{
            case UISwipeGestureRecognizer.Direction.right:
                // 스와이프 시, 원하는 기능 구현.
                self.dismiss(animated: true, completion: nil)
            default: break
            }
        }
    }
    
}
