
### iOS App Programming with SeSAC 🧑🏻‍💻
　-︎ 배운것을 학습하고 적용하는 연습장 🔥

### 프로젝트 요약
|프로젝트|설명|
|:---:|:---:|
|DrinkwaterProj| 물마시기 애플리케이션으로 UserDefaults를 이용하여 값을 저장하고 활용하는 방법을 학습|
|TableViewProj| UITableViewController를 이용해 TableView의 기초적인 사용방법을 학습|
|CurrencyRateProj| 간단한 환율 계산기 애플리케이션으로 didSet / willSet 그리고 get / set을 학습|
|ShoppingListProj| 쇼핑리스트를 작성할 수 있는 간단한 애플리케이션으로 백업 / 복구 / 공유 기능을 위해 Zip과 더불어 Realm, Custom Cell을 학습|
|LotteryAPIProj| PickerView를 이용하여 원하는 날짜의 로또번호를 가지고 오는 과정을 학습|
|NetflixTrendMediaProj| TMDB API를 이용하여 Trend Media에 대한 정보를 보여주는 애플리케이션으로 기존에 배운것들에 더불어 TableViewCell을 커스텀, 위치 권한 설정, WebView등 다양한 기술들을 학습|
|OpenWeatherAPIProj| 위치권한 설정과 더불어 Alamofire와 OpenWeather API를 이용해 날씨 정보를 가지고 오는 과정을 학습|
|FilmPromotionComitteeAPIProj| 영화진흥원의 API를 이용, Realm을 이용하여 데이터를 저장하고 클라이언트에 보여주는 방법을 학습|
|KakaoOCR_API_Proj| Kakao API를 이용하여 OCR 결과를 테스트|
|Codable(+SnapKit)Proj| SnapKit과 Codable을 이용, beer API를 활용해 맥주 정보를 보여주는 애플리케이션 |

---

### 물마시기 프로젝트 
<details>
<summary>정리</summary>
<div markdown="1">       
  
  * Core Skills : **AutoLayout, UserDefaults**

  * AutoLayout을 이용해 UI를 구성 
  
   ![autolayout](https://user-images.githubusercontent.com/53691249/152910630-4bffa800-180c-4465-b5b5-ab7e45db8c99.png)
  
  * 유저의 닉네임, 키, 몸무게를 UserDefault를 이용해 저장하고 활용

  ```swift
  @IBAction func checkButtonAction(_ sender: UIBarButtonItem) {
      UserDefaults.standard.set(nickNameTextfield.text, forKey: "nickname")
      UserDefaults.standard.set(heightTextfield.text, forKey: "height")
      UserDefaults.standard.set(weightTextfield.text, forKey: "weight")
      UserDefaults.standard.set(intakeWater(),forKey: "intakewater")
      self.navigationController?.popViewController(animated: true)
  }
  ```

  * 초기화 및 물 마시기 버튼 클릭시 이벤트 설정

```swift
  
@IBAction func drinkWaterButtonAction(_ sender: UIButton) {
    howDrinkValue = howDrinkValue + Int(mlTextField.text!)!
    howDrinkLabel.text = String(howDrinkValue) + "ml"

    goalPercent = (howDrinkValue/10) / UserDefaults.standard.integer(forKey: "intakewater")
    goalLabel.text = "목표의 " + String(goalPercent) + "%"
    //이미지 선택
    pickImage(goalPercent)
    //텍스트 초기화
    mlTextField.text = ""
}
func pickImage(_ goalPercent : Int){

    if 0 <= goalPercent && goalPercent < 10 { myImageIdx = 0}
    else if 10 <= goalPercent && goalPercent < 20 { myImageIdx = 1}
    else if 20 <= goalPercent && goalPercent < 30 { myImageIdx = 2}
    else if 30 <= goalPercent && goalPercent < 40 { myImageIdx = 3}
    else if 40 <= goalPercent && goalPercent < 50 { myImageIdx = 4}
    else if 50 <= goalPercent && goalPercent < 60 { myImageIdx = 5}
    else if 60 <= goalPercent && goalPercent < 70 { myImageIdx = 6}
    else if 70 <= goalPercent && goalPercent < 80 { myImageIdx = 7}
    else {myImageIdx = 8}

    myPlantImageView.image = imageArray[myImageIdx]
    UserDefaults.standard.set(myImageIdx, forKey: "imageNumber")
}
  
```

* UITextField에서 Bottom에 라인을 주기위해 함수 정의
  * CALayer를 하나 생성하고 높이를 3으로 조정
  * 원하는 컬러를 지정하고 addSublayer 메소드를 이용해 기존의 TextField에 넣어주기


  ```swift
  func addBottomBorder(){
      let bottomLine = CALayer()
      bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 3, width: self.frame.size.width, height: 3)
      bottomLine.backgroundColor = UIColor.white.cgColor
      borderStyle = .none
      layer.addSublayer(bottomLine)
  }
  ```
 <div Align = center> 
   
 |영상|
|------|
|![물마시기프로젝트](https://user-images.githubusercontent.com/53691249/153128191-c010f47d-0336-4309-9ee5-36f01735cd98.gif)|
   
  </div>
</div>
</details>

----

### 테이블뷰 프로젝트 
<details>
<summary>정리</summary>
<div markdown="1">       
  
  * Core Skills : **AutoLayout,UITableViewController**

  * AutoLayout을 이용해 UI를 구성 
 
  |첫번 째|두번 째|
|:---:|:---:|
| ![Simulator Screen Shot - iPhone 12 - 2022-02-08 at 13 05 55](https://user-images.githubusercontent.com/53691249/152916562-59821324-db8f-4e3c-aa95-d034de27558d.png)|![Simulator Screen Shot - iPhone 12 - 2022-02-08 at 13 10 28](https://user-images.githubusercontent.com/53691249/152916675-20100749-9234-4f3d-9032-6a890f6a65b0.png)|

  
  * UITableViewController를 채택하여 생성
 
  * 테이블뷰에 넣기 위한 프로퍼티들을 만들기 

  ```swift
  var sectionTitle : [String] = ["전체 설정","개인 설정","기타"]
  var myTableList : [[String]] = [["공지사항","실험실","버전 정보"],["개인/보안","알림","채팅","멀티프로필"],["고객센터/도움말"]]
  var myTableListCount : [Int] = [3,4,1]
  ```

  * Section 및 Row의 개수 함수로 정의하기

  ```swift
   //Section 개수
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    //Section의 셀 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myTableListCount[section]
    } 
  ```

 * 각 셀들의 Configuration 부여

  ```swift
   //각각의 셀들
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell") else {
           return UITableViewCell()
       }

       if indexPath.section == 0 {
           cell.textLabel?.text = myTableList[0][indexPath.row]
           cell.textLabel?.font = .systemFont(ofSize: 15)
       } else if indexPath.section == 1{
           cell.textLabel?.text = myTableList[1][indexPath.row]
           cell.textLabel?.font = .systemFont(ofSize: 15)
       } else if indexPath.section == 2{
           cell.textLabel?.text = myTableList[2][indexPath.row]
           cell.textLabel?.font = .systemFont(ofSize: 15)
       }

       return cell
   }
  ```
</div>
</details>

----

### 환율 프로젝트 
<details>
<summary>정리</summary>
<div markdown="1">       
  
  * Core Skills : **AutoLayout,Property Observer: willSet/didSet, Computed Property: get/set**

  * AutoLayout을 이용해 UI를 구성 
 
  <div Align = center> 

  |구성|구동 영상|
|:---:|:---:|
|![스크린샷 2022-02-09 오후 2 24 04](https://user-images.githubusercontent.com/53691249/153128638-5530305f-8411-47d6-b20d-6bfb0fc8ea69.png)| ![환율프로젝트](https://user-images.githubusercontent.com/53691249/153129481-57261d7d-b719-408f-961f-e50373910108.gif)|
   
 </div>
     <br></br>
  * 프로퍼티 감시자 : willSet/didSet을 활용하여 입력받은 값에 의해 변화된 값을 감지

  ```swift
  var currencyRate : Double {
        willSet{
            outWillSetPrint = "환율이 변동 예정 : \(currencyRate) -> \(newValue)"
        }
        didSet{
            outDidSetPrint = "환율이 변동 완료 : \(oldValue) -> \(currencyRate)"
        }
    }
    var USD: Double{
        willSet{
            outUSDWillSetPrint = "환전금액 : \(newValue)달러로 환전될 예정"
        }
        didSet{
            outUSDDidSetPrint = "KRW: \(KRW)원 -> \(USD)달러로 환전될 예정"
        }
    }
  ```
    
  * 연산자 프로퍼티 : get/set을 활용하여 변화된 값을 다른 프로퍼티에 전달

  ```swift
  var WON : Double
    
  var KRW : Double {
      get {
          return WON
      }
      set {
          WON = newValue
      }
  }
  ```
</div>
</details>

----

### 쇼핑리스트 프로젝트 
<details open>
<summary>정리</summary>
<div markdown="1">       
  
  * Core Skills : **AutoLayout, AlertSheet, Zip, Realm, Custom Cell, 백업 및 복구**
  <br></br>
  * 핵심 구현 기능
     * 즐겨찾기와 할 일 완료 여부 버튼 
     * 쇼핑리스트 스와이프로 제거
     * ShoppingList 데이터를 Realm Database에 저장
     * 저장된 데이터를 가져와서 테이블뷰에 보여주기
     * ActionSheet를 통해 할 일 기준 정렬, 즐겨찾기 기준 정렬, 제목(한글 자음순) 기준 정렬
 <br></br>
  * Custom Cell : AutoLayout을 이용해 체크박스, 레이블, 즐겨찾기를 구성
     * 셀간의 간격을 주기 위해서 셀의 contentView.frame.inset에 top과 bottom에 값을 줌
 
         ```swift
         class ShoppingListTableViewCell: UITableViewCell {

          //버튼, 라벨
          @IBOutlet var checkBoxButton: UIButton!
          @IBOutlet var shopListLabel: UILabel!
          @IBOutlet var starButton: UIButton!

          override func awakeFromNib() {
              super.awakeFromNib()

          }
          override func setSelected(_ selected: Bool, animated: Bool) {
              super.setSelected(selected, animated: animated)

          }
          //오버라이딩 + 간격주기
          override func layoutSubviews() {
              super.layoutSubviews()
              contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0))
              contentView.layer.cornerRadius = 15
           }
         }
         ```  
     
   * Realm database에 저장하고 TableView에 보여주기
       * Realm Table 작성

           ```swift
           import RealmSwift

           class ShopList : Object{
               //체크박스 Bool
               @Persisted var checkClicked : Bool
               //즐겨찾기 박스 Bool
               @Persisted var starClicked : Bool
               //이름
               @Persisted var name : String
               //uuid
               @Persisted(primaryKey: true) var _id : ObjectId
               //초기화
               convenience init(name : String) {
                   self.init()
                   self.name = name
                   self.checkClicked = false
                   self.starClicked = false
               }
           }
           ```

        * 값 저장 및 테이블뷰에 보여주기

             ```swift
             let localRealm = try! Realm()
             var tasks : Results<ShopList>

             //중간생략

             override func viewDidLoad() {
               super.viewDidLoad()

              tasks = localRealm.objects(ShopList.self)
             }

             //중간생략
             
             //추가 버튼 클릭시
             @IBAction func addButtonClickedAction(_ sender: UIButton) {
                 guard let text = addShopListTextField.text else {
                     showAlert(title: "입력 안내", message: "쇼핑 리스트를 추가해주세요.", actionTitle: "확인")
                     return
                 }
                 if text.isEmpty {
                     showAlert(title: "오입력 안내", message: "입력이 되지 않았거나 잘못된 문자를 입력하셨습니다.", actionTitle: "확인")
                 } else {
                     let task  = ShopList(name: text)
                     try! localRealm.write{
                         localRealm.add(task)
                     }
                 }
                 addShopListTextField.text = ""
                 mainTableView.reloadData()
             }
             ```
             
        * 버튼 클릭시 값을 realm에서 값 변환 이후 셀에서 이미지 주기
        
             ```swift
             tasks[indexPath.row].starClicked  == true ? cell.starButton.setImage(StarredImage, for: .normal) :
             cell.starButton.setImage(unStarredImage,for:.normal)
        
             tasks[indexPath.row].checkClicked == true ? cell.checkBoxButton.setImage(checkedImage, for: .normal) : 
             cell.checkBoxButton.setImage(unCheckedImage,for:.normal)
             
             ```
             
        * 셀의 스와이프 기능을 true로 설정한 이후 제거시 realm에서 제거 및 tableview reload

             ```swift
             // 셀의 스와이프 스타일
              override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
              if editingStyle == .delete{
               do{
                 try localRealm.write{
                   localRealm.delete(tasks[indexPath.row])
                   }
                 } catch {
                     print("Delete Fail")
                 }
               }
               mainTableView.reloadData()
             }
             //셀 스와이프 ON/OFF 기능
             override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {

             return true
             }
             ```
        * alertSheet에서 받아온 프로퍼티의 값을 기준으로 할일, 즐찾기, 제목 별로 realm 데이터를 filter 처리

             ```swift
             func alertHandler(name : String){
                switch name {
                case "할일":
                    tasks = localRealm.objects(ShopList.self).sorted(byKeyPath: "checkClicked", ascending: false).filter("checkClicked == true")
                case "즐겨찾기":
                    tasks = localRealm.objects(ShopList.self).sorted(byKeyPath: "starClicked", ascending: false).filter("starClicked == true")
                case "제목":
                    tasks = localRealm.objects(ShopList.self).sorted(byKeyPath: "name", ascending: true)
                default:
                    print("Nothing")
                }
                self.mainTableView.reloadData()
             }
             ```
             
        * 백업 및 복구
          * 백업

            1️⃣ 데이터가 저장된 document의 위치를 찾기
              ```swift
              //Document 폴더 위치를 가지고 오는 함수
              func documentDirectoryPath()->String?{
              
                  let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
                  let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
                  let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
                  if let directoryPath = path.first {
                      return directoryPath
                  } else {
                      return nil
                  }
              }
              ```
            2️⃣ 백업하고자 하는 주소(default.realm)를 추가한 이후 파일이 존재한다면 백업을 실행 그렇지 않은 경우는 Alert
               ```swift
              //유효한 주소인지 확인 그렇지 않으면 Alert
              if let path = documentDirectoryPath(){
                
                let realm = (path as NSString).appendingPathComponent("default.realm")
                
                if FileManager.default.fileExists(atPath: realm){
                
                    urlPath.append(URL(string: realm)!)

                } else {
                    showAlert(title: "백업", message: "백업할 데이터가 없습니다!", actionTitle: "확인")
                }
              }
              ```

            3️⃣ 압축
              ```swift
              // Zip을 활용해 압축 / 실패시 Alert
              do {
            
              let zipFilePath = try Zip.quickZipFiles(urlPath, fileName: "ShopList")
              print("압축 경로: \(zipFilePath)")
            
              presentActivityViewController()
              }
              catch {
                  showAlert(title: "오류 안내", message: "압축에 실패했습니다.", actionTitle: "확인")
              }
              ```
            4️⃣ 백업완료
            
          * 복구

            1️⃣ 가장 먼저 아이폰의 파일에 접근하기 위해 MobileCoreService를 import해야 한다.
            
            2️⃣ UIDocumentPickerDelegate 채택
            
            3️⃣ 경로를 가지고 온 이후 압축해제 없다면 Alert / Zip을 사용
            
             ```swift
             try Zip.unzipFile(fileURL, destination: documentDirectory, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile : \(unzippedFile)")
                })
                let alert = UIAlertController(title: "재시작", message: "복구된 파일을 확인하기 위해 어플을 종료후 재시작해야합니다.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default,handler: { out in
                    exit(0)
                }))
             ```
             
            4️⃣ 복구완료!
<br></br>
  ---
  
  <div align = center>
 
  |추가 및 삭제|필터링|백업 및 복구|
|:---:|:---:|:---:|
|![추가및삭제](https://user-images.githubusercontent.com/53691249/153143036-39fef717-6b48-4903-8ab0-851b3fd83ca0.gif)|![정렬](https://user-images.githubusercontent.com/53691249/153143038-f6b9866d-a2c9-421f-b98c-e972feee2375.gif)|![백업복구](https://user-images.githubusercontent.com/53691249/153143015-b8fa60d7-f4b0-4f95-b4c8-0321511960e3.gif)|
 
</div>

</div>
</details>

----

### 복권 프로젝트
<details>
<summary>정리</summary>
<div markdown="1">       
  
  * Core Skills : **AutoLayout, Alamofire, UIPickerView**

  * AutoLayout을 이용해 UI를 구성 
 
  * Alamofire를 이용하여 역대 복권 당첨내역을 확인

   ```swift
   AF.request(url, method: .get).validate().responseJSON { response in 
             switch response.result {
             case .success(let value):
                 let json = JSON(value)

                 let date = json["drwNoDate"].stringValue
                 self.dateLabel.text = date + " 추첨"

                 self.luckyNumbers = []
                 for item in self.drwNumbersString {
                     self.luckyNumbers.append( json[item].stringValue)
                 }
                //중략
   case .failure(let error):
                 print(error)
             }
   ```
 
   * UIPickerViewDelegate와 UIPickerViewDataSource를 이용하여 데이터를 넣어주고 화면에 보여주기
 
   * Extension을 사용
 
   ```swift
   extension ViewController : UIPickerViewDelegate,UIPickerViewDataSource{
     //column
     func numberOfComponents(in pickerView: UIPickerView) -> Int {
         return 1
     }
     //column의 개수
     func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         //데이터를 표시할 수 있는 로또의 회차수를 받아오기
         return episodeList.count
     }
     //title
     func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         return String(episodeList[row])
     }
     func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         inputNumberTextField.text = String(episodeList[row])
         getLotteryNumbers(episodeNumber: episodeList[row])
      }
   }
   ```
 ---
### UI 및 구동영상
 
<div Align = center> 

  |구성|구동 영상|
|:---:|:---:|
|![스크린샷 2022-02-10 오후 4 20 36](https://user-images.githubusercontent.com/53691249/153358365-81848b53-1a80-405f-8b9a-36ac0b82700e.png)|![복권](https://user-images.githubusercontent.com/53691249/153358370-6a8656be-6e7e-46e7-8c78-488e9e9848b1.gif)|
   
 </div>
 
  </div>
</details>

----

### 트렌드미디어 프로젝트
<details open>
<summary>정리</summary>
<div markdown="1">       
  
  * Core Skills : **Pass data, WebView, MapView, CoreLocation, Annotation, TableView, CollectionView, Pagenation, TMDB API, NWPathMonitor, KingFisher, Alamofire, SwiftyJSONw**
 
  * AutoLayout을 이용해 UI를 구성 / Custom Cell
 
  * TMDB(The Movie Database)의 API를 이용하여 영화 및 드라마 정보(평점, 출연진, Youtube 링크 등)를 받아와 보여주는 애플리케이션
     * Map : MapView에 영화관 위치 정보를 보여주고 각각의 영화관들을 필터링
     * Alamofire : 받아온 JSON 데이터를 Image, String ...으로 변환후 TableView, CollectionView에 적용
 

 ## 메인
 ---
### APIManager Class 
 * TMDB와 API통신을 하고 전달받은 값을 @escaping 클로저를 통해 외부로 전달하기 위함
 
   ```swift
    class TMDBManager{
       static let shared = TMDBManager()
 
       ...
 
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
     }
   ```
### Pass Data 
 * 영화 정보를 클릭할 시에 상세정보창으로 Push, 이때 해당 ViewController의 변수에 필요한 값들을 전달한 이후 화면에 보여준다.
 
   ```swift
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //스토리보드 + viewController 특정
        let myStoryboard = UIStoryboard(name: "Main", bundle: nil)
       
        let vc = myStoryboard.instantiateViewController(withIdentifier: "peopleStoryboard") as! mediaPeopleViewControllViewController
        //Poster
        vc.posterName = myMediaList[indexPath.row].poster
        //BackDrop
        vc.headerImageName = myMediaList[indexPath.row].backDrop
        //Title
        vc.titleName = myMediaList[indexPath.row].title
        //Overview
        vc.summary = myMediaList[indexPath.row].overview
        //id
        vc.movie_id = myMediaList[indexPath.row].id
 
        //PUSH
        self.navigationController?.pushViewController(vc, animated: true)        
    }
   ```
 ### Kingfisher 라이브러리를 이용하여 전달받은 URL로부터 이미지 바로 세팅하기
   * Kingfisher는 url로 부터 이미지를 가지고오는 기능뿐 아니라 이를 디스크 혹은 메모리 캐시에 저장하여 주기 떄문에 최초 이후에는 처리가 더 빨라진다
 
     ```swift
     //기존의 이미지를 세팅하는 방법
     let url = URL(string: "")
     do {
         let data = try Data(contentsOf: url!)
         cell.postImageView.image = UIImage(data: data)
     } catch {
          print("이미지를 가지고 올 수 없음")
     }
     // BUT!!!! Kingfisher를 이용한다면
     cell.postImageView.setImage(imageUrl: "")
     ```
 ### WebView 사용하기
   * 해당 이미지뷰 상단의 링크 버튼을 누르면 Youtube로 이동하고 예고편을 자동으로 재생하는 기능
   * API 통신을 통해 받아온 링크를 WebView를 가지고 있는 ViewController에 넘겨주기
 
   ```swift
         ytUrl = "https://api.themoviedb.org/3/movie/\(myMediaList[sender.tag].id)/videos?api_key=\(APIDocs.TMDB_KEY)&language=en-US"
        
        AF.request(self.ytUrl, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.link = "https://www.youtube.com/watch?v=" + json["results"][0]["key"].stringValue
            case .failure(let error):
                print(error)
            }
          //링크 전달
          viewController.myLink = self.link
   ```
## 상세 정보
 ---
 ### UILabel과 상세보기 버튼
   * UILabel의 numberOfLines를 활용하여 애니메이션 효과 주기
 
     ```swift    
      // tableView의 0번 인덱스의 0번 째 셀을 reload 해주고
      @objc func arrowButtonClicked (selectedButton : UIButton){
         clicked.toggle()
         peopleTableView.reloadRows(at: [IndexPath(item: 0, section: 0)], with: .fade)
      }
      // numberOfLines를 0 / 2(으)로 변환
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        ...
        clicked == true ? (cell.summaryLabel.numberOfLines = 0) : (cell.summaryLabel.numberOfLines = 2)
      }
     ```
## 영화관 정보
 ---
 ### 선택한 영화관만 보여주기
   * 버튼 메뉴를 통해 해당 버튼의 타입을 파라미터로 전달하고 매칭
 
     ```swift    
      // 1. 모든 annotation 삭제
      let allAnnotations = self.mapView.annotations
      self.mapView.removeAnnotations(allAnnotations)

      // 2. 지정해둔 type프로퍼티에 접근해 매개변수로 들어온 which와 비교 후 같은 것만 지도에 annotation
      if mapAnnotations[i].type == which{

         let location = CLLocationCoordinate2D(latitude: mapAnnotations[i].latitude, longitude: mapAnnotations[i].longitude)
         let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
         let region = MKCoordinateRegion(center: location, span: span)

         mapView.setRegion(region, animated: true)

         let annotation = MKPointAnnotation()
         annotation.title = mapAnnotations[i].location
         annotation.coordinate = location

         mapView.addAnnotation(annotation)
      }
     ```
 ## 나의 미디어
 ---
 ### 컬렉션뷰를 사용하여 간략하게 정보를 볼 수 있게 만든 ViewController
   * XIB를 사용해 Custom Cell 등록
 
      ```swift   
         //XIB파일 연결
        let nibName = UINib(nibName: bookCollectionViewCell.identifier, bundle: nil)
        bookCollectionView.register(nibName, forCellWithReuseIdentifier: bookCollectionViewCell.identifier)
 
      ```  
## 구동 영상
 ---
 ### 각 기능별로 구동되는 영상
 
  <div Align = center>
   
   |메인|지도|나의 미디어|검색|
   |:---:|:---:|:---:|:---:|
   |![메인](https://user-images.githubusercontent.com/53691249/153407031-cc6a59df-ca81-4774-959e-050df1fac27d.gif)|![지도](https://user-images.githubusercontent.com/53691249/153407060-2ae99cd4-2f04-4a5a-89a1-26e0aa0ee245.gif)|![마이미디어](https://user-images.githubusercontent.com/53691249/153407067-f32ecbd5-de5c-4c01-b64d-eb5adf1e91cf.gif)|![검색](https://user-images.githubusercontent.com/53691249/153407071-c626536f-f477-40c8-8bce-21dd61fe566c.gif)|
   
   </div>
  </div>
</details>

----

### 오픈웨더 프로젝트
<details>
<summary>정리</summary>
<div markdown="1">       
  
  * Core Skills : **AutoLayout, Alamofire, Kingfisher, SwiftyJSON**

  * AutoLayout을 이용해 UI를 구성
 
  * 위치정보와 OpenWeatherAPI를 활용해 해당지역의 날씨상태를 보여주는 간단한 애플리케이션  
  
  * APIManager를 싱글톤 패턴을 활용하여 OpenWeatherAPI 사용

  ```swift
   class OpenWeatherAPIManager {
       static let shared = OpenWeatherAPIManager()
 
       ...
 
       func fetchData(result: @escaping (Int,JSON)->()) {

           let url = "https://api.openweathermap.org/data/2.5/weather?lat=37.550136619516515&lon=127.073179&appid=(KEY)"
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
  ```
 ---
### UI 및 구동영상
 
<div Align = center> 
   
|UI 구성|구동 영상|
|:---:|:---:|
 |![스크린샷 2022-02-11 오후 10 23 24](https://user-images.githubusercontent.com/53691249/153599012-252f47c7-abfc-487d-84cb-b4c89ea91c38.png)|![ezgif com-gif-maker](https://user-images.githubusercontent.com/53691249/153597411-324221a3-a534-4246-a065-7c08af25d57c.gif)|
   
  </div>
 
</div>
</details>

----

### 영화진흥위원회 프로젝트
<details>
<summary>정리</summary>
<div markdown="1">       
  
  * Core Skills : **AutoLayout, Alamofire, SwiftyJSON, Realm**

  * AutoLayout을 이용해 UI를 구성
 
  * 영화진흥위원회에서 제공하는 API를 이용해 검색한 일자에 대해 랭킹을 제공하는 애플리케이션
    * 이용자가 같은 날짜의 데이터를 조회할 수 있기때문에 Realm을 이용해 받아온 날짜의 데이터를 저장
    * 입력받은 날짜에 의해 TableView가 reload될 때, 이전에 저장했던 데이터 인지 확인하고 분기처리
  
  ### Realm
 
   ```swift
    class DailyMovie : Object{

       @Persisted var name : String

       @Persisted var date : String

       @Persisted var inputDate : String

       @Persisted(primaryKey: true) var movieId : ObjectId

       convenience init(name : String, date: String, inputDate : String){
           self.init()
           self.name = name
           self.date = date
           self.inputDate = inputDate
       }
   }
   ```
 
 ---
 
 ### 정규식
   * 영화진흥위원회 API의 경우, 지원하는 날짜가 2004년부터 이므로 입력받는 날짜에 대한 정규식이 필요
 
   ```swift
     let pattern : String = "^20([0-2])([4-9])([0-1])([0-9])([0-1])([0-9])$"
     var text : String
        
     //정규식 활용
     if let _ = dateTextfield.text?.range(of: pattern,options: .regularExpression) {
         text = dateTextfield.text!
     } else {
         showAlert(alertText: "날짜", alertMessege: "날짜를 잘못 입력하셨습니다.", alertTitle: "확인")
         dateTextfield.text = ""
     }
   ```
 ---
  ### Realm
   * 정보 조회시 Realm에 이미 해당 날짜의 데이터가 있는지 확인
 
   ```swift
     // 존재할 경우 TableView의 해당 데이터 reload
     if !localRealm.objects(DailyMovie.self).filter("inputDate == '\(text)'").isEmpty {
         newDate = text
         self.rankingTableView.reloadData()
     } else {
         // 존재하지 않는 경우 -> API 호출
         newDate = text
         fetchData(dates: newDate)
     }
   ```
 
   * 받아온 데이터 저장
 
   ```swift
    let title = json["boxOfficeResult"]["dailyBoxOfficeList"][item]["movieNm"].stringValue
    let date = json["boxOfficeResult"]["dailyBoxOfficeList"][item]["openDt"].stringValue
    let task = DailyMovie(name: title, date: date, inputDate: dates)
 
    try! self.localRealm.write{
        self.localRealm.add(task)
    }
  ```
 
  ---
### UI 및 구동영상
 
<div Align = center> 
   
|UI 구성|구동 영상|
|:---:|:---:|
 |![스크린샷 2022-02-11 오후 11 08 02](https://user-images.githubusercontent.com/53691249/153605996-1ca0c3b5-d704-4fb9-97c9-49235a6968cb.png)|![ezgif com-gif-maker](https://user-images.githubusercontent.com/53691249/153604990-20bd9f23-0f30-4ac9-bf38-38f14f3fb07a.gif)|
    
  </div>
 
</div>
</details>
