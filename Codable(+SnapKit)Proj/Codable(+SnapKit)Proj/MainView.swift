//
//  descriptionView.swift
//  Codable(+SnapKit)Proj
//
//  Created by 이경후 on 2021/12/20.
//


import UIKit
import SnapKit


class MainView : UIView {
    
    //스크롤뷰
    var MainScrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    //컨테이너 전체를 담을
    var containerView = UIView()
    //이미지를 담을
    var imageContainer = UIView()
    
    var imageView : UIImageView! // headerImage로 사용할 View
    var imageHeight = NSLayoutConstraint()
    var imageWidth = NSLayoutConstraint()
    
    // 네임 + 설명 + more, 상세설명
    var beerName : UILabel! // 이름
    var beerDescipt : UILabel! // 설명
    var beerContent : UILabel! // 자세한 설명
    var moreIndicator : UIButton! // more
    
    override init(frame : CGRect){
        super.init(frame: frame)
        backgroundColor = .white
        setUp()//넣고 constraints
    }
    
    required init?(coder: NSCoder) {
        print(#function)
        fatalError()
    }
    
    func setUp(){
        featureSetUp()
        constraintSetUp()
        
        
    }
    func featureSetUp(){
        //라벨 폰트
        beerName.font = UIFont.boldSystemFont(ofSize: 21)
        beerDescipt.font = UIFont.systemFont(ofSize: 18)
        beerContent.font = UIFont.systemFont(ofSize: 16)
        beerContent.numberOfLines = 4 // 기본적으로 4줄
        
        //more 버튼
        moreIndicator.backgroundColor = .white
        moreIndicator.titleLabel?.tintColor = .black
        moreIndicator.titleLabel?.font = .boldSystemFont(ofSize: 16)
        moreIndicator.setTitle("more", for: .normal)
        moreIndicator.addTarget(self, action: #selector(moreBtnClicked), for: .touchUpInside)

    }
    func constraintSetUp(){
        //스크롤뷰 모든방향 0
        MainScrollView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        //이미지 컨테이너
        imageContainer.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(150)
        }
        imageView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(imageContainer)
        }
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(0)
            make.width.equalTo(frame.width)
            make.left.right.top.equalToSuperview()
            make.height.equalTo(1000)
            
        }
        beerName.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            //-0.25 by Y축
            make.centerY.equalToSuperview().multipliedBy(-0.85)
        }
        
        beerDescipt.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(-0.75)
        }
        
        beerContent.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(-0.60)
        }
    }
    
    @objc func moreBtnClicked(){
        if beerContent.numberOfLines == 4 {
            beerContent.numberOfLines = 0
        } else {
            beerContent.numberOfLines = 4
        }
    }
    
}

