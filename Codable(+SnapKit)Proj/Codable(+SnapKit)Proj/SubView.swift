//
//  SubView.swift
//  Codable(+SnapKit)Proj
//
//  Created by 이경후 on 2021/12/23.
//

import Foundation
import UIKit

//상단의 이미지에 붙어있는 뷰
class SubView : UIView {

    // 네임 + 설명 + more, 상세설명
    var beerName = UILabel() // 이름
    var beerDescipt = UILabel() // 설명
    var beerContent = UILabel() // 자세한 설명
    var moreIndicator = UIButton() // more
    
    override init(frame : CGRect){
        super.init(frame: frame)
        backgroundColor = .white
        featureSetUp()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func featureSetUp(){
        print(#function)
        //라벨 폰트
        beerName.text = "바보"
        beerName.font = UIFont.boldSystemFont(ofSize: 21)
        beerDescipt.text = "바보"
        beerDescipt.font = UIFont.systemFont(ofSize: 18)
        beerContent.text = "바보"
        beerContent.font = UIFont.systemFont(ofSize: 16)
        beerContent.numberOfLines = 4 // 기본적으로 4줄
        
        //more 버튼
        moreIndicator.backgroundColor = .white
        moreIndicator.titleLabel?.tintColor = .black
        moreIndicator.titleLabel?.font = .boldSystemFont(ofSize: 16)
        moreIndicator.setTitle("more", for: .normal)
        moreIndicator.addTarget(self, action: #selector(moreBtnClicked), for: .touchUpInside)
    }
    @objc func moreBtnClicked(){
        print(#function)
        if beerContent.numberOfLines == 4 {
            beerContent.numberOfLines = 0
        } else {
            beerContent.numberOfLines = 4
        }
    }
}
