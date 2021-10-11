//
//  ViewController.swift
//  DrinkwaterProj
//
//  Created by 이경후 on 2021/10/11.
//

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
    var howDrinkValue : Int = 0
    var goalPercent : Int = 0
    var myImageIdx : Int = 0
    
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
        intakeLabel.text = "안녕하세요님의 하루 물 권장 섭취량은 0L입니다."
        
        //물마시기버튼
        drinkButton.backgroundColor = .white
        
        
    }
    
    //키보드 함수
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
}

