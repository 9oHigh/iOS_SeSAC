//
//  ViewController.swift
//  SSAC13
//
//  Created by 이경후 on 2021/10/25.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import CoreLocation // 위치관련 클래스들이 있다!
import CoreLocationUI // iOS 15 Location Button이 생김!


class ViewController: UIViewController{
    
    //최상위
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationMark: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var wetPercentLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var weatherImageVIew: UIImageView!
    @IBOutlet weak var happyLabel: UILabel!
    
    let locationManager = CLLocationManager()
    var dateFormat = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //delegate
        locationManager.delegate = self
        dateFormat.dateFormat = "MM월 dd일 HH시 mm분"
        dateLabel.text = dateFormat.string(from: Date())
        
        //호출
        getCurrentWeather()
    }
    
    
    func getCurrentWeather(){
        //세종대학교 광개토관
        //키값 안보이게 하는 방법 알아놓기
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=37.550136619516515&lon=127."
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                                
                let currentTemp = json["main"]["temp"].doubleValue - 273.15
                self.tempLabel.text = "지금은 " + String(Int(currentTemp)) + "도에요."
                
                let currentHumidity = json["main"]["humidity"].intValue - 1
                self.wetPercentLabel.text = "\(currentHumidity) %만큼 습해요."
                
                let currentWind = json["wind"]["speed"].intValue
                self.windLabel.text = "\(currentWind)m/s의 바람이 불어요!"
                
                var imageUrl = json["weather"][0]["icon"].stringValue
                imageUrl = "https://openweathermap.org/img/wn/\(imageUrl)@2x.png"
                let url = URL(string: imageUrl)
                self.weatherImageVIew.kf.setImage(with: url)
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
}
extension ViewController : CLLocationManagerDelegate{
    
    func checkUesrLocationServiceAuthorization(){
        let authStatus : CLAuthorizationStatus
        //iOS 14 이상에서만 사용가능한 권환 여부 확인
        if #available(iOS 14.0, *){
            authStatus = locationManager.authorizationStatus
        } else {
            //iOS 14 미만에서 사용가능
            authStatus =  CLLocationManager.authorizationStatus()
        }
        //iOS 위치확인 서비스
        if CLLocationManager.locationServicesEnabled(){
            //권한 상태를 이제서야 확인할 수 있는 구조
            //권한 상태를 확인 및 권한 요청 가능해지므로 8번호출
            checkCurrentLocationAuthorization(auth: authStatus)
        } else {
            //켜져있지 않으니 알림 메세지를 띄어야한다.
            print("위치서비스 키자!")
        }
    }
    
    //4. 사용자 정의함수 / 위치권한의 상태 확인
    func checkCurrentLocationAuthorization(auth: CLAuthorizationStatus){
        
        switch auth {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            self.locationMark.image = UIImage(systemName: "location.fill")
        case .restricted, .denied:
            self.locationMark.image = UIImage(systemName: "location")
            print("설정화면으로 이동")
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            self.locationMark.image = UIImage(systemName: "location.fill")
        case .authorizedAlways:
            print("ALWAYS")
        @unknown default:
            print("DEFAULT")
            
        }
        if #available(iOS 14.0, *){
            let accurancyState = locationManager.accuracyAuthorization
            switch accurancyState {
            case .fullAccuracy:
                print("FULL")
            case .reducedAccuracy:
                print("REDUCE")
            @unknown default:
                print("Default")
            }
        }
    }
    
    //1. 위치허용상태
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //여기서 마지막 좌표로 데이터를 가져와야함
        if let coordinate = locations.last?.coordinate {
            let findLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
            let geocoder = CLGeocoder()
            let locale = Locale(identifier: "ko-kr")
            geocoder.reverseGeocodeLocation(findLocation, preferredLocale: locale) { placemarks, error in
                if let address: [CLPlacemark] = placemarks{
                    if let name : String = address.last?.name{
                        self.locationLabel.text = name
                    }
                }
            }
        }
    }
    //2. 위치비허용상태
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    //3.1 iOS 14.0 미만
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkUesrLocationServiceAuthorization()
    }
    //3.2 iOS 14.0 이상
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUesrLocationServiceAuthorization()
    }
}
