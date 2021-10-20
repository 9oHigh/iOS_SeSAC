//
//  MapViewController.swift
//  NetflixTrendMediaProj
//
//  Created by 이경후 on 2021/10/20.
//

import UIKit
import MapKit
import CoreLocation //위치관련 클래스
import CoreLocationUI // 로케이션 버튼활용으로 활용,UI

enum Theater {
    case Mega,Lotte,CGV,All
}

class MapViewController: UIViewController {
    //위치 정보 구조체 배열 저장
    var mapAnnotations: [TheaterLocation] = [
        TheaterLocation(type: "롯데시네마", location: "롯데시네마 서울대입구", latitude: 37.4824761978647, longitude: 126.9521680487202),
        TheaterLocation(type: "롯데시네마", location: "롯데시네마 가산디지털", latitude: 37.47947929602294, longitude: 126.88891083192269),
        TheaterLocation(type: "메가박스", location: "메가박스 이수", latitude: 37.48581351541419, longitude:  126.98092132899579),
        TheaterLocation(type: "메가박스", location: "메가박스 강남", latitude: 37.49948523972615, longitude: 127.02570417165666),
        TheaterLocation(type: "CGV", location: "CGV 영등포", latitude: 37.52666023337906, longitude: 126.9258351013706),
        TheaterLocation(type: "CGV", location: "CGV 용산 아이파크몰", latitude: 37.53149302830903, longitude: 126.9654030486416)
    ]
    var target : Theater = .All
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        mapView.delegate = self
        initLocation()
        //메뉴바를 이용해서 구현해보자.
        //각각의 액션도 만들어두자.
        let theaterElem : [UIAction] = [
            UIAction(title: "메가박스") { (action) in
                self.theaterChange(which: "메가박스")},
            UIAction(title: "롯데시네마") { (action) in self.theaterChange(which: "롯데시네마")},
            UIAction(title: "CGV") { (action) in
                self.theaterChange(which: "CGV")},
            UIAction(title: "전체보기") { (action) in
                self.theaterChange(which: "전체보기")}
        ]
        let theaterMenu = UIMenu(title: "영화관 선택", image: .none, identifier: nil, options: .displayInline , children: theaterElem)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", image: .none, primaryAction: .none, menu: theaterMenu)
        
    }
    func theaterChange(which : String){
        let allAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotations)
        if which == "전체보기"{
            initLocation()
            return
        }
        for i in 0...mapAnnotations.count-1{
            if mapAnnotations[i].type == which{
                let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                let location = CLLocationCoordinate2D(latitude: mapAnnotations[i].latitude, longitude: mapAnnotations[i].longitude)
                let region = MKCoordinateRegion(center: location, span: span)

                mapView.setRegion(region, animated: true)

                let annotation = MKPointAnnotation()
                annotation.title = mapAnnotations[i].location
                annotation.coordinate = location

                mapView.addAnnotation(annotation)
            }
        }
        reloadInputViews()
    }
    func initLocation(){
        //나의 기본 위치
        let location = CLLocationCoordinate2D(latitude: 37.556124592490924, longitude: 126.97235991352282)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: location, span: span)
        
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.title = "Here!"
        annotation.coordinate = location
        
        mapView.addAnnotation(annotation)
        // 영화관 위치
        for i in 0...mapAnnotations.count-1 {
            let location = CLLocationCoordinate2D(latitude: mapAnnotations[i].latitude, longitude: mapAnnotations[i].longitude)
            let region = MKCoordinateRegion(center: location, span: span)

            mapView.setRegion(region, animated: true)

            let annotation = MKPointAnnotation()
            annotation.title = mapAnnotations[i].location
            annotation.coordinate = location

            mapView.addAnnotation(annotation)
        }
    }
}
extension MapViewController : CLLocationManagerDelegate{
    //위치를 허용한 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //위치의 가장 마지막 데이터가 가장 정확도가 높다.
        if let coordinate = locations.last?.coordinate {
            // 핀으로 위치 표시
            let annotation = MKPointAnnotation()
            annotation.title = "Current Location"
            mapView.addAnnotation(annotation)
           
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            mapView.setRegion(region, animated: true)
            
            locationManager.stopUpdatingLocation()
        } else {
            
            print("Location can not FIND.")
            
        }
    }
    //위치를 가지고 올 수 없을 때
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    //iOS 버전에 따른 분기 처리와 iOS 위치 서비스 여부 확인
    func checkUserLocationServiceAuthorization(){
        
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
            CCLAuth(auth: authStatus)
        } else {
            //켜져있지 않으니 알림 메세지를 띄어야한다.
            let alert = UIAlertController(title: "위치서비스 권한설정", message: "위치서비스를 켜주세요!", preferredStyle: UIAlertController.Style.alert)
            let checkAction = UIAlertAction(title: "OK", style: .default){(_) -> Void in
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {return}
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        print("Settings opened: \(success)")
                    })
                }
            }
            alert.addAction(checkAction)
            present(alert,animated: false,completion: nil)
        }
    }
    //사용자의 권한 상태 확인 - 사용자 정의 함수
    func CCLAuth(auth: CLAuthorizationStatus){
        switch auth {
            //정해지지 않음
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            //앱을 사용하는 동안에 대한 위치 권한 요청
            locationManager.requestWhenInUseAuthorization()
            //위치접근
            locationManager.startUpdatingLocation()
        case .restricted,.denied:
           print("restricted")
        case .authorizedWhenInUse:
            //didUpateLocations가 동작한다.
            locationManager.startUpdatingLocation()
        case .authorizedAlways:
            print("always")
        @unknown default:
            print("default")
        }
        
        if #available(iOS 14.0, *){
            //정확도 체크 : 정확도 감소가 되어 있을 경우, 1시간 4번, 미리알림, 배터리는 오래 사용할 수 있음.
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
    //iOS 14 미만 : 권한 변경 감지
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserLocationServiceAuthorization()
    }
    //iOS 14 이상
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkUserLocationServiceAuthorization()
    }
    
}
extension MapViewController : MKMapViewDelegate {
    
}

