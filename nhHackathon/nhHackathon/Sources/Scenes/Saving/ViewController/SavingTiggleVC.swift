//
//  SavingTiggleVC.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/13.
//

import UIKit

class SavingTiggleVC: UIViewController {

    //MARK: - Init
    
    var amount:String = ""
    
    var data: Tiggle?
    
    var history: History?
    
    var month: [String: [Detail]]?
    
    var details: [[Detail]] = []
    
    
    var keyList: [String] = []
    
    var count: Int = 0
    
    @IBOutlet weak var amountLable: UILabel!
    
    @IBOutlet weak var tiggleTableView: UITableView!
    
    @IBOutlet weak var autoSaveButton: UIButton! {
        didSet {
            self.autoSaveButton.setBorder(borderColor: .salmon, borderWidth: 1)
            self.autoSaveButton.makeRounded(cornerRadius: 15)
            self.autoSaveButton.tintColor = .salmon
        }
    }
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tiggleTableView.delegate = self
        
        // self.amountLable.text = amount + "원"
        
        getTiggle()
        
    }

    //MARK: - Action
    @IBAction func back(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func autoSave(_ sender: Any) {
        
        let sb = UIStoryboard.init(name: "AutoSave", bundle: nil)
        
        let vc = sb.instantiateViewController(withIdentifier: "SavingAutoVC") as! SavingAutoVC
        
        present(vc, animated: true)
        
    }
    
    
}

//MARK: - Extension
extension SavingTiggleVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return details[section].count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .white
        
        let label = UILabel()
        // keyList[section].remove(at: keyList[section].startIndex)
        label.text = "\(14 - section)일"
        
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
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tiggleHistoryTVC") as! monthlyHistoryTVC
        
        if indexPath.row == 0 {
            
            if details[indexPath.section].count == 1 {
            cell.topLine.isHidden = true
            cell.bottomLine.isHidden = true
            } else {
                cell.topLine.isHidden = true
                cell.bottomLine.isHidden = false
            }
            
        } else if indexPath.row ==  details[indexPath.section].count - 1 {
            
            cell.topLine.isHidden = false
            cell.bottomLine.isHidden = true
            
        } else {
            
            cell.topLine.isHidden = false
            cell.bottomLine.isHidden = false
        
        }
        
        cell.timeLabel.text = details[indexPath.section][indexPath.row].time
        
        cell.useLabel.text = DecimalWon(value: details[indexPath.section][indexPath.row].amount) + "원"
        
        cell.detailLabel.text = details[indexPath.section][indexPath.row].transactionName
        
        return cell
    }
    
    
}

extension SavingTiggleVC {
    func getTiggle() {
        SavingService.shared.getTiggle() {
            [weak self]
            data in
            guard let `self` = self else { return }
            switch data{
            case .success(let res) :
                
                print("====== 소비 상세 TOTAL ======")
                print(res)
                
                self.data = res as? Tiggle
                
                self.amount = self.data!.total
                
                self.amountLable.text = self.DecimalWon(value: Int(self.amount)!) + "원"
                
                
                self.history = self.data?.history
                
                print("== HISTORY ==")
                print(self.history)
                
                self.month = self.history?.m12
                
                print("== M12 ==")
                print(self.month)
                
                
                print(self.month?.keys)
                print(self.month?.values)
                
                
                print("<<< KEY >>>")
                let keyValues = self.month?.keys.map({$0})
                
                self.count = (self.month?.keys.count)!
                
                self.keyList = keyValues!
                
                let arrayValues = self.month?.values.map({$0})
                
                self.details = arrayValues!
                
                print("=== 디테일 ===")
                print(self.details)
                print(self.details.count)
                
                self.tiggleTableView.dataSource = self
                self.tiggleTableView.reloadData()
                
                
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
