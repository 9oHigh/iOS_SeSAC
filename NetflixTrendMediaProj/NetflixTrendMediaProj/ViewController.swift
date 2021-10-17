//
//  ViewController.swift
//  NetflixTrendMediaProj
//
//  Created by 이경후 on 2021/10/17.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var ohJackView: UIView!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var shadowRoundedView: UIView!
    
    var myMediaList  = myMediaInfo()
    var myPosterList : [UIImage]! = [
        UIImage(named: "squid_game")!,
        UIImage(named: "maid")!,
        UIImage(named: "the_five_juana")!,
        UIImage(named: "sex_education")!,
        UIImage(named: "alice_in_borderland")!,
        UIImage(named: "kastanjemanden")!,
        UIImage(named: "hometown_cha_cha_cha")!,
        UIImage(named: "paw_pastrol")!,
        UIImage(named: "the_baby_sitter_club")!,
        UIImage(named: "a_tale_dark_grimm")!,
        UIImage(named: "greys_anatomy")!,
        UIImage(named: "house_of_secrets")!,
        UIImage(named: "the_kings_affection")!,
        UIImage(named: "nevertheless")!,
        UIImage(named: "the_bilion_dollar_code")!
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //쏄프!!
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        //쉐도우 + 라운드
        //View Bacground - 그림자효과주기 + 코너
        shadowRoundedView.layer.cornerRadius = 10
        shadowRoundedView.layer.shadowColor = UIColor.lightGray.cgColor
        shadowRoundedView.layer.shadowOpacity = 1.0
        shadowRoundedView.layer.shadowRadius = 10
        
        //tableView Color
    }
    //
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myMediaList.tvShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "mediaInfoCell") as? mediaInfoTableViewCell else {
            return UITableViewCell()
        }
        
        cell.posterImageView.image = myPosterList[indexPath.row]
        cell.posterImageView.layer.cornerRadius = 5
        
        cell.titleLabel.text = myMediaList.tvShow[indexPath.row].title
        cell.titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        cell.genreLabel.text = "#"+myMediaList.tvShow[indexPath.row].genre
        cell.genreLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        cell.rateLabel.text = String(myMediaList.tvShow[indexPath.row].rate)
        cell.dateLabel.text = myMediaList.tvShow[indexPath.row].releaseDate
        cell.dateLabel.textColor = .darkGray
        
        cell.peopleLabel.text = myMediaList.tvShow[indexPath.row].starring
        cell.peopleLabel.textColor = .lightGray
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return ohJackView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ohJackView.frame.height
    }
    
    @IBAction func searchButtonAction(_ sender: UIBarButtonItem) {
        //메인 뷰에서 바버튼아이템 클릭시 특정스토리보드의 원하는 컨트롤러를 원하는 방식으로 띄우는 방법
        //1.스토리보드 특정
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        //2.스토리보드 내 많은 뷰컨트롤러 중 전환하고자 하는 뷰컨트롤러 가져오기
        let vc = storyboard.instantiateViewController(withIdentifier: "searchViewController") as! searchViewController
        
        let nav = UINavigationController(rootViewController: vc)
        
        //옵션
        nav.modalPresentationStyle = .fullScreen
        nav.modalTransitionStyle = .coverVertical
        
        //3.Present [vc -> nav]
        self.present(nav, animated: true, completion: nil)
    }
   
}
