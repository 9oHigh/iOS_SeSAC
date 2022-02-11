//
//  OpenWeatherAPIManager.swift
//  OpenWeatherAPIProj
//
//  Created by 이경후 on 2021/10/27.
//

import Foundation
import SwiftyJSON
import Alamofire


class OpenWeatherAPIManager {
    
    //싱클톤 패턴
    static let shared = OpenWeatherAPIManager()
    //세종대학교 광개토관
    //키값 안보이게 하는 방법 알아놓기
    func fetchData(result: @escaping (Int,JSON)->()) {
        
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=37.550136619516515&lon=127.073179&appid="
        AF.request(url, method: .get).validate(statusCode: 200...500).responseJSON { response in
            switch response.result{
                
            case .success(let value):
                let json = JSON(value)
                let code = response.response?.statusCode ?? 500
                result(code, json)
            case .failure(let error):
                print("Error: ",error)
            }
        }
    }
}
