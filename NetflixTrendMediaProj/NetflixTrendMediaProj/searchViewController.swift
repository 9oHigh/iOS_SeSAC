//
//  SearchViewController.swift
//  TrendMediaProj
//
//  Created by 이경후 on 2021/10/17.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class searchViewController: UIViewController,UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    var movieData : [MovieModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //새로운 뷰에서 navigation Item을 컨트롤
        //버튼을 활용할 시( 거의 필수 )에 UIBarButtonItem 사용할 것
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        //색상 변경
        navigationItem.leftBarButtonItem?.tintColor = .black
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        //delegate
        searchBar.delegate = self
        
        fetchMovieData()
    }
    //버튼 클릭시 화면자체를 스택에서 제거
    //계속 쌓이게 되면 에러가 발생할 수 있음
    @objc func closeButtonClicked(){
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchInfoCell") as? searchTableViewCell else {
            return UITableViewCell()
        }
        let row = movieData[indexPath.row]
        //url if let 처리해두기 : 기본이미지 설정
        if let url = URL(string: row.imageData){
        cell.posterImage.kf.setImage(with: url)
        } else {
            cell.posterImage.image = UIImage(systemName: "star")
        }
        cell.titleLabel.text = row.titleData
        cell.titleLabel.font = UIFont.boldSystemFont(ofSize: 19)
        cell.resultLabel.text = row.userRatingData
        cell.contentLabel.text = row.subtitle

        return cell
    }
    //영화 데이터를 가지고와보자 ( 네이버 영화 )
    func fetchMovieData(){
        if let movieNmae = "스파이더맨".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
            let url =  "https://openapi.naver.com/v1/search/movie.json?query=\(movieNmae)&display=15&start=1"
            let header : HTTPHeaders = [
               
            ]
            AF.request(url, method: .get,headers: header).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
//                    print("JSON: \(json)")
                    for item in json["items"].arrayValue {
                        let title = item["title"].stringValue.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
                        let image = item["image"].stringValue
                        let link = item["link"].stringValue
                        let userRating = item["userRating"].stringValue
                        let subtitle = item["subtitle"].stringValue
                        let data = MovieModel(titleData: title, imageData: image, linkData: link, userRatingData: userRating, subtitle: subtitle)
                        
                        self.movieData.append(data)
                    }
                    //여기서 다시 리로드해야만해!! 가장 중요!!
                    self.searchTableView.reloadData()
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
