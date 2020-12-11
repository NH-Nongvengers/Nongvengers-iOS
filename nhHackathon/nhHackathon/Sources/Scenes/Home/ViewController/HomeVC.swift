//
//  HomeVC.swift
//  nhHackathon
//
//  Created by 안재은 on 2020/12/11.
//

import UIKit

// MARK: TEST STRUCT
struct myUse {
    var category : String
    var left: Int
    var use: Int
    var image: String
}

class HomeVC: UIViewController {
    
    
    //  컨텐츠 뷰컨트롤러들이 사용할 배경색 어레이입니다
    private let backgroundColors: [UIColor] = [.green, .blue, .brown, .yellow, .lightGray]
    
    //  컨텐츠 뷰컨들이 올라갈 페이지 뷰컨이에요
    //  transitionStyle은 화면 전환 애니메이션
    //  navigationOrientation은 상하, 좌우 어디로 넘길건지
    private let pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                          navigationOrientation: .horizontal)
    //  컨텐츠 뷰컨을 만들어주는 메서드를 따로 만들어줬습니다
    //  그냥 뷰컨 하나를 생성하고 태그에 인덱스 번호를 넣어주고 배경색만 바꿔줬습니다
    private func instantiateViewController(index: Int) -> UIViewController {
        let vc = UIViewController()
        vc.view.tag = index
        return vc
    }
    
    private func setPageViewController() {
        //  데이터소스와 델리게이트로 부모 뷰컨을 설정해줍니다
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        //  처음에 보여줄 컨텐츠 설정
        let firstVC = instantiateViewController(index: 0)
        pageViewController.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        
        //  페이지 뷰컨을 부모 뷰컨에 띄워줍니다
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
    }
    
    // MARK: - Init
    
    var myUseList : [myUse] = [myUse(category: "식비", left: 160000, use: 300000, image: ""), myUse(category: "식비", left: 160000, use: 300000, image: ""), myUse(category: "식비", left: 160000, use: 300000, image: ""), myUse(category: "식비", left: 160000, use: 300000, image: ""), myUse(category: "식비", left: 160000, use: 300000, image: ""), myUse(category: "식비", left: 160000, use: 300000, image: ""), myUse(category: "식비", left: 160000, use: 300000, image: ""), myUse(category: "식비", left: 160000, use: 300000, image: "")]
    
    @IBOutlet weak var homeTableView: UITableView!
    
    @IBOutlet weak var lastUseButton : UIButton! {
        didSet {
            self.lastUseButton.makeRounded(cornerRadius: 22.5)
            self.lastUseButton.backgroundColor = .salmon
            self.lastUseButton.dropShadow(color: .black, offSet: CGSize(width: 0, height: 3), opacity: 0.16, radius: 6)
        }
    }
    
    // MARK: - Action
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
            return myUseList.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "dDayTVC") as! dDayTVC
            
            return cell
            
        } else if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "monthlyUseTVC") as! monthlyUseTVC
            
            return cell
            
        } else if indexPath.section == 2 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "myUseTitleTVC") as! myUseTitleTVC
            
            
            
            return cell
            
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myUseTVC") as! myUseTVC
        
        
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

extension HomeVC: UIPageViewControllerDataSource {
    
    //  이전 컨텐츠 뷰컨을 리턴해주시면 됩니다
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        
        //  컨텐츠 뷰컨을 생성할 때 태그에 인덱스를 넣어줬기 때문에 몇번째 페이지인지 바로 알 수 있어요
        guard let index = pageViewController.viewControllers?.first?.view.tag else {
            return nil
        }
        
        // 이전 인덱스를 계산해주고요
        let nextIndex = index > 0 ? index - 1 : backgroundColors.count - 1
        
        // 이전 컨텐츠를 담은 뷰컨을 생성해서 리턴해줍니다
        let nextVC = instantiateViewController(index: nextIndex)
        return nextVC
    }
    
    //  다음 컨텐츠 뷰컨을 리턴해주시면 됩니다. 위에 메서드랑 똑같은데 다음 컨텐츠를 담으면 돼요
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        
        guard let index = pageViewController.viewControllers?.first?.view.tag else {
            return nil
        }
        let nextIndex = (index + 1) % backgroundColors.count
        let nextVC = instantiateViewController(index: nextIndex)
        return nextVC
    }
}

extension HomeVC: UIPageViewControllerDelegate {
    
    //  스와이프 제스쳐가 끝나면 호출되는 메서드입니다. 여기서 페이지 컨트롤의 인디케이터를 움직여줄꺼에요
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool
    ) {
        //  페이지 이동이 안됐으면 그냥 종료
        guard completed else { return }
        
        //  페이지 이동이 됐기 때문에 페이지 컨트롤의 인디케이터를 갱신해줍시다
        if let vc = pageViewController.viewControllers?.first {
            
        }
    }
}
