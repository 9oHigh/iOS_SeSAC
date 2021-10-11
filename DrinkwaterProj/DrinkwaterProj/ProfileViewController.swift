//
//  ProfileViewController.swift
//  DrinkwaterProj
//
//  Created by 이경후 on 2021/10/11.
//

import UIKit

class ProfileViewController: UIViewController {

    //imageView
    @IBOutlet var profileImageView: UIImageView!
    
    //labels
    @IBOutlet var nickNameLabel: UILabel!
    @IBOutlet var heightLabel: UILabel!
    @IBOutlet var weightLabel: UILabel!
    
    //buttons
    @IBOutlet var naviItems: UINavigationItem!
    @IBOutlet var checkButton: UIBarButtonItem!
    
    //textfields
    @IBOutlet var nickNameTextfield: UITextField!
    @IBOutlet var heightTextfield: UITextField!
    @IBOutlet var weightTextfield: UITextField!
    
    //textField에 바텀라인 넣기
    var bottmLine = CALayer()
    
    var imageArray : [UIImage]  = [
        UIImage(named: "1-1")!,
        UIImage(named: "1-2")!,
        UIImage(named: "1-3")!,
        UIImage(named: "1-4")!,
        UIImage(named: "1-5")!,
        UIImage(named: "1-6")!,
        UIImage(named: "1-7")!,
        UIImage(named: "1-8")!,
        UIImage(named: "1-9")!
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialPage()
       
    }
    func initialPage(){
        
        //백그라운드 색상
        self.view.backgroundColor = UIColor(red: 21/255, green: 156/255, blue: 96/255, alpha: 1)
        
        //버튼 색상
        checkButton.tintColor = .white
        self.navigationController?.navigationBar.tintColor = .white
        
        //UserDefaults로 이미지 인덱스 가져오기
        let myImageIndex = UserDefaults.standard.integer(forKey: "imageNumber")
        profileImageView.image = imageArray[myImageIndex]
        
        nickNameLabel =  nickNameLabel.myLabelStyle(label: nickNameLabel)
        if let nick = UserDefaults.standard.string(forKey: "nickname"){
            nickNameLabel.text = nick
        }else{
            //입력받은 것을 userDefaluts에 넣고 저장하기
            
        }
        heightLabel = heightLabel.myLabelStyle(label: heightLabel)
        if let height = UserDefaults.standard.string(forKey: "height") {
            nickNameLabel.text = height
        }else{
            //입력받은 것을 userDefaluts에 넣고 저장하기
            
        }
        weightLabel =  weightLabel.myLabelStyle(label: weightLabel)
        if let weight = UserDefaults.standard.string(forKey: "nickname"){
            nickNameLabel.text = String(weight)
        }else{
            //입력받은 것을 userDefaluts에 넣고 저장하기
            
        }
        nickNameTextfield.addBottomBorder()
        heightTextfield.addBottomBorder()
        weightTextfield.addBottomBorder()
        
    }
}
//텍스트필드 바텀라인
extension UITextField {
    func addBottomBorder(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 3, width: self.frame.size.width, height: 3)
        bottomLine.backgroundColor = UIColor.white.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}
//라벨 스타일
extension UILabel{
    func myLabelStyle(label : UILabel) -> UILabel{
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .white
        return label
    }
}
