//
//  ViewController.swift
//  FirebaseProj
//
//  Created by 이경후 on 2021/12/06.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var crashButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "메인 페이지"
        crashButton.setTitleColor(UIColor.black, for: .normal)
        crashButton.backgroundColor = .yellow
        
        //Crashlytics 구현 테스트
        let button = UIButton(type: .roundedRect)
        button.frame = CGRect(x: 20, y: 50, width: 100, height: 30)
        button.setTitle("Test Crash", for: [])
        button.addTarget(self, action: #selector(self.crashButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @IBAction func crashButtonTapped(_ sender: AnyObject) {
        let numbers = [0]
        let _ = numbers[1]
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //  회원가입 : 아이디(100) > 닉네임(90) > 연락처(50) > 성별(10) > 가입 완료(5) 페이지가 있다고 가정 (모두 따로)
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-\(title!)",
            AnalyticsParameterItemName: title!,
            AnalyticsParameterContentType: "cont",
        ])
        
        Analytics.logEvent("toNextPage", parameters: [
            "name": "Crash" as NSObject
        ])
        
    }
}

