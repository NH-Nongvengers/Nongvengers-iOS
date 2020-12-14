//
//  PageVC.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/12.
//

import UIKit

class PageVC: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    /* 끝난 경우 호출*/
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        print("PageVC Scroll END")
        print(previousViewControllers[0])
        
        if previousViewControllers[0] == VCArray[0] {
            setSaveTabClick()
            setSaveUnderlineClick()
            setHomeTabUnclick()
            setHomeUnderlineUnclick()
            
            /*TEST
            let vc = UIStoryboard.init(name: "SavingMain", bundle: nil).instantiateViewController(withIdentifier: "SavingMainVC") as! SavingMainVC
            
            vc.setAnimation()
            */
            
        } else {
            setSaveTabUnclick()
            setSaveUnderlineUnclick()
            setHomeTab()
            setHomeUnderline()
        }
        
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = VCArray.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else{
            return VCArray.last
        }
        
        guard VCArray.count > previousIndex else{
            return nil
        }
        
        return VCArray[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = VCArray.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < VCArray.count else{
            return VCArray.first
        }
        
        guard VCArray.count > nextIndex else{
            return nil
        }
        
        return VCArray[nextIndex]
    }
    
    public func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return VCArray.count
    }
    
    public func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first, let firstViewControllerIndex = VCArray.firstIndex(of: firstViewController) else{
            return 0
        }
        
        return firstViewControllerIndex
    }
    
    lazy var VCArray: [UIViewController] = {
        return [
            UIStoryboard.init(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeVC"),
            UIStoryboard.init(name: "SavingMain", bundle: nil).instantiateViewController(withIdentifier: "SavingMainVC")
        ]
    }()
    
    let topView = UIView()
    let homeBtn = UIButton()
    let homeUnderline = UIView()
    let saveBtn = UIButton()
    let saveUnderline = UIView()
    
    func setTopView() {
        //네비게이션 뷰
        topView.frame = CGRect(x: 0, y: 44, width: view.frame.width, height: 47)
        topView.backgroundColor = .white
    }
    
    //홈 탭
    func setHomeTab() {
        //홈 탭
        homeBtn.frame = CGRect(x: 22, y: 7, width: 20, height: 32)
        homeBtn.setTitle("홈", for: .normal)
        homeBtn.setTitleColor(.black, for: .normal)
        homeBtn.titleLabel?.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 22)
    }
    
    func setHomeTabUnclick() {
        //홈 탭
        homeBtn.frame = CGRect(x: 22, y: 7, width: 20, height: 32)
        homeBtn.setTitle("홈", for: .normal)
        homeBtn.setTitleColor(.veryLightPink, for: .normal)
        homeBtn.titleLabel?.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 22)
    }
    
    func setHomeUnderline() {
        homeUnderline.frame = CGRect(x: 23, y: 38, width: 19, height: 2)
        homeUnderline.backgroundColor = .salmon
    }
    
    func setHomeUnderlineUnclick() {
        homeUnderline.frame = CGRect(x: 23, y: 38, width: 19, height: 2)
        homeUnderline.backgroundColor = .clear
    }
    
    // 저축 탭
    func setSaveTabUnclick() {
        saveBtn.frame = CGRect(x: 57, y: 7, width: 41, height: 32)
        saveBtn.setTitle("저축", for: .normal)
        saveBtn.setTitleColor(.veryLightPink, for: .normal)
        saveBtn.titleLabel?.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 22)
    }
    
    func setSaveTabClick() {
        saveBtn.frame = CGRect(x: 57, y: 7, width: 41, height: 32)
        saveBtn.setTitle("저축", for: .normal)
        saveBtn.setTitleColor(.black, for: .normal)
        saveBtn.titleLabel?.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 22)
    }
    
    func setSaveUnderlineUnclick() {
        saveUnderline.frame = CGRect(x: 58, y: 38, width: 39, height: 2)
        saveUnderline.backgroundColor = .clear
    }
    
    func setSaveUnderlineClick() {
        saveUnderline.frame = CGRect(x: 58, y: 38, width: 39, height: 2)
        saveUnderline.backgroundColor = .salmon
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        
        //네비게이션 바
        setTopView()
        
        //홈 탭
        setHomeTab()
        setHomeUnderline()
        
        topView.addSubview(homeBtn)
        topView.addSubview(homeUnderline)
        
        //저축 탭
        setSaveTabUnclick()
        setSaveUnderlineUnclick()
        
        topView.addSubview(saveBtn)
        topView.addSubview(saveUnderline)
        
        view.addSubview(topView)
        
        if let firstVC = VCArray.first{
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for view in self.view.subviews {
            if view is UIScrollView {
                view.frame = UIScreen.main.bounds
            } else if view is UIPageControl {
                view.isHidden = true
            }
        }
    }
    
}
