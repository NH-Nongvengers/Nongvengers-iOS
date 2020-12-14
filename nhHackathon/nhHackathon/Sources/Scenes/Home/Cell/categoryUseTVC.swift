//
//  categoryUseTVC.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/12.
//

import UIKit

var categoryImgList : [String] = ["iconReportFood", "iconReportShopping", "iconReportLife", "iconReportBerr", "iconReportBeauty", "iconReportCoffee", "iconReportTravel", "iconReportCall", "iconReportMore"]

class categoryUseTVC: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        getOverData()
    }
    var overList: [OverConsumption] = []
}

extension categoryUseTVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return overList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "overCVC", for: indexPath) as! overCVC
        
        let category = overList[indexPath.row]
        
        cell.budgetLabel.text = changeToWon(value: category.budget) + " 원"
        cell.useLabel.text = changeToWon(value: category.consumption!) + " 원"
        cell.categoryLabel.text = category.categoryName
        cell.percentLabel.text = String(category.percent) + "%"
        cell.categoryImage.image = UIImage(named: categoryImgList[category.categoryIdx - 1])
        
        return cell
    }
    
}

extension categoryUseTVC {
    
    /* 통신 */
    func getOverData(){
        ReportService.shared.getReportDetail(planIdx: 1) {
            [weak self]
            data in
            guard let `self` = self else { return }
            switch data{
            case .success(let res) :
                
                let report = res as! Report
                
                print(report.overConsumption)
                
                self.overList = report.overConsumption
                
                self.collectionView.dataSource = self
                self.collectionView.reloadData()
                
            case .requestErr(_):
                print("request err")
            case .pathErr:
                print("path err")
            case .serverErr:
                print("server err")
            case .networkFail:
                print("network err")
            case .dbErr:
                print("db err")
            }
        }
    }
}
