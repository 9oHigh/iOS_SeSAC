//
//  ViewController.swift
//  CurrencyRateProj
//
//  Created by 이경후 on 2021/10/13.
//

import UIKit

var outDidSetPrint : String = "1"
var outWillSetPrint : String = "2"
var outUSDDidSetPrint : String = "3"
var outUSDWillSetPrint : String = "4"

struct ExchangeRate {
    
    var currencyRate : Double {
        willSet{
            outWillSetPrint = "환율이 변동 예정 : \(currencyRate) -> \(newValue)"
        }
        didSet{
            outDidSetPrint = "환율이 변동 완료 : \(oldValue) -> \(currencyRate)"
        }
    }
    var USD: Double{
        willSet{
            outUSDWillSetPrint = "환전금액 : \(newValue)달러로 환전될 예정"
        }
        didSet{
            outUSDDidSetPrint = "KRW: \(KRW)원 -> \(USD)달러로 환전될 예정"
        }
    }
    var WON : Double
    
    var KRW : Double {
        get {
            return WON
        }
        set {
            WON = newValue
        }
    }
}

class ViewController: UIViewController {
    
    @IBOutlet var checkButton: UIButton!
    @IBOutlet var rateTextField: UITextField!
    @IBOutlet var krwTextField: UITextField!
    @IBOutlet var outLabel: UILabel!
    //default
    var rate : ExchangeRate = ExchangeRate(currencyRate: 1200, USD: 1, WON: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkButton.layer.cornerRadius = 10
        rateTextField.placeholder = "1250"
        krwTextField.placeholder = "나도 좀 주라 😊"
        
    }
    @IBAction func checkButtonAction(_ sender: UIButton) {
        
        print("Clicked")
        
        rate.WON = Double(krwTextField.text!) ?? 0
        rate.currencyRate = Double(rateTextField.text!) ?? 0
        rate.USD = Double(rate.WON/rate.currencyRate)
        
        rateTextField.text = ""
        krwTextField.text = ""
        rateTextField.placeholder = "1250"
        krwTextField.placeholder = "나도 좀 주라 😊"
        
        if (rate.WON == 0 || rate.currencyRate == 0 || rate.USD == 0){
            outLabel.text = "잘못입력했어요! 위의 내용을 반드시 숫자로만 적어주세요!"
        } else {
            outLabel.text = "(1)"+outWillSetPrint + "\n\n" + "(2)"+outDidSetPrint + "\n\n" + "(3)" + outUSDWillSetPrint + "\n\n" + "(4)"+outUSDDidSetPrint
        }
    }
}

