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
    
    //스크롤뷰
    var mainScrollView = UIScrollView()
    
    //넘어온 이미지를 담을 이미지뷰
    var imageView = UIImageView()
    var headerContainer = UIView()
    
    //넘어온 이름과 내용
    var beerName = UILabel()
    var beerContent = UILabel()
    var bottomContainer = UIView()
    
    // 리프레시 버튼 + 공유버튼 ( 인코딩 + 전송 )
    var refreshButton = UIButton()
    var shareButton = UIButton()
    var bottomView = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        mainScrollView.contentInsetAdjustmentBehavior = .never
        //콘텐트 모드를 .scaleAspectFill로 해야 사용가능
        imageView.image = UIImage(named: "pngegg.png")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        setProperties()
        setUI()
        setConstraints()
    }
    
    func setUI(){
        //백그라운드 뷰
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(headerContainer)
        mainScrollView.addSubview(imageView)
        mainScrollView.addSubview(bottomContainer)
        bottomContainer.addSubview(beerName)
        //bottomContainer.addSubview(beerContent)

        //버튼있는 뷰
        bottomView.addSubview(refreshButton)
        bottomView.addSubview(shareButton)
        view.addSubview(bottomView)
    }

    func setProperties(){
        //백그라운드 뷰
        mainScrollView.backgroundColor = .white
        headerContainer.backgroundColor = .lightGray
        beerName.text = "이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다.이 맥주는 정말 맛있는 맥주다."
        beerName.font = .boldSystemFont(ofSize: 30)
        beerName.numberOfLines = 0
        beerContent.text = "이 맥주는 정말 맛있는 맥주다."
        beerContent.font = .systemFont(ofSize: 20)
        
        //bottomView
        bottomView.backgroundColor = .white
        
        //refreshButton
        refreshButton.titleLabel?.text = nil
        refreshButton.setImage(UIImage(systemName: "repeat"), for: .normal)
        refreshButton.backgroundColor = .white
        refreshButton.tintColor = .black
        
        refreshButton.layer.borderWidth = 3
        refreshButton.layer.borderColor = UIColor.black.cgColor
        refreshButton.layer.cornerRadius = 8
        
        refreshButton.addTarget(self, action: #selector(refreshBtnClicked), for: .touchUpInside)
    
        //shareButton
        shareButton.setTitle("Share BEER", for: .normal)
        shareButton.backgroundColor = .black
        shareButton.tintColor = .white
        shareButton.layer.cornerRadius = 5
        shareButton.addTarget(self, action: #selector(shareBtnClicked), for: .touchUpInside)
    }
    func setConstraints(){
        //백그라운드 뷰
        mainScrollView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        headerContainer.snp.makeConstraints { make in
            make.top.equalTo(mainScrollView)
            make.left.right.equalTo(view)
            make.height.equalTo(headerContainer.snp.width).multipliedBy(0.7)
        }
        bottomContainer.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.left.right.equalTo(view)
            make.bottom.equalTo(mainScrollView)
        }
        imageView.snp.makeConstraints { make in
            //version1
//            make.top.equalTo(mainScrollView)
//            make.left.right.equalTo(view)
//            make.height.equalTo(imageView.snp.width).multipliedBy(0.7)
            //version2
//            make.left.right.equalTo(view)
//            make.top.equalTo(view)
//            make.bottom.equalTo(headerContainer.snp.bottom)
            
            //version3
            make.left.right.equalTo(view)
            make.top.equalTo(view)
            make.height.greaterThanOrEqualTo(headerContainer.snp.height).priority(.high)
            make.bottom.equalTo(headerContainer.snp.bottom)
        }
        
        beerName.snp.makeConstraints { make in
            make.edges.equalTo(bottomContainer).inset(15)
        }
        //버튼뷰
        bottomView.snp.makeConstraints { make in
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(100)
        }
        
        //리프레시 버튼
        refreshButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview().multipliedBy(0.3)
            make.centerY.equalToSuperview()
            make.height.equalTo(60)
            make.width.equalTo(UIScreen.main.bounds.width * 1/3 - 50)
        }
        
        //공유 버튼
        shareButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview().multipliedBy(1.25)
            make.centerY.equalToSuperview()
            make.height.equalTo(60)
            make.width.equalTo(UIScreen.main.bounds.width * 2/3)
        }
    }
    // From data To JSON
    @objc func shareBtnClicked(){
        
    }
    
    // API Call
    @objc func refreshBtnClicked(){
        
    }
}

