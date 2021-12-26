//
//  SubView.swift
//  Codable(+SnapKit)Proj
//
//  Created by 이경후 on 2021/12/23.
//

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
        setProperties()
        setUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: FETCH DATA
    func setProperties(){
        print(#function)
        //라벨 폰트
        beerName.text = "로딩.."
        beerName.font = UIFont.boldSystemFont(ofSize: 21)
        beerName.textAlignment = .center
        
        beerDescipt.text = "로딩.."
        beerDescipt.font = UIFont.systemFont(ofSize: 18)
        beerDescipt.textAlignment = .center
        
        beerContent.text = "로딩 중입니다."
        beerContent.font = UIFont.systemFont(ofSize: 16)
        beerContent.numberOfLines = 4 // 기본적으로 4줄
        
        //more 버튼
        moreIndicator.backgroundColor = .white
        moreIndicator.tintColor = .black
        moreIndicator.setTitle("more", for: .normal)
        moreIndicator.setTitleColor(UIColor.black, for: .normal)

    }
    
    func setUI(){
        addSubview(beerName)
        addSubview(beerDescipt)
        addSubview(beerContent)
        addSubview(moreIndicator)
    }
    
    func setConstraints(){
        
        beerName.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.left.right.equalTo(10)
            make.bottom.equalTo(beerDescipt.snp.top).offset(-20)
        }
        
        beerDescipt.snp.makeConstraints { make in
            make.top.equalTo(beerName.snp.bottom)
            make.left.right.equalTo(10)
            make.bottom.equalTo(beerContent.snp.top).offset(-20)
        }
        
        beerContent.snp.makeConstraints { make in
            make.top.equalTo(beerDescipt.snp.bottom)
            make.right.left.equalTo(10)
            make.bottom.equalTo(moreIndicator.snp.top)
        }
        
        moreIndicator.snp.makeConstraints { make in
            make.top.equalTo(beerContent.snp.bottom)
            make.bottom.equalTo(0)
            make.left.right.equalTo(10)
        }

    }
}
