//
//  MonthUseVC.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/12.
//

import UIKit

class MonthUseVC: UIViewController {

    
    //MARK: - Init
    var categoryUseList : [OverConsumption] = []
    var report: Report?
    
    @IBOutlet weak var topSetView: UIView! {
        didSet {
            self.topSetView.backgroundColor = .salmon
        }
    }
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var amountUsedLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel! {
        didSet {
            self.balanceLabel.textColor = .aquaMarine
        }
    }
    
    
    
    
    @IBOutlet weak var reportTableView: UITableView!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.reportTableView.dataSource = self
        getData()
        
    }
    
    //MARK: - Action
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - Extension
/**TABLE VIEW*/
extension MonthUseVC : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 3 {
            return categoryUseList.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "overTitleTVC") as! myUseTitleTVC
            
            return cell
            
        } else if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "overUseTVC") as! categoryUseTVC
            
            return cell
            
        } else if indexPath.section == 2 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "categoryUseTVC") as! myUseTitleTVC
            
            
            
            return cell
            
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCategoryUseTVC") as! myUseTVC
        
        cell.categoryImage.image = UIImage(named: categoryImage[indexPath.row])
        cell.categoryLabel.text = categoryUseList[indexPath.row].categoryName
        cell.leftLabel.text = DecimalWon(value: categoryUseList[indexPath.row].balance!)
        cell.percentLabel.text = String(categoryUseList[indexPath.row].percent) + "%"
        cell.useLabel.text = DecimalWon(value: categoryUseList[indexPath.row].budget) + "원"
        
        return cell
        
    }
    
}

extension MonthUseVC {
    func getData() {
        ReportService.shared.getReportDetail(planIdx: 1) {
            [weak self]
            data in
            guard let `self` = self else { return }
            switch data{
            case .success(let res) :
                
                self.report = res as? Report
                
                self.budgetLabel.text = self.DecimalWon(value: (self.report?.summary.budget)!) + "원"
                self.amountUsedLabel.text = self.DecimalWon(value: (self.report?.summary.amountUsed)!) + "원"
                self.balanceLabel.text = self.DecimalWon(value: (self.report?.summary.balance)!) + "원"
                
                self.categoryUseList = self.report!.result
                
                self.reportTableView.dataSource = self
                self.reportTableView.reloadData()
                
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
