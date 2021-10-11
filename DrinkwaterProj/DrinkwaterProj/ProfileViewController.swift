//
//  ProfileViewController.swift
//  DrinkwaterProj
//
//  Created by 이경후 on 2021/10/11.
//

/*해야하는 것
 1. 초기화 버튼 클릭시
 - 마신 물의 양 초기화
 
 2. 마신 물의 양 입력 + button 클릭시
 - 키보드 올라간 만큼 화면 올리기
 - 입력 후 마신물의 양 변화 밑 목표치 변화시키기
 
 3.유저의 닉네임 설정, 키 설정, 몸무게 저장시
 - UserDefaluts로 저장 밑 DrinkView와 profileView에 표시
 */


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
        heightLabel = heightLabel.myLabelStyle(label: heightLabel)
        weightLabel =  weightLabel.myLabelStyle(label: weightLabel)
        
        nickNameTextfield.addBottomBorder()
        nickNameTextfield.text = UserDefaults.standard.string(forKey: "nickname") ?? ""
        
        heightTextfield.addBottomBorder()
        heightTextfield.text = UserDefaults.standard.string(forKey: "height") ?? ""
        
        weightTextfield.addBottomBorder()
        weightTextfield.text = UserDefaults.standard.string(forKey: "weight") ?? ""
        
    }
    
    @IBAction func checkButtonAction(_ sender: UIBarButtonItem) {
        UserDefaults.standard.set(nickNameTextfield.text, forKey: "nickname")
        UserDefaults.standard.set(heightTextfield.text, forKey: "height")
        UserDefaults.standard.set(weightTextfield.text, forKey: "weight")
        UserDefaults.standard.set(intakeWater(),forKey: "intakewater")
    }
    
    func intakeWater () -> Int{
        let myHeight = UserDefaults.standard.string(forKey: "height") ?? "0"
        let myWeight = UserDefaults.standard.string(forKey: "weight") ?? "0"
        let totalWater = (Int(myHeight) ?? 0) + (Int(myWeight) ?? 0)
        print((totalWater) / 100)
        return (totalWater) / 100
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
