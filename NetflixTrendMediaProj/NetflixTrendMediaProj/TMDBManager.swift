//
//  TMDBManager.swift
//  NetflixTrendMediaProj
//
//  Created by 이경후 on 2021/10/27.
//

import Foundation
import Alamofire
import SwiftyJSON

class TMDBManager{
    //싱글톤패턴
    static let shared = TMDBManager()
    //static을 이용해서 view컨트롤러에서 컨트롤
    static var startPage = 1
    static var totalPage = 0
    
    func fetchData(result : @escaping (Int,JSON)->()){
        
        let url = "https://api.themoviedb.org/3/trending/movie/day?api_key=\(APIDocs.TMDB_KEY)&language=ko&page=\(TMDBManager.startPage)"
        AF.request(url, method: .get).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let code = response.response?.statusCode ?? 500
                result(code, json)
            case .failure(let error):
                print(error)
            }
        }
    }
}
