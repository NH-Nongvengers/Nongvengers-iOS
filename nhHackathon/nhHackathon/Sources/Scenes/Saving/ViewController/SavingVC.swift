//
//  SavingVC.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/12.
//

import UIKit

class SavingVC: UIViewController {

    //MARK: - Init
    
    @IBOutlet weak var saveAmountLabel: UILabel!
    var availableAmount: [Amount] = []
    @IBOutlet weak var textView: UIView! {
        didSet {
            self.textView.backgroundColor = .white
            self.textView.setBorder(borderColor: .veryLightPink, borderWidth: 1)
            self.textView.makeRounded(cornerRadius: 3)
        }
    }
    
    @IBOutlet weak var textField: UITextField! {
        didSet {
            self.textField.tintColor = .salmon
            self.textField.delegate = self
        }
    }
    
    @IBOutlet weak var saveButton: UIButton! {
        didSet {
            self.saveButton.makeRounded(cornerRadius: 22.5)
            self.saveButton.backgroundColor = .salmon
            self.saveButton.dropShadow(color: .black, offSet: CGSize(width: 0, height: 3), opacity: 0.16, radius: 6)
        }
    }
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initGestureRecognizer()
        
        getAvailable()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
    }
    
    //MARK: - Action
    
    func typingStarted() {
        self.textView.setBorder(borderColor: .salmon, borderWidth: 1)
    }
    
    func noTyping() {
        self.textView.setBorder(borderColor: .veryLightPink, borderWidth: 1)
    }
    
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        
        guard let amount = self.textField.text else { return }
        
        SavingService.shared.saveSaving(amount, 3) { data in
            switch data {
                
            case .success(let res) :
                print("절약 저축 성공")
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SavingFinVC") as! SavingFinVC
                print("=== POST: 절약 저축 ===")
                
                let totalAmount = res as! DataClass
                
                vc.totalAmount = totalAmount.total
                
                self.present(vc, animated: true, completion: nil)
                
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
    
}

//MARK: - Extension
extension SavingVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        registerForKeyboardNotifications()
        typingStarted()
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string != "" {
            typingStarted()
        } else {
            noTyping()
        }
        return true
    }
}


extension SavingVC: UIGestureRecognizerDelegate {
    
    func initGestureRecognizer() {
        let textFieldTap = UITapGestureRecognizer(target: self, action: #selector(handleTapTextField(_:)))
        textFieldTap.delegate = self
        view.addGestureRecognizer(textFieldTap)
    }
    
    // 다른 위치 탭했을 때 키보드 없어지는 코드
    @objc func handleTapTextField(_ sender: UITapGestureRecognizer) {
        self.textField.resignFirstResponder()
    }
    
    
    func gestureRecognizer(_ gestrueRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: textField))! {
            return false
        }
        return true
    }
    
    // keyboard가 보여질 때 어떤 동작을 수행
    @objc func keyboardWillShow(_ notification: NSNotification) {
        
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else { return }
        
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardHeight: CGFloat
        
        if #available(iOS 11.0, *) {
            keyboardHeight = keyboardFrame.cgRectValue.height - self.view.safeAreaInsets.bottom
        } else {
            keyboardHeight = keyboardFrame.cgRectValue.height
        }
        
        self.view.layoutIfNeeded()
    }
    
    // keyboard가 사라질 때 어떤 동작을 수행
    @objc func keyboardWillHide(_ notification: NSNotification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {return}
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {return}
        
        self.view.layoutIfNeeded()
    }
    
    
    // observer
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension SavingVC {
    func getAvailable() {
        SavingService.shared.getAvailableSaving() {
            [weak self]
            data in
            
            switch data {
                
            case .success(let res):
                
                print(res)
                self?.availableAmount = res as! [Amount]
                self?.saveAmountLabel.text = self!.DecimalWon(value: Int((self?.availableAmount[0].amount)!) ?? 0) + "원"
                
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
