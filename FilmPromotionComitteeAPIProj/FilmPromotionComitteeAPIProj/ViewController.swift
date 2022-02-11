//
//  ViewController.swift
//  FilmPromotionComitteeAPIProj
//
//  Created by 이경후 on 2021/10/26.
//

import UIKit
import Alamofire
import SwiftyJSON
import TextFieldEffects
import RealmSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var rankingTableView: UITableView!
    @IBOutlet var dateTextfield: UITextField!
    
    //MARK: moviesData 및 Contains 제거하고 해보기
    let localRealm = try! Realm()
    var tasks : Results<DailyMovie>!
    var newDate : String = "20200401"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delegate + datasource
        rankingTableView.delegate = self
        rankingTableView.dataSource = self
        rankingTableView.backgroundColor = .black
        
        //featuers
        dateTextfield.placeholder = "20200401"
        
        //Realm
        tasks = localRealm.objects(DailyMovie.self)
        print("위치 :",localRealm.configuration.fileURL!)
        
        //init
        fetchData(dates: newDate)
    }
    func fetchData(dates: String){
        let url = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=a21ef4c9d70b9750b77ca59c9ab7a2ed&targetDt=\(dates)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for item in 0...9 {
                    let title = json["boxOfficeResult"]["dailyBoxOfficeList"][item]["movieNm"].stringValue
                    let date = json["boxOfficeResult"]["dailyBoxOfficeList"][item]["openDt"].stringValue
                    let task = DailyMovie(name: title, date: date, inputDate: dates)
                    try! self.localRealm.write{
                        self.localRealm.add(task)
                    }
                }
                self.rankingTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        //조금더 정확한 정규식이 필요할 것 같다.
        //2004년부터 데이터 존재
        let pattern : String = "^20([0-2])([4-9])([0-1])([0-9])([0-1])([0-9])$"
        var text : String
        
        //정규식 활용
        if let _ = dateTextfield.text?.range(of: pattern,options: .regularExpression) {
            text = dateTextfield.text!
        } else {
            //MARK: Extension을 이용하여 Alert표시
            showAlert(alertText: "날짜", alertMessege: "날짜를 잘못 입력하셨습니다.", alertTitle: "확인")
            dateTextfield.text = ""
            return
        }
        
        // 존재함
        if !localRealm.objects(DailyMovie.self).filter("inputDate == '\(text)'").isEmpty{
            newDate = text
            self.rankingTableView.reloadData()
        } else {
            // 존재하지 않음
            newDate = text
            fetchData(dates: newDate)
        }
    }
}
extension ViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as? MovieTableViewCell else {
            return UITableViewCell()
        }
        //MARK: localRealm에서 바로가지고오기
        tasks = localRealm.objects(DailyMovie.self).filter("inputDate == '\(newDate)'")
        
        //가장처음 데이터가 없기 때문에 0에 접근해버린 상태로 진행된다. -> 오류남 // 예외처리를 해야함
        guard let count = tasks?.count,indexPath.row < count else {return cell}
        
        cell.movieNameLabel.text = tasks[indexPath.row].name
        cell.movieNameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        cell.movieNameLabel.textColor = .white
        cell.movieNameLabel.textAlignment = .center
        
        cell.dateLabel.text = tasks[indexPath.row].date
        cell.dateLabel.textColor = .white
        cell.dateLabel.numberOfLines = 0
        cell.dateLabel.textAlignment = .center
        
        cell.levelLabel.font = UIFont.boldSystemFont(ofSize: 17)
        cell.levelLabel.textColor = UIColor.black
        cell.levelLabel.text = String(indexPath.row+1)
        cell.levelLabel.backgroundColor = .white
        cell.levelLabel.textAlignment = .center
        
        cell.backgroundColor = .black
        
        return cell
    }
}
extension ViewController {
    //Show Alert
    func showAlert(alertText : String, alertMessege : String, alertTitle: String){
        let alert = UIAlertController(title: alertText, message: alertMessege, preferredStyle: .alert)
        let action = UIAlertAction(title: alertTitle, style: .default, handler: nil)
        alert.addAction(action)
        
        self.present(alert,animated: true,completion: nil)
    }
}
