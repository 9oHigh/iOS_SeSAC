//
//  ViewController.swift
//  DrinkwaterProj
//
//  Created by 이경후 on 2021/10/11.
//


/*해야하는 것
UserDefaults를 이용해서 
 */


import UIKit

class DrinkViewController: UIViewController,UITextFieldDelegate {
    //Buttons
    @IBOutlet var refreshButton: UIBarButtonItem!
    @IBOutlet var profileButton: UIBarButtonItem!
    @IBOutlet var drinkButton: UIButton!
    
    //View & ImageView
    @IBOutlet var myMainView: UIView!
    @IBOutlet var myPlantImageView: UIImageView!
    
    //Labels
    @IBOutlet var mainInformationLabel: UILabel!
    @IBOutlet var intakeLabel: UILabel!
    @IBOutlet var howDrinkLabel: UILabel!
    @IBOutlet var goalLabel: UILabel!
    
    //textField
    @IBOutlet var mlTextField: UITextField!{
        didSet {
            mlTextField.delegate = self
        }
    }
    
    //My variables
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
    var myImageIdx : Int = 0
    var howDrinkValue : Int = 0
    var goalPercent : Int = 0
    var intakeWater : Int = 0
    var nickname : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialPage()
    }
    
    func initialPage(){
        
        UserDefaults.standard.set(myImageIdx, forKey: "imageNumber")
        //background
        myMainView.backgroundColor = UIColor(red: 21/255, green: 156/255, blue: 96/255, alpha: 1)
        self.view.backgroundColor = UIColor(red: 21/255, green: 156/255, blue: 96/255, alpha: 1)
        
        //Bar buttons color
        refreshButton.tintColor = .white
        profileButton.tintColor = .white
        
        //잘하셨어요! 오늘 마신 양은
        mainInformationLabel.textColor = .white
        mainInformationLabel.font = UIFont.systemFont(ofSize: 20)
        mainInformationLabel.text = "잘하셨어요!\n오늘 마신 양은"
        mainInformationLabel.numberOfLines = 0
        
        //ml
        howDrinkLabel.textColor = .white
        howDrinkLabel.font = UIFont.boldSystemFont(ofSize: 23)
        howDrinkLabel.text = String(howDrinkValue) + "ml"
        
        //목표
        goalLabel.textColor = .white
        goalLabel.font = UIFont.systemFont(ofSize: 13)
        goalLabel.text = "목표의 " + String(goalPercent) + "%"
        
        //image
        myPlantImageView.image = imageArray[myImageIdx]
        
        //image label
        mlTextField.backgroundColor = UIColor(red: 21/255, green: 156/255, blue: 96/255, alpha: 1)
        mlTextField.borderStyle = .none
        
        //intake
        intakeLabel.textColor = .white
        intakeLabel.font = UIFont.systemFont(ofSize: 13)
        //변수로 설정하기 UserDefault
        intakeLabel.text = (UserDefaults.standard.string(forKey: "nickname") ?? "") + "님의 하루 물 권장 섭취량은 " + String(UserDefaults.standard.integer(forKey: "intakewater")) + "L입니다."
        
        //물마시기버튼
        drinkButton.backgroundColor = .white
        
    }
    
    //viewWillAppear 돌아올 때
    override func viewWillAppear(_ animated: Bool) {
        intakeLabel.text = (UserDefaults.standard.string(forKey: "nickname") ?? "") + "님의 하루 물 권장 섭취량은 " + String(UserDefaults.standard.integer(forKey: "intakewater")) + "L입니다."
    }
    
    //리프레시 버튼 클릭시 초기화 함수
    @IBAction func refreshButtonAction(_ sender: UIBarButtonItem) {
        howDrinkValue = 0
        howDrinkLabel.text = String(howDrinkValue) + "ml"
        goalPercent = 0
        goalLabel.text = "목표의 " + String(goalPercent) + "%"
        //이미지 다시픽
        pickImage(goalPercent)
    }
    
    //물마시기 버튼 클릭시
    @IBAction func drinkWaterButtonAction(_ sender: UIButton) {
        howDrinkValue = howDrinkValue + Int(mlTextField.text!)!
        howDrinkLabel.text = String(howDrinkValue) + "ml"
        
        goalPercent = (howDrinkValue/10) / UserDefaults.standard.integer(forKey: "intakewater")
        goalLabel.text = "목표의 " + String(goalPercent) + "%"
        //이미지 다시픽
        pickImage(goalPercent)
        //텍스트 초기화
        mlTextField.text = ""
    }
    func pickImage(_ goalPercent : Int){
        
        if 0 <= goalPercent && goalPercent < 10 { myImageIdx = 0}
        else if 10 <= goalPercent && goalPercent < 20 { myImageIdx = 1}
        else if 20 <= goalPercent && goalPercent < 30 { myImageIdx = 2}
        else if 30 <= goalPercent && goalPercent < 40 { myImageIdx = 3}
        else if 40 <= goalPercent && goalPercent < 50 { myImageIdx = 4}
        else if 50 <= goalPercent && goalPercent < 60 { myImageIdx = 5}
        else if 60 <= goalPercent && goalPercent < 70 { myImageIdx = 6}
        else if 70 <= goalPercent && goalPercent < 80 { myImageIdx = 7}
        else {myImageIdx = 8}
        
        myPlantImageView.image = imageArray[myImageIdx]
        UserDefaults.standard.set(myImageIdx, forKey: "imageNumber")
    }
    
    //키보드 함수 오르락 내리락~
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
}

