//
//  UseDetailVC.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/12.
//

import UIKit

/**TEST STRUCT*/
struct Payment {
    
}

class UseDetailVC: UIViewController {
    
    //MARK: - Init
    @IBOutlet weak var monthlyUseView: UIView!{
        didSet {
            self.monthlyUseView.makeRounded(cornerRadius: 10)
        }
    }
    
    @IBOutlet weak var categorySettingView: onlyLeftRoundView! {
        didSet {
            self.categorySettingView.backgroundColor = .salmon
        }
    }
    
    @IBOutlet weak var monthLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var categoryImageView: UIImageView!
    
    @IBOutlet weak var monthlyHistoryTableView: UITableView!
    
    
    var monthDetail: MonthDetailData?
    
    
    var payment : [String] = []
    
    var idx: Int = 0
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeRecognizer()
        
        self.monthlyHistoryTableView.dataSource = self
        self.monthlyHistoryTableView.delegate = self
        
        getUseDetail()
        
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

// MARK: - Extension
/**TABLE VIEW*/
extension UseDetailVC : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .white
        
        let label = UILabel()
        label.text = "\(section)일"
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
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "monthlyHistoryTVC") as! monthlyHistoryTVC
        
        if indexPath.row == 0 {
            
            cell.topLine.isHidden = true
            cell.bottomLine.isHidden = false
            
        } else if indexPath.row == 2 {
            
            cell.topLine.isHidden = false
            cell.bottomLine.isHidden = true
            
        } else {
            
            cell.topLine.isHidden = false
            cell.bottomLine.isHidden = false
        
        }
        
        return cell
        
    }
    
}

extension UseDetailVC {
    func getUseDetail() {
        ReportService.shared.getUseDetail(planIdx: 1, idx: idx) {
            [weak self]
            data in
            guard let `self` = self else { return }
            switch data{
            case .success(let res) :
                
                print("====== 소비 상세 TOTAL ======")
                print(res)
                
                self.monthDetail = res as? MonthDetailData
                
                self.monthLabel.text = String(self.monthDetail!.month) + "월"
                
                self.categoryImageView.image = UIImage(named: categoryImage[(self.monthDetail?.amountOfCategory.categoryIdx)! - 1])
                self.categoryLabel.text = (self.monthDetail?.amountOfCategory.categoryName)! + " 총 금액"
                self.totalLabel.text = self.DecimalWon(value: (self.monthDetail?.amountOfCategory.balance)!) + "원"
                
                print("==== 소비 상세 쪼개기 3 =====")
                print(self.monthDetail?.transactionDetails)
                
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
