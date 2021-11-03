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
    
    let localRealm = try! Realm()
    var tasks : Results<DailyMovie>!
    var moviesData : [MovieData] = []
    var containDateList : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delegate + datasource
        rankingTableView.delegate = self
        rankingTableView.dataSource = self
        rankingTableView.backgroundColor = .black
        //featuers
        dateTextfield.placeholder = "20200401"
        //해당 컬럼의 값들 넣어주기.. 너무 수동적인데
        containDateList = []
        
        tasks = localRealm.objects(DailyMovie.self)
        print("위치 :",localRealm.configuration.fileURL!)
    }
    
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        //가장 먼저
        print(self.containDateList)
        moviesData.removeAll()
        if let text = dateTextfield.text{
            if text == "" || text.count != 8{
                let alert = UIAlertController(title: "오입력 안내", message: "년도/월/일 순으로 정확히 입력해주세요. ex)20201201", preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(action)
                
                present(alert,animated: true,completion: nil)
                dateTextfield.text = ""
                return
            }
            // 데베에 들어가 있음
            if self.containDateList.contains(text){
                for item in localRealm.objects(DailyMovie.self).filter("inputDate == '\(text)'"){
                    let name = item.name
                    let date = item.date
                    let data = MovieData(title: name, releaseDate: date)
                    self.moviesData.append(data)
                }
                self.rankingTableView.reloadData()
            } else {
                // 안들어가 있음
                // 여기서 DB에 저장필요
                self.containDateList.append(text)
                let url = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\("key")&targetDt=" + text
                
                AF.request(url, method: .get).validate().responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        
                        for item in 0...9 {
                            let title = json["boxOfficeResult"]["dailyBoxOfficeList"][item]["movieNm"].stringValue
                            let date = json["boxOfficeResult"]["dailyBoxOfficeList"][item]["openDt"].stringValue
                            let data = MovieData(title: title, releaseDate: date)
                            let task = DailyMovie(name: title, date: date, inputDate: text)
                            try! self.localRealm.write{
                                self.localRealm.add(task)
                            }
                            self.moviesData.append(data)
                        }
                        self.rankingTableView.reloadData()
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        } else {
            let alert = UIAlertController(title: "오입력 안내", message: "년도/월/일 순으로 정확히 입력해주세요. ex)20201201", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(action)
            
            present(alert,animated: true,completion: nil)
        }
    }
}
extension ViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as? MovieTableViewCell else {
            return UITableViewCell()
            
        }
        cell.movieNameLabel.text = moviesData[indexPath.row].title
        cell.movieNameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        cell.movieNameLabel.textColor = .white
        
        cell.dateLabel.text = moviesData[indexPath.row].releaseDate
        cell.dateLabel.textColor = .white
        
        cell.levelLabel.font = UIFont.boldSystemFont(ofSize: 17)
        cell.levelLabel.textColor = UIColor.black
        cell.levelLabel.text = String(indexPath.row+1)
        cell.levelLabel.backgroundColor = .white
        
        cell.backgroundColor = .black
        
        return cell
    }
}

