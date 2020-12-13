//
//  SettingBudgetVC.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/11.
//

import UIKit

class SettingBudgetVC: UIViewController {

    //MARK: - Init
    
    @IBOutlet weak var topContainView: UIView! {
        didSet {
            self.topContainView.backgroundColor = .salmon
        }
    }
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    @IBOutlet weak var averageAmountLabel: UILabel!
    
    @IBOutlet weak var averageAmount: UILabel!
    
    
    @IBOutlet weak var oneMonthAmountLabel: UILabel!
    
    @IBOutlet weak var oneMonthAmount: UILabel!
    
    var categoryList : [String] = ["", "", "", "", "", "", "", "", ""]
    
    @IBOutlet weak var finishButton: UIButton! {
        didSet {
            self.finishButton.makeRounded(cornerRadius: 13.5)
            self.finishButton.setBorder(borderColor: .white, borderWidth: 1)
        }
    }
    
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.categoryCollectionView.dataSource = self
        
    }
    
    //MARK: - Action
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}

//MARK: - Extension
extension SettingBudgetVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "budgetCVC", for: indexPath) as! budgetCVC
        
        
        
        return cell
    }
    
    
    
}
