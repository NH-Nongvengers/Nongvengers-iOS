//
//  SaveToPigVC.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/12.
//

import UIKit
import Lottie

class SaveToPigVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    //MARK: - Picker View
    
    @IBOutlet weak var testView: UIView!
    
    
    let amountPicker = UIPickerView()
    
    let amountList: [Int] = [1000, 2000, 3000, 4000, 5000, 6000, 7000]
    var rotationAngle: CGFloat! = -90*(.pi/180)
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return amountList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(amountList.count)
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        
        pickerView.subviews[0].backgroundColor = .clear
        pickerView.subviews[1].backgroundColor = .clear
        
        let view = UIView()
        
        view.frame = CGRect(x: 0, y: 80, width: 100, height: 60)
        
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 33, width: 100, height: 100)
        
        label.text = String(amountList[row])
        label.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 18)
        label.textColor = .black
        label.textAlignment = .center
        
        
        
        let lineView = UIView()
        lineView.frame = CGRect(x: 49, y: 120, width: 2, height: 83)
        lineView.backgroundColor = .aquaMarine
        
        view.addSubview(lineView)
        view.addSubview(label)
        view.transform = CGAffineTransform(rotationAngle: 90*(.pi/180))
        
        if pickerView.selectedRow(inComponent: component) == row {
            saveLabel.text = label.text
        }
        
        return view
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.reloadAllComponents()
        saveLabel.text = String(amountList[row])
    }
    
    //MARK: - Init
    
    @IBOutlet weak var saveLabel: UILabel!
    
    
    @IBOutlet weak var saveAmountView: UIView! {
        didSet {
            self.saveAmountView.backgroundColor = .duckEggBlue
            self.saveAmountView.makeRounded(cornerRadius: 44.5)
        }
    }
    
    @IBOutlet weak var questionLabel: UILabel! {
        didSet {
            let attributedString = NSMutableAttributedString(string: "얼마를 저금통에 넣을까요?", attributes: [
                .font: UIFont(name: "SpoqaHanSansNeo-Bold", size: 20.0)!,
                .foregroundColor: UIColor.black
            ])
            
            attributedString.addAttribute(.foregroundColor, value: UIColor.salmon, range: NSRange(location: 4, length: 3))
            
            self.questionLabel.attributedText = attributedString
            
        }
    }
    
    @IBOutlet weak var animationView: UIView!
    
    @IBOutlet weak var fillPigButton: UIButton! {
        didSet {
            self.fillPigButton.makeRounded(cornerRadius: 22.5)
            self.fillPigButton.backgroundColor = .salmon
        }
    }
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setAnimation()
        // Do any additional setup after loading the view.
        // setGraph()
        amountPicker.delegate = self
        amountPicker.dataSource = self
        
        amountPicker.frame = CGRect(x: 0, y: 110, width: view.frame.width, height: view.frame.width + 300)
        //amountPicker.center = self.view.center
        amountPicker.transform = CGAffineTransform(rotationAngle: rotationAngle)
        
        //self.view.frame = CGRect(x: 0, y: 0, width: 100, height: 375)
        
        self.view.addSubview(amountPicker)
        
    }
    
    
    //MARK: - Action
    @IBAction func close(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func fillPig(_ sender: Any) {
        
        guard let amount = saveLabel.text else { return }
        
        SavingService.shared.saveSaving(amount, 5) { data in
            switch data {
                
            case .success(let res) :
                print("티끌 모으기 성공")
                
                
                print("=== POST: 티끌 모으기 ===")
                
                let totalAmount = res as! DataClass
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SaveToPigFinVC") as! SaveToPigFinVC
                
                vc.addAmount = amount
                
                vc.totalAmount = String(totalAmount.total)
                
                self.present(vc, animated: true)
                
            case .requestErr(let msg):
                print("절약 저축 requestErr")
                print(msg)
            case .pathErr:
                print("절약 저축 pathErr")
            case .serverErr:
                print("절약 저축 serverErr")
            case .networkFail:
                print("절약 저축 networkFail")
            case .dbErr:
                print("절약 저축 dbErr")
            }
        }
        
    }
    
    func setAnimation() {
        let lottieView = AnimationView(name: "saving")
        
        animationView.addSubview(lottieView)
        
        lottieView.contentMode = .scaleAspectFill
        
        lottieView.frame = animationView.bounds
        
        lottieView.play()
        lottieView.loopMode = .repeat(3)
    }
    
}

//MARK: - Extension
