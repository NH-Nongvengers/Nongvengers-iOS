//
//  categoryUseTVC.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/12.
//

import UIKit

/**TEST STRUCT*/
struct overUse {
    var title: String
    var percent: Int
    var budget: Int
    var use: Int
    var categoryImg: String
}

class categoryUseTVC: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            self.collectionView.dataSource = self
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    var overUseList : [overUse] = [overUse(title: "식비", percent: 120, budget: 600000, use: 900000, categoryImg: ""), overUse(title: "식비", percent: 120, budget: 600000, use: 900000, categoryImg: ""), overUse(title: "식비", percent: 120, budget: 600000, use: 900000, categoryImg: "")]
    
}

extension categoryUseTVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return overUseList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "overCVC", for: indexPath) as! overCVC
        
        let category = overUseList[indexPath.row]
        
        cell.budgetLabel.text = String(category.budget) + " 원"
        cell.useLabel.text = String(category.use) + " 원"
        cell.categoryLabel.text = category.title
        cell.percentLabel.text = String(category.percent) + "%"
        
        return cell
    }
    
}
