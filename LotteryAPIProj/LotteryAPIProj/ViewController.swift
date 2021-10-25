//
//  ViewController.swift
//  LotteryAPIProj
//
//  Created by 이경후 on 2021/10/25.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController,UITextFieldDelegate{
    
    @IBOutlet weak var introNumberLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var sessionLabel: UILabel!
    @IBOutlet weak var numbersLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var inputNumberTextField: UITextField!
    
    var date : String  = "추첨"
    var episode : Int = 986
    var episodeList  = [Int](1...986)
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        //features
        episodeList = episodeList.sorted(by: >)
        introNumberLabel.font = UIFont.boldSystemFont(ofSize: 17)
        dateLabel.text = date
        sessionLabel.text = String(episode) + "회 당첨결과"
        pickerView.isHidden = true
        
        //delegate + datasource
        pickerView.delegate = self
        pickerView.dataSource = self
        
        //delegate
        inputNumberTextField.delegate = self
        
    }
    
    func getLotteryNumbers(episodeNumber : Int){
        //변수 데이터 변경
        pickerView.isHidden = true
        sessionLabel.text = String(episodeNumber) + "회 당첨결과"
        /*
         dateLabel.text = [들어올 변수] + "추첨"
         numbersLabel.text = String([들어올 변수들])
         */
        //API
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=" + String(episodeNumber)
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        pickerView.isHidden = false
        return false
    }
}
extension ViewController : UIPickerViewDelegate,UIPickerViewDataSource{
    //column
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //column의 개수
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //데이터를 표시할 수 있는 로또의 회차수를 받아와야 한다.
        return episodeList.count
    }
    //title
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(episodeList[row])
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        inputNumberTextField.text = String(episodeList[row])
        getLotteryNumbers(episodeNumber: episodeList[row])
    }
}

