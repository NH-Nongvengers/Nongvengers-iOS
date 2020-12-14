//
//  HomeVC.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/11.
//

import UIKit
import Lottie

var categoryImage: [String] = ["iconFood", "iconShopping", "iconLife", "iconBeer", "iconBeauty", "iconCoffee", "iconTravel", "iconCall", "iconMore"]

class HomeVC: UIViewController {
    
    // MARK: - Init
    
    var homeMonthlyBudget: monthlyBudget?
    var categoryList: [Category] = []
    
    var dDay: String = ""
    var amountUsed: String = ""
    var balance: String = ""
    var budget: String = ""
    var month: String = ""
    
    @IBOutlet weak var homeTableView: UITableView!
    
    @IBOutlet weak var lastUseButton : UIButton! {
        didSet {
            self.lastUseButton.makeRounded(cornerRadius: 22.5)
            self.lastUseButton.backgroundColor = .salmon
            self.lastUseButton.dropShadow(color: .black, offSet: CGSize(width: 0, height: 3), opacity: 0.16, radius: 6)
        }
    }
    
    // MARK: - Action
    
    @IBAction func testButton(_ sender: Any) {
        
        let sb = UIStoryboard.init(name: "SavingMain", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SavingMainVC") as! SavingMainVC
        
        present(vc, animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func saving(_ sender: Any) {
        
        let sb = UIStoryboard.init(name: "Saving", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SavingVC") as! SavingVC
        
        present(vc, animated: true)
        
    }
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.homeTableView.dataSource = self
        self.homeTableView.delegate = self
        
        getMonthlyBudget()
        getCategory()
    }
    
    
    
    
}

// MARK: - Extension
/**TABLE VIEW*/
extension HomeVC : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 3 {
            return categoryList.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "dDayTVC") as! dDayTVC
            
            cell.dDayLabel.text = "D-" + dDay
            
            return cell
            
        } else if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "monthlyUseTVC") as! monthlyUseTVC
            
            cell.monthLabel.text = month + "월 사용금액"
            cell.availableLabel.text = balance + "원"
            cell.budgetLabel.text = budget + "원"
            cell.monthlyUseLabel.text = amountUsed + "원"

            return cell
            
        } else if indexPath.section == 2 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "myUseTitleTVC") as! myUseTitleTVC
            
            
            
            return cell
            
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myUseTVC") as! myUseTVC
        
        cell.categoryLabel.text = categoryList[indexPath.row].categoryName
        cell.leftLabel.text = DecimalWon(value: categoryList[indexPath.row].balance) + "원"
        cell.percentLabel.text = String(categoryList[indexPath.row].percent) + "%"
        cell.useLabel.text = DecimalWon(value: categoryList[indexPath.row].budget) + "원"
        
        cell.categoryImage.image = UIImage(named: categoryImage[indexPath.row])
        
        cell.index = categoryList[indexPath.row].categoryIdx
        
        return cell
        
    }
    
}

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 3 {
            
            let magazineSB = UIStoryboard.init(name: "UseDetail", bundle: nil)
            
            guard let dvc = magazineSB.instantiateViewController(withIdentifier: "UseDetailVC") as? UseDetailVC else {
                return
            }
            
            print("CLICKED: 카테고리 Cell")
            
            dvc.idx = categoryList[indexPath.row].categoryIdx
            
            dvc.modalPresentationStyle = .fullScreen
            
            self.present(dvc, animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.5) {
            self.lastUseButton.transform = CGAffineTransform(translationX: self.lastUseButton.bounds.minX, y: 900)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.3) {
            self.lastUseButton.transform = CGAffineTransform.identity
        }
        print("scroll end!")
    }
    
}


extension HomeVC {
    
    func getMonthlyBudget() {
        HomeService.shared.getHomeMonthly() {
            [weak self]
            data in
            
            switch data {
                
            case .success(let res):
                
                self?.homeMonthlyBudget = res as? monthlyBudget
                
                self?.dDay = String((self?.homeMonthlyBudget!.dDay)!)
                self?.amountUsed = self!.DecimalWon(value: self!.homeMonthlyBudget!.amountUsed)
                self?.balance = self!.DecimalWon(value: self!.homeMonthlyBudget!.balance)
                self?.budget = self!.DecimalWon(value:self!.homeMonthlyBudget!.budget)
                self?.month = String(self!.homeMonthlyBudget!.month)
                
                self?.homeTableView.reloadData()
            
            case .requestErr( _):
                print(".requestErr")
                break
            case .pathErr:
                print(".pathErr")
            case .serverErr:
                print(".serverErr")
            case .networkFail:
                print(".networkFail")
            case .dbErr:
                print("db error")
                
            }
        }
    }

    func getCategory() {
        HomeService.shared.getHomeCategory() {
            [weak self]
            data in
            
            switch data {
                
            case .success(let res):
                
                self?.categoryList = res as! [Category]
                self?.homeTableView.reloadData()
                print("===Home: 카테고리===")
                print(self?.categoryList)
                
            case .requestErr( _):
                print(".requestErr")
                break
            case .pathErr:
                print(".pathErr")
            case .serverErr:
                print(".serverErr")
            case .networkFail:
                print(".networkFail")
            case .dbErr:
                print("db error")
                
            }
        }
    }
    
}
