//
//  SavingCoinVC.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/13.
//

import UIKit

class SavingCoinVC: UIViewController {

    
    var amount:String = ""
    
    var data: Coin?
    
    var history: History2?
    
    var month: [String: [Detail2]]?
    
    var details: [[Detail2]] = []
    
    
    var keyList: [String] = []
    
    var count: Int = 0
    
    
    
    @IBOutlet weak var leftTableView: UITableView!
    
    @IBOutlet weak var amountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.amountLabel.text = amount + "원"
        
        self.leftTableView.dataSource = self
        self.leftTableView.delegate = self
        
        getCoin()
    }
    
    
    @IBAction func back(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
}

extension SavingCoinVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .white
        
        let label = UILabel()
//        keyList[section].remove(at: keyList[section].startIndex)
//        label.text = "\(keyList[section])일"
        label.text = "\(13 - section)일"
        label.textColor = .veryLightPink
        label.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 14)
        label.frame = CGRect(x: 20, y: 6, width: 30, height: 20)
        
        view.addSubview(label)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return keyList.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "savingLeftTVC") as! savingLeftTVC
        
        if indexPath.row == 0 {
            
            if details[indexPath.section].count == 1 {
                cell.bottomView.isHidden = true
                cell.topView.isHidden = true
            } else {
                
                cell.bottomView.isHidden = true
                cell.topView.isHidden = false
            }
        } else if indexPath.row ==  details[indexPath.section].count - 1 {
            
            cell.bottomView.isHidden = false
            cell.topView.isHidden = true
            
        } else {
            
            cell.bottomView.isHidden = false
            cell.topView.isHidden = false
            
        }
        
        cell.dateLabel.text = details[indexPath.section][indexPath.row].time
        
        cell.sumLabel.text = DecimalWon(value: details[indexPath.section][indexPath.row].amount) + "원"
        
        cell.whereLabel.text = details[indexPath.section][indexPath.row].transactionName
        
        cell.plusLabel.text = "+" + DecimalWon(value: details[indexPath.section][indexPath.row].changes)
        
        return cell
    }
    
    
}


extension SavingCoinVC {
    func getCoin() {
        SavingService.shared.getLeft() {
            [weak self]
            data in
            guard let `self` = self else { return }
            switch data{
            case .success(let res) :
                
                print("====== 소비 상세 ======")
                print(res)

                self.data = res as? Coin
                
                self.amount = self.data!.total
                
                self.amountLabel.text = self.DecimalWon(value: Int(self.amount)!) + "원"
                
                
                self.history = self.data?.history
                
                print("== HISTORY ==")
                
                self.month = self.history?.m12
                
                print("== M12 ==")
                
                
                print("<<< KEY >>>")
                let keyValues = self.month?.keys.map({$0})
                
                self.count = (self.month?.keys.count)!
                
                self.keyList = keyValues!
                
                let arrayValues = self.month?.values.map({$0})
                
                self.details = arrayValues!
                
                print("=== 디테일 ===")
                print(self.details)
                print(self.details.count)
                
                self.leftTableView.dataSource = self
                self.leftTableView.reloadData()
                
                
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
