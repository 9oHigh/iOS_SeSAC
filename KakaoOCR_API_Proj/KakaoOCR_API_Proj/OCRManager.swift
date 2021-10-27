//
//  OCRManager.swift
//  KakaoOCR_API_Proj
//
//  Created by 이경후 on 2021/10/27.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit.UIImage

class OCRManager{
    
    static let shared = OCRManager()
    
    func fetchData(image : UIImage,result: @escaping (Int,JSON)->()){
        
        let header : HTTPHeaders = [
            "Authorization" : APIDocs.KAKAO,
            "Content-Type" : "multipart/form-data"
        ]
        guard let imageData = image.pngData() else {return}
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "image", fileName: "image")
        }, to: EndPoint.OcrURL,headers: header)
            .validate(statusCode:200...500).responseJSON { response in
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    let code = response.response?.statusCode ?? 500
                    result(code, json)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
}
