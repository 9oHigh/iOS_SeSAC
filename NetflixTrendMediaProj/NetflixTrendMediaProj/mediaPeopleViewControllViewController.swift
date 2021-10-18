//
//  mediaPeopleViewControllViewController.swift
//  NetflixTrendMediaProj
//
//  Created by 이경후 on 2021/10/17.
//

import UIKit
import Kingfisher

class mediaPeopleViewControllViewController: UIViewController {
    //Pass Data ( IMAGE )
    // 1. 공간
    var headerImageName : String?
    var charactorList : [String] = ["MyPerson","MyGirl","MyFriend"]
    
    @IBOutlet weak var peopleTableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //url타입으로 변환
        let url = URL(string: headerImageName ?? "https://www.themoviedb.org/t/p/original/oaGvjB0DvdhXhOAuADfHb261ZHa.jpg")
        //kingFish를 이용해 url의 이미지를 이미지 뷰에 세팅
        headerImageView.kf.setImage(with :url)
        
        peopleTableView.delegate = self
        peopleTableView.dataSource = self
    }
}
extension mediaPeopleViewControllViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(charactorList.count)
        return charactorList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "mediaPeopleTableViewCell",for: indexPath) as? mediaPeopleTableViewCell else {
            return UITableViewCell()
        }
        cell.actorImageView.image = UIImage(named: charactorList[indexPath.row])
        cell.actorImageView.layer.cornerRadius = 5
        
        cell.actorNameLabel.text = charactorList[indexPath.row]
        cell.actorNameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        cell.actorDescriptLabel.text = "배우에 대한 설명입니다.배우에 대한 설명입니다.배우에 대한 설명입니다."
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerView.frame.height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return headerView
    }
}
