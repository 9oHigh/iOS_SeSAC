
### iOS App Programming with SeSAC 🧑🏻‍💻
　-︎ 배운것을 학습하고 적용하는 연습장 🔥
 
 ### 목차
 [1. 프로젝트 요약](#프로젝트-요약)
 
 [2. 물마시기 프로젝트](#물마시기-프로젝트)
 
 ---

### 프로젝트 요약
|프로젝트|설명|
|:---:|:---:|
|DrinkwaterProj| 물마시기 애플리케이션으로 UserDefaults를 이용하여 값을 저장하고 활용하는 방법을 학습|
|TableViewProj| UITableViewController를 이용해 TableView의 기초적인 사용방법을 학습|
|ShoppingListProj| 쇼핑리스트를 작성할 수 있는 간단한 애플리케이션으로 백업 / 복구 / 공유 기능도 추가적으로 학습 ( TableView 심화학습 )|
|OpenWeatherAPIProj| 위치권한 설정과 더불어 Alamofire와 OpenWeather API를 이용해 날씨 정보를 가지고 오는 과정을 학습|
|NetflixTrendMediaProj| TMDB API를 이용하여 Trend Media에 대한 정보를 보여주는 애플리케이션으로 기존에 배운것들에 더불어 TableViewCell을 커스텀, 위치 권한 설정, WebView등 다양한 기술들을 학습|
|LotteryAPIProj| PickerView를 이용하여 원하는 날짜의 로또번호를 가지고 오는 과정을 학습|
|KakaoOCR_API_Proj| Kakao API를 이용하여 OCR 결과를 테스트|
|FilmPromotionComitteeAPIProj| 영화진흥원의 API를 이용, Realm을 이용하여 데이터를 저장하고 클라이언트에 보여주는 방법을 학습|
|CurrencyRateProj| 간단한 환율 계산기 애플리케이션으로 didSet / willSet 그리고 get / set을 학습|
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
|![ezgif com-gif-maker](https://user-images.githubusercontent.com/53691249/152911340-4021e218-7798-43dd-bd4e-7c78b5ebfd51.gif)|
   
  </div>
</div>
</details>


