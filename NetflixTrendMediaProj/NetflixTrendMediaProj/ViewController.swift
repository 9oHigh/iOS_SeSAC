//
//  ViewController.swift
//  NetflixTrendMediaProj
//
//  Created by 이경후 on 2021/10/17.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var ohJackView: UIView!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var shadowRoundedView: UIView!
    
    var myMediaList  = myMediaInfo()
    var myPosterList : [String] = [
        "squid_game",
        "maid",
        "the_five_juana",
        "sex_education",
        "alice_in_borderland",
        "kastanjemanden",
        "hometown_cha_cha_cha",
        "paw_pastrol",
        "the_baby_sitter_club",
        "a_tale_dark_grimm",
        "greys_anatomy",
        "house_of_secrets",
        "the_kings_affection",
        "nevertheless",
        "the_bilion_dollar_code"
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
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = ohJackView.bounds
        gradientLayer.colors = [UIColor.link]
        ohJackView.layer.addSublayer(gradientLayer)
        
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
    @IBAction func linkButtonClicked(_ sender: UIButton) {
        //스토리보드 특정
        let myStoryboards = UIStoryboard(name: "Main", bundle: nil)
        //가지고올 컨트롤러 특정
        let viewController = myStoryboards.instantiateViewController(withIdentifier: "webStoryboard") as! WebViewController
        //네비게이션 컨트롤러 루트컨트롤러로 지정
        let navi = UINavigationController(rootViewController: viewController)
        
        //옵션설정
        navi.modalPresentationStyle = .formSheet
        navi.modalTransitionStyle = .coverVertical
        
        //데이터 연결
        //웹뷰의 이미지 링크를 전달해준다. 임시로 넣을 이미지!
        viewController.myLink = myMediaList.tvShow[sender.tag].backdropImage
        //타이틀을 전달해준다!
        viewController.pageTitle = myMediaList.tvShow[sender.tag].title
        
        self.present(navi, animated: true, completion: nil)
    }
    @IBAction func bookButtonClicked(_ sender: UIButton) {
        //스토리보드 특정
        let myStoryboard = UIStoryboard(name: "Main", bundle: nil)
        //가지고올 컨트롤러 특정
        let vc = myStoryboard.instantiateViewController(withIdentifier: "bookStoryboard") as! BookViewController
        
        let nav = UINavigationController(rootViewController: vc)
        
        //옵션
        nav.modalPresentationStyle = .fullScreen
        nav.modalTransitionStyle = .coverVertical
        
        //3.Present [vc -> nav]
        self.present(nav, animated: true, completion: nil)
        //옵션설정
        //self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension ViewController :UITableViewDataSource, UITableViewDelegate{
    
    //섹션의 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myMediaList.tvShow.count
    }
    //셀 디자인
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "mediaInfoCell") as? mediaInfoTableViewCell else {
            return UITableViewCell()
        }
        // 웹뷰로 띄울 시에 저굥ㅇ하기 위해 태그를 넣어준다.
        // 다만 다른 곳에서 indexPath를 이용해 태그를 줄수없음
        cell.linkButton.tag = indexPath.row
        //포스터 이미지
        cell.posterImageView.image =  UIImage(named: myPosterList[indexPath.row])
        cell.posterImageView.layer.cornerRadius = 5
        //타이틀 라벨
        cell.titleLabel.text = myMediaList.tvShow[indexPath.row].title
        cell.titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        //장르 라벨
        cell.genreLabel.text = "#"+myMediaList.tvShow[indexPath.row].genre
        cell.genreLabel.font = UIFont.boldSystemFont(ofSize: 20)
        //평점 라벨
        cell.rateLabel.text = String(myMediaList.tvShow[indexPath.row].rate)
        //개봉일 라벨
        cell.dateLabel.text = myMediaList.tvShow[indexPath.row].releaseDate
        cell.dateLabel.textColor = .darkGray
        //출연진 라벨
        cell.peopleLabel.text = myMediaList.tvShow[indexPath.row].starring
        cell.peopleLabel.textColor = .lightGray
        
        return cell
    }
    //헤더 테이블 설정하기
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return ohJackView
    }
    //헤더 테이블 높이
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ohJackView.frame.height
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return -20
    }
    //셀 선택시에
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //스토리보드 특정
        let myStoryboard = UIStoryboard(name: "Main", bundle: nil)
        //컨트롤러 특정
        let vc = myStoryboard.instantiateViewController(withIdentifier: "peopleStoryboard") as! mediaPeopleViewControllViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        //새롭게 뜨는 화면(mediaPeople)의 header 이름을 전달하고 이를 이용해 이미지 적용
        vc.posterName = myPosterList[indexPath.row]
        vc.titleName = myMediaList.tvShow[indexPath.row].title
        vc.headerImageName = myMediaList.tvShow[indexPath.row].backdropImage
        vc.summary = myMediaList.tvShow[indexPath.row].overview
    }
}
