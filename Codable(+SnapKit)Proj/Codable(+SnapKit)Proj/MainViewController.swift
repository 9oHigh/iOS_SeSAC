//
//  ViewController.swift
//  Codable(+SnapKit)Proj
//
//  Created by 이경후 on 2021/12/20.
//

import UIKit
import SnapKit
import Alamofire

class MainViewController: UIViewController {
    
    // 리프레시 버튼 + 공유버튼 ( 인코딩 + 전송 )
    var refreshButton = UIButton()
    var shareButton = UIButton()
    var bottomView = UIView()
    var beerView = MainView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func setUp(){
        //백그라운드
        beerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        view.addSubview(beerView)
        //버튼있는 뷰
        bottomView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 60, width: UIScreen.main.bounds.width, height: 60)
        bottomView.addSubview(refreshButton)
        bottomView.addSubview(shareButton)
        view.addSubview(bottomView)
    }

    func setFetures(){
        //refreshButton
        refreshButton.titleLabel?.text = nil
        refreshButton.setImage(UIImage(systemName: "repeat"), for: .normal)
        refreshButton.backgroundColor = .red
        refreshButton.tintColor = .white
        refreshButton.layer.cornerRadius = 5
        refreshButton.addTarget(self, action: #selector(refreshBtnClicked), for: .touchUpInside)
    
        //shareButton
        shareButton.setTitle("Share BEER", for: .normal)
        shareButton.backgroundColor = .red
        shareButton.tintColor = .white
        shareButton.layer.cornerRadius = 5
        shareButton.addTarget(self, action: #selector(shareBtnClicked), for: .touchUpInside)
    }
    @objc func shareBtnClicked(){
        
    }
    @objc func refreshBtnClicked(){
        
    }
}

