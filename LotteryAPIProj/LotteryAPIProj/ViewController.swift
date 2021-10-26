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
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var inputNumberTextField: UITextField!
    @IBOutlet weak var episodeLabel: UILabel!
    
    //이렇게 해야되는거 맞나..?
    @IBOutlet weak var drwtNo1: UILabel!
    @IBOutlet weak var drwtNo2: UILabel!
    @IBOutlet weak var drwtNo3: UILabel!
    @IBOutlet weak var drwtNo4: UILabel!
    @IBOutlet weak var drwtNo5: UILabel!
    @IBOutlet weak var drwtNo6: UILabel!
    @IBOutlet weak var bnusNo: UILabel!
    
    var date : String  = "추첨"
    var episode : Int = 986
    var episodeList  = [Int](1...986)
    var drwNumbersString : [String] = [
        "drwtNo1","drwtNo2","drwtNo3","drwtNo4","drwtNo5","drwtNo6","bnusNo"
    ]
    var luckyNumbers : [String] = []
    
    override func viewDidLoad(){
        super.viewDidLoad()
        //features
        introNumberLabel.font = UIFont.boldSystemFont(ofSize: 17)
        dateLabel.text = date
        inputNumberTextField.text = "\(episode)"
        episodeLabel.text = "\(episode)회"
        episodeLabel.textColor = .orange
        pickerView.isHidden = true
        episodeList = episodeList.sorted(by: >)
        
        //start
        getLotteryNumbers(episodeNumber: episode)
        //delegate + datasource
        pickerView.delegate = self
        pickerView.dataSource = self
        
        //delegate
        inputNumberTextField.delegate = self
    }
    func getLotteryNumbers(episodeNumber : Int){
        //변수 데이터 변경
        pickerView.isHidden = true
        episodeLabel.text = "\(episodeNumber)회"
        //API
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(episodeNumber)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                let date = json["drwNoDate"].stringValue
                self.dateLabel.text = date + " 추첨"
                
                self.luckyNumbers = []
                for item in self.drwNumbersString {
                    self.luckyNumbers.append( json[item].stringValue)
                    print(json[item])
                }
                //라벨을 꾸밀 함수
                self.drwtNo1.text = self.luckyNumbers[0]
                self.drwtNo1.styleLabel(label: self.drwtNo1)
                self.drwtNo2.text = self.luckyNumbers[1]
                self.drwtNo2.styleLabel(label: self.drwtNo2)
                self.drwtNo3.text = self.luckyNumbers[2]
                self.drwtNo3.styleLabel(label: self.drwtNo3)
                self.drwtNo4.text = self.luckyNumbers[3]
                self.drwtNo4.styleLabel(label: self.drwtNo4)
                self.drwtNo5.text = self.luckyNumbers[4]
                self.drwtNo5.styleLabel(label: self.drwtNo5)
                self.drwtNo6.text = self.luckyNumbers[5]
                self.drwtNo6.styleLabel(label: self.drwtNo6)
                self.bnusNo.text = self.luckyNumbers[6]
                self.bnusNo.styleLabel(label: self.bnusNo)
                
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
extension UILabel {
    
    func styleLabel(label : UILabel) {
        
        let colorSet : [UIColor] = [
            UIColor.brown,
            UIColor.red,
            UIColor.orange,
            UIColor.link,
            UIColor.darkGray,
            UIColor.systemPink,
            UIColor.gray
        ]
        
        label.textColor = .white
        label.backgroundColor = colorSet.randomElement()
        label.layer.cornerRadius = label.frame.width/2
        label.layer.masksToBounds = true
    }
}

