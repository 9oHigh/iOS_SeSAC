
### iOS App Programming with SeSAC 🧑🏻‍💻
　-︎ 배운것을 학습하고 적용하는 연습장 🔥
 
 ### 목차
 [1. 프로젝트 요약](#프로젝트-요약)
 
 [2. 물마시기 프로젝트](#물마시기-프로젝트)
 
 [3. 테이블뷰 프로젝트](#테이블뷰-프로젝트)
 
 [4. 환율 프로젝트](#환율-프로젝트)
 
 [5. 쇼핑 프로젝트](#쇼핑리스트-프로젝트)
 
 ---

### 프로젝트 요약
|프로젝트|설명|
|:---:|:---:|
|DrinkwaterProj| 물마시기 애플리케이션으로 UserDefaults를 이용하여 값을 저장하고 활용하는 방법을 학습|
|TableViewProj| UITableViewController를 이용해 TableView의 기초적인 사용방법을 학습|
|CurrencyRateProj| 간단한 환율 계산기 애플리케이션으로 didSet / willSet 그리고 get / set을 학습|
|ShoppingListProj| 쇼핑리스트를 작성할 수 있는 간단한 애플리케이션으로 백업 / 복구 / 공유 기능을 위해 Zip과 더불어 Realm, Custom Cell을 학습|
|OpenWeatherAPIProj| 위치권한 설정과 더불어 Alamofire와 OpenWeather API를 이용해 날씨 정보를 가지고 오는 과정을 학습|
|NetflixTrendMediaProj| TMDB API를 이용하여 Trend Media에 대한 정보를 보여주는 애플리케이션으로 기존에 배운것들에 더불어 TableViewCell을 커스텀, 위치 권한 설정, WebView등 다양한 기술들을 학습|
|LotteryAPIProj| PickerView를 이용하여 원하는 날짜의 로또번호를 가지고 오는 과정을 학습|
|KakaoOCR_API_Proj| Kakao API를 이용하여 OCR 결과를 테스트|
|FilmPromotionComitteeAPIProj| 영화진흥원의 API를 이용, Realm을 이용하여 데이터를 저장하고 클라이언트에 보여주는 방법을 학습|
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

### 쇼핑리스트 프로젝트 
<details>
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









