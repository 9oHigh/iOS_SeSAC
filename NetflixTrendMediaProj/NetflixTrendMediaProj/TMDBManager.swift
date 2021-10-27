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
    
    func fetchData(result : @escaping (Int,JSON)->()){
        
        let url = "https://api.themoviedb.org/3/trending/movie/day?api_key=\(APIDocs.TMDB_KEY)"
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
