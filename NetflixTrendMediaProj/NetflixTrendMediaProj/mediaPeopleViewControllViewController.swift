//
//  mediaPeopleViewControllViewController.swift
//  NetflixTrendMediaProj
//
//  Created by 이경후 on 2021/10/17.
//

import UIKit
import Kingfisher
import Alamofire
import SwiftyJSON

class mediaPeopleViewControllViewController: UIViewController {
    
    //Pass Data ( IMAGE )
    // 1. 공간
    var headerImageName : String?
    var posterName : String?
    var titleName : String?
    var summary : String?
    var movie_id : Int?
    var clicked : Bool = false
    
    var castNameList : [String] = []
    var profileList : [String] = []
    var characList : [String] = []
    
    @IBOutlet weak var peopleTableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var headerImageViewPoster: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //url타입으로 변환 : KingFish를 이용하기 위해
        let url = URL(string: headerImageName ?? "https://www.themoviedb.org/t/p/original/oaGvjB0DvdhXhOAuADfHb261ZHa.jpg")
        
        //kingFish를 이용해 url의 이미지를 이미지 뷰에 세팅
        headerImageView.kf.setImage(with :url)
        headerImageView.alpha = 0.88 //불투명도 주기
        
        //delegate + datasource
        peopleTableView.delegate = self
        peopleTableView.dataSource = self
        
        //헤더뷰 - 가지고온 데이터로 didload()
        let postUrl = URL(string: posterName!)
        headerImageViewPoster.kf.setImage(with: postUrl)
        headerImageViewPoster.layer.cornerRadius = 5
        
        //코너를 깎기위해 clipsToBounds
        headerImageViewPoster.clipsToBounds = true
        
        //이름 가지고오기
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .white
        titleLabel.text = titleName ?? "Squid Game"
        title = "등장인물"
        
        peopleFetchData()
    }
    func peopleFetchData(){
        let url = "https://api.themoviedb.org/3/movie/\( movie_id!)/credits?api_key=\(APIDocs.TMDB_KEY)&language=en-US"
//        print(url)
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                for item in json["cast"].arrayValue {
                    let cast = item["name"].stringValue
                    self.castNameList.append(cast)
                    
                    let character = item["character"].stringValue
                    self.characList.append(character)
                    
                    let profile = APIDocs.TMDB_PosterPATH + item["profile_path"].stringValue
                    
                    self.profileList.append(profile)
//                    print(cast,character,profile)
                }
            case .failure(let error):
                print(error)
            }
            self.peopleTableView.reloadData()
        }
    }
    @objc func arrowButtonClicked (selectedButton : UIButton){
        clicked.toggle()
        peopleTableView.reloadRows(at: [IndexPath(item: 0, section: 0)], with: .fade)
    }
    
}
extension mediaPeopleViewControllViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //임시
        return castNameList.count + 1 //과제로 추가된 섹션넣기위함
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //tag = 1
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "summaryTableViewCell",for: indexPath) as? summaryTableViewCell else {
                return UITableViewCell()
            }
            cell.summaryLabel.text = summary ?? ""
            //오토매틱 디멘션을 사용하는 방법을 알아보자..
            //테이블 뷰가 하나인데 두개의 테이블 뷰가 있어야하는 건가!
            clicked == true ? (cell.summaryLabel.numberOfLines = 0) : (cell.summaryLabel.numberOfLines = 2)
            clicked == true ?
            cell.arrowButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
            :cell.arrowButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            
            cell.arrowButton.addTarget(self, action: #selector(arrowButtonClicked(selectedButton:)), for: .touchUpInside)
            
            return cell
        }
        //tag = 2
        else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "mediaPeopleTableViewCell",for: indexPath) as? mediaPeopleTableViewCell else {
                return UITableViewCell()
            }
            //임시
            
            let url =  URL(string: profileList[indexPath.row-1])
            cell.actorImageView.kf.setImage(with: url)
            cell.actorImageView.layer.cornerRadius = 5
            
            //임시
            cell.actorNameLabel.text = castNameList[indexPath.row-1]
            cell.actorNameLabel.font = UIFont.boldSystemFont(ofSize: 20)
            
            cell.actorDescriptLabel.text = characList[indexPath.row-1]
            cell.actorDescriptLabel.font = UIFont.systemFont(ofSize: 18)
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerView.frame.height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return headerView
    }
}
