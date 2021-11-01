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

class searchViewController: UIViewController{
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    var movieData : [MovieModel] = []
    var startPage : Int = 1
    var totalCount : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "영화 검색"
        //새로운 뷰에서 navigation Item을 컨트롤
        //버튼을 활용할 시( 거의 필수 )에 UIBarButtonItem 사용할 것
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        //색상 변경
        navigationItem.leftBarButtonItem?.tintColor = .black
        //tableView delegate + dataSource
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.prefetchDataSource = self
        
        //SearchBar delegate
        searchBar.delegate = self
    }
    //버튼 클릭시 화면자체를 스택에서 제거
    //계속 쌓이게 되면 에러가 발생할 수 있음
    @objc func closeButtonClicked(){
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    //영화 데이터를 가지고와보자 ( 네이버 영화 )
    func fetchMovieData(query: String){
        if let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
            let url =  "https://openapi.naver.com/v1/search/movie.json?query=\(query)&display=10&start=\(startPage)"
            let header : HTTPHeaders = [
                "X-Naver-Client-Id" : APIDocs.NAVER_ID,
                "X-Naver-Client-Secret" : APIDocs.NAVER_PASS
            ]
            
            AF.request(url, method: .get,headers: header).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
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
                    DispatchQueue.main.async {
                        self.searchTableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
extension searchViewController : UISearchBarDelegate{
    //검색버튼이 눌렀을 때 ( 키보드의 리턴키! )
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        if let text = searchBar.text{
            movieData.removeAll()
            startPage = 1
            fetchMovieData(query: text)
        }
    }
    //취소버튼 눌렀을 때
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        movieData.removeAll()
        searchTableView.reloadData()
        
    }
    //서치바에서 커서가 깜빡이기 시작할 때
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
}
extension searchViewController : UITableViewDataSource, UITableViewDelegate,UITableViewDataSourcePrefetching{
    //셀이 화면에 보이기 전에 필요한 리소스를 미리 다운 받는 기능! 무한스크롤!
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        totalCount += 11
        for indexPath in indexPaths {
            if movieData.count - 1 == indexPath.row && movieData.count < totalCount{
                startPage += 10
                self.fetchMovieData(query: self.searchBar.text!)
                print("prefetch: \(indexPath)")
            }
        }
    }
    //취소!
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("취소 : \(indexPaths)")
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
}

