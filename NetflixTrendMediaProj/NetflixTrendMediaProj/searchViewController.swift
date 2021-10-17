//
//  SearchViewController.swift
//  TrendMediaProj
//
//  Created by 이경후 on 2021/10/17.
//

import UIKit

class searchViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var searchTableView: UITableView!
    var myMediaSearchList = myMediaInfo()
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
        //새로운 뷰에서 navigation Item을 컨트롤
        //버튼을 활용할 시( 거의 필수 )에 UIBarButtonItem 사용할 것
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        //색상 변경
        navigationItem.leftBarButtonItem?.tintColor = .black
        searchTableView.delegate = self
        searchTableView.dataSource = self
    }
    //버튼 클릭시 화면자체를 스택에서 제거
    //계속 쌓이게 되면 에러가 발생할 수 있음
    @objc func closeButtonClicked(){
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myMediaSearchList.tvShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchInfoCell") as? searchTableViewCell else {
            return UITableViewCell()
        }
        cell.posterImage.image = myPosterList[indexPath.row]
        cell.titleLabel.text = myMediaSearchList.tvShow[indexPath.row].title
        cell.titleLabel.font = UIFont.boldSystemFont(ofSize: 19)
        cell.resultLabel.text = myMediaSearchList.tvShow[indexPath.row].starring
        cell.contentLabel.text = myMediaSearchList.tvShow[indexPath.row].overview
        return cell
    }
}
