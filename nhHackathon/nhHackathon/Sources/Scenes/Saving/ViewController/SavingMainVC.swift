//
//  SavingMainVC.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/12.
//

import UIKit
import Lottie

class SavingMainVC: UIViewController {
    
    //MARK: - Init
    
    let titleList: [String] = ["절약 후 저축 금액", "티끌 모으기", "잔돈 모으기"]
    
    var saveData: SaveMain?
    
    @IBOutlet weak var putCoinButton: UIButton! {
        didSet {
            self.putCoinButton.backgroundColor = .salmon
            self.putCoinButton.makeRounded(cornerRadius: 22.5)
        }
    }
    @IBOutlet weak var pigTableView: UITableView!
    var saveAmountList: [String] = []
    
    @IBOutlet weak var pigFillView: UIView! {
        didSet {
            self.pigFillView.backgroundColor = .white
        }
    }
    
    @IBOutlet weak var pigAmountView: UIView! {
        didSet {
            self.pigAmountView.makeRounded(cornerRadius: 44.5)
            self.pigAmountView.backgroundColor = .duckEggBlue
        }
    }
    
    @IBOutlet weak var animationView: UIView!
    
    
    @IBOutlet weak var pigAmountLabel: UILabel!
    
    var pigAmount: String = ""
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            let attributedString = NSMutableAttributedString(string: "어떤 저축을 해볼까요?", attributes: [
                .font: UIFont(name: "SpoqaHanSansNeo-Bold", size: 20.0)!,
                .foregroundColor: UIColor.black
            ])
            attributedString.addAttribute(.foregroundColor, value: UIColor.salmon, range: NSRange(location: 3, length: 2))
            
            self.titleLabel.attributedText = attributedString
        }
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAnimation()
        
        //self.pigTableView.dataSource = self
        self.pigTableView.delegate = self
        
        getSavingMain()
        
    }
    
    //MARK: - Action
    func setAnimation() {
        let lottieView = AnimationView(name: "saving")
        
        animationView.addSubview(lottieView)
        
        lottieView.contentMode = .scaleAspectFill
        
        lottieView.frame = animationView.bounds
        
        lottieView.play()
        lottieView.loopMode = .loop
        
    }
    
    @IBAction func putCoin(_ sender: Any) {
        
        let sb = UIStoryboard.init(name: "SaveToPig", bundle: nil)
        
        let vc = sb.instantiateViewController(withIdentifier: "SaveToPigVC") as! SaveToPigVC
        
        present(vc, animated: true)
        
    }
    
    
}

//MARK: - Extension

extension SavingMainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "pigAmountTVC") as! pigAmountTVC
        
        cell.titleLabel.text = titleList[indexPath.row]
        
        cell.amountLabel.text = saveAmountList[indexPath.row]
        
        return cell
        
    }
    
    
}


extension SavingMainVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard.init(name: "SavingDetail", bundle: nil)
        
        if indexPath.row == 0 {
            
            let dvc = sb.instantiateViewController(withIdentifier: "SavingDetailVC") as! SavingDetailVC
            
            dvc.amount = saveAmountList[indexPath.row]
            
            print("CLICKED: 카테고리 Cell")
            
            self.present(dvc, animated: true)
        } else if indexPath.row == 1 {
            
            let dvc = sb.instantiateViewController(withIdentifier: "SavingTiggleVC") as! SavingTiggleVC
            
            dvc.amount = saveAmountList[indexPath.row]
            
            print("CLICKED: 카테고리 Cell")
            
            self.present(dvc, animated: true)
        } else {
            
            let dvc = sb.instantiateViewController(withIdentifier: "SavingCoinVC") as! SavingCoinVC
            
            
            print("CLICKED: 카테고리 Cell")
            
            self.present(dvc, animated: true)
        }
        
    }
}

extension SavingMainVC {
    func getSavingMain() {
        SavingService.shared.getMainSaving() {
            [weak self]
            data in
            
            switch data {
                
            case .success(let res):
                
                self?.saveData = res as? SaveMain
                
                self?.pigAmountLabel.text = self!.DecimalWon(value: (self?.saveData!.sum)!) + "원"
                
                self?.saveAmountList = [self!.DecimalWon(value: (self?.saveData!.saved)!), self!.DecimalWon(value: (self?.saveData!.changes)!), self!.DecimalWon(value: (self?.saveData!.coin)!)]
                
                self?.pigTableView.dataSource = self
                self?.pigTableView.reloadData()
                
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
