//
//  PunkData.swift
//  Codable(+SnapKit)Proj
//
//  Created by 이경후 on 2021/12/26.
//

import UIKit
import Alamofire

class PunkAPI {
    
    static func fetchData(_ beerId : Int,completion : @escaping (Beer?)->Void){
        print(#function)
        
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
       
        let url = "https://api.punkapi.com/v2/beers/\(beerId)"
        AF.request(url, method: .get).validate().responseDecodable(of: [Beer].self) { response in
            
            DispatchQueue.main.async {
                
                switch response.result {
                    
                case .success:
                    
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
        }.resume()
    }
}
