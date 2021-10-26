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

class ViewController: UIViewController {
    
    @IBOutlet weak var rankingTableView: UITableView!
    @IBOutlet var dateTextfield: UITextField!
    
    var moviesData : [MovieData] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delegate + datasource
        rankingTableView.delegate = self
        rankingTableView.dataSource = self
        rankingTableView.backgroundColor = .black
        //featuers
        dateTextfield.placeholder = "20200401"
        
    }
    
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        
        if let text = dateTextfield.text{
            
            let url = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=&targetDt=" + text
            print(text,url)
            AF.request(url, method: .get).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
//                    print(json)
                    for item in 0...10{
                        let title = json["boxOfficeResult"]["dailyBoxOfficeList"][item]["movieNm"].stringValue
                        let date = json["boxOfficeResult"]["dailyBoxOfficeList"][item]["openDt"].stringValue
                        let data = MovieData(title: title, releaseDate: date)
                        self.moviesData.append(data)
                    }
                    self.rankingTableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
            
        }
    }
}
extension ViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesData.count-1
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

