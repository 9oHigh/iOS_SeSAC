//
//  PunkData.swift
//  Codable(+SnapKit)Proj
//
//  Created by 이경후 on 2021/12/26.
//

import UIKit
import Alamofire
import SwiftyJSON

class PunkAPI {

    static var id : Int = 195
    
    func fetchData(){

        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        let url = "https://api.punkapi.com/v2/beers/\(PunkAPI.id)"
        
        AF.request(url, method: .get).validate().responseDecodable(of: [Beer].self) { response in

            switch response.result{

            case .success:

                let jsonData = try? encoder.encode(response.value)
                if let jsonData = jsonData, let jsonString = String(data: jsonData, encoding: .utf8){
                    print(jsonString)
                } else {
                    print(response.result)
                }

            case .failure:
                print("EEROR")

            }
        }
//        AF.request(url, method: .get).validate().responseJSON { response in
//            switch response.result {
//            case .success:
//                let json = JSON(response.value)
//                print(json)
//
//            case .failure :
//
//            print("ERROR")
//            }
//        }
    }
}
