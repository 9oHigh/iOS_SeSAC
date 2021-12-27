//
//  PunkData.swift
//  Codable(+SnapKit)Proj
//
//  Created by 이경후 on 2021/12/26.
//

import UIKit
import Alamofire

class PunkAPI {
    
    //datas
    var id : Int = 0
    var imageURL : String = ""
    var tagLine : String = ""
    var name : String = ""
    var beerDescription : String = ""
    var foodParing : [String] = []
    
    func fetchData(completion : @escaping (Beer?)->Void){
        print(#function)
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        let url = "https://api.punkapi.com/v2/beers/\(id)"
        
        AF.request(url, method: .get).validate().responseDecodable(of: [Beer].self) { response in
            
            switch response.result {
                
            case .success:
                print("SUC")
                let jsonData = try? encoder.encode(response.value)
                if let jsonData = jsonData, let beerInfo = try? decoder.decode([Beer].self, from: jsonData){
                    print("SUCCESS")
                    completion(beerInfo.first)
                } else {
                    print("ERROR_IN_SUCCES")
                }
                
            case .failure:
                print("EEROR")
            }
        }
    }
}
