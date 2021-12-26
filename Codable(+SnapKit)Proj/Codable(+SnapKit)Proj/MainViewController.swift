//  ViewController.swift
//  Codable(+SnapKit)Proj
//
//  Created by 이경후 on 2021/12/20.
//

import UIKit
import SnapKit
import Alamofire
import SwiftUI

class MainViewController: UIViewController {
    
    //스크롤뷰
    var mainScrollView = UIScrollView()
    
    //넘어온 이미지를 담을 이미지뷰
    var imageView = UIImageView()
    var headerContainer = UIView()
    
    //넘어온 이름과 내용
    var foodPairing = UILabel()
    var pairingContents = [UILabel]()
    var bottomContainer = UIView()
    
    // 리프레시 버튼 + 공유버튼 ( 인코딩 + 전송 )
    var refreshButton = UIButton()
    var shareButton = UIButton()
    var buttonView = UIView()
    
    var subView = SubView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        mainScrollView.contentInsetAdjustmentBehavior = .never
        
        imageView.image = UIImage(named: "pngegg.png")
        //콘텐트 모드를 .scaleAspectFill로 해야 사용가능
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
        bottomContainer.addSubview(foodPairing)
        pairingContents.forEach { label in
            bottomContainer.addSubview(label)
        }
        mainScrollView.addSubview(subView)
        
        //이미지뷰 블러이펙트 조사조사!!
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.contentMode = .scaleAspectFit
        imageView.addSubview(blurEffectView)
        
        blurEffectView.snp.makeConstraints { make in
            make.edges.equalTo(imageView).inset(0)
        }
        
        let newImageView = UIImageView()
        newImageView.image = UIImage(named: "pngegg.png")
        newImageView.contentMode = .scaleAspectFill
        imageView.addSubview(newImageView)
        
        newImageView.snp.makeConstraints { make in
            make.edges.equalTo(imageView).inset(100)//임시로 엣지에 모두 인셋.. 너무 수동적쓰~
        }
        
        //버튼있는 뷰
        buttonView.addSubview(refreshButton)
        buttonView.addSubview(shareButton)
        view.addSubview(buttonView)
    }
    
    func setProperties(){
        //백그라운드 뷰
        mainScrollView.backgroundColor = .white
        headerContainer.backgroundColor = .clear // 이미지 뷰를 하나더 얹어야하나?
        
        //디폴트
        foodPairing.text = "Food - Pairing"
        foodPairing.font = .boldSystemFont(ofSize: 25)
        
        //임시방편 - 데이터 가지고 오기 fetchdatas
        pairingContents.append(UILabel())
        pairingContents.append(UILabel())
        pairingContents.append(UILabel())
        
        pairingContents.forEach { label in
            label.text = "Spicy carne asada with a pico de gallo sauce, 이거야 바보야!\nSpicy carne asada with a pico de gallo sauce, 이거야 바보야!\nSpicy carne asada with a pico de gallo sauce, 이거야 바보야!\n"
            label.font = .systemFont(ofSize: 20)
            label.numberOfLines = 0
            print(label.text!)
        }
        //subView
        subView.layer.cornerRadius = 10
        subView.layer.borderColor = UIColor.black.cgColor
        subView.layer.borderWidth = 0.1
        subView.moreIndicator.addTarget(self, action: #selector(moreBtnClicked), for: .touchUpInside)
        
        //bottomView
        buttonView.backgroundColor = .white
        
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
            make.left.right.equalTo(view)
            make.top.equalTo(view)
            make.height.greaterThanOrEqualTo(headerContainer.snp.height).priority(.high)
            make.bottom.equalTo(headerContainer.snp.bottom)
        }
        foodPairing.snp.makeConstraints { make in
            make.top.equalTo(subView.snp.bottom)
            make.left.right.equalTo(20)
        }
        for content in 0...pairingContents.count - 1 {
            print(content)
            if content == 0 {
                pairingContents[content].snp.makeConstraints { make in
                    make.top.equalTo(foodPairing.snp.bottom).offset(20)
                    make.right.left.equalTo(20)
                }
            } else if content == pairingContents.count - 1 {
                pairingContents[content].snp.makeConstraints { make in
                    make.top.equalTo(pairingContents[content-1].snp.bottom)
                    make.right.left.equalTo(20)
                    make.bottom.equalTo(mainScrollView).offset(-100)//버튼뷰 높이만큼
                }
            }
            else {
                pairingContents[content].snp.makeConstraints { make in
                    make.top.equalTo(pairingContents[content-1].snp.bottom)
                    make.right.left.equalTo(20)
                }
            }
        }
        //플로팅뷰
        subView.snp.makeConstraints { make in
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.top.equalTo(imageView.snp.bottom).multipliedBy(0.7)
            make.bottom.equalTo(foodPairing.snp.top).offset(-20)
        }
        
        //버튼뷰
        buttonView.snp.makeConstraints { make in
            make.left.equalTo(0)
            make.right.equalTo(0)
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
    
    @objc func moreBtnClicked(){
        print(#function)
        if subView.beerContent.numberOfLines == 4 {
            subView.beerContent.numberOfLines = 0
            subView.moreIndicator.setTitle("less", for: .normal)
        } else {
            subView.beerContent.numberOfLines = 4
            subView.moreIndicator.setTitle("more", for: .normal)
        }
    }
}
