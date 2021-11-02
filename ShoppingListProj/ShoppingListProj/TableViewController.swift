//
//  TableViewController.swift
//  ShoppingListProj
//
//  Created by 이경후 on 2021/10/13.
//

import UIKit
import RealmSwift
import SwiftUI

class TableViewController: UITableViewController {
    
    
    let localRealm = try! Realm()
    var tasks : Results<ShopList>!
    
    let unCheckedImage = UIImage(systemName: "checkmark.square")
    let checkedImage = UIImage(systemName: "checkmark.square.fill")
    let unStarredImage = UIImage(systemName: "star")
    let StarredImage = UIImage(systemName: "star.fill")
    
    /* Userdefaults 코드
     var myShopList : [Bucket] = [] {
     didSet{
     saveData()
     }
     }
     */
    
    @IBOutlet var mainTableView: UITableView!
    @IBOutlet var addShopListTextField: UITextField!
    @IBOutlet var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addShopListTextField.placeholder = "무엇을 구매하실 예정인가요?"
        addShopListTextField.layer.cornerRadius = 10
        addShopListTextField.borderStyle = .none
        addShopListTextField.addLeftPadding()
        
        addButton.layer.cornerRadius = 10
        addButton.tintColor = .black
        //전체 데이터 가지고오기
        tasks = localRealm.objects(ShopList.self)
    }
    //갱신용
    override func viewWillAppear(_ animated: Bool) {
        mainTableView.reloadData()
    }
    //추가 버튼 클릭시
    @IBAction func addButtonClickedAction(_ sender: UIButton) {
        
        if let name = addShopListTextField.text {
            if name == "" {
                let alert = UIAlertController(title: "오입력 안내", message: "입력이 되지 않았거나 잘못된 문자를 입력하셨습니다.", preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(action)
                present(alert,animated: true,completion: nil)
            } else {
                let task  = ShopList(name: name)
                try! localRealm.write{
                    localRealm.add(task)
                }
            }
        } else {
            let alert = UIAlertController(title: "오입력 안내", message: "입력이 되지 않았거나 잘못된 문자를 입력하셨습니다.", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(action)
            present(alert,animated: true,completion: nil)
        }
        addShopListTextField.text = ""
        mainTableView.reloadData()
        /* Userdefaults 코드
         if let newList = addShopListTextField.text {
         // 입력된 텍스트가 있다면 구조체로 만들고 전체 쇼핑리스트에 추가
         if newList == "" {
         return
         }
         let inputList = Bucket(productName: newList, checkButton: 0, starButton: 0)
         myShopList.append(inputList)
         //디폴트
         addShopListTextField.text = .none
         addShopListTextField.placeholder = "무엇을 구매하실 예정인가요?"
         
         } else {
         print("새로운 리스트를 추가할 수 없음.")
         addShopListTextField.text = .none
         addShopListTextField.placeholder = "무엇을 구매하실 예정인가요?"
         }
         */
        
    }
    @IBAction func checkButtonClicked(_ sender: UIButton) {
        if sender.currentImage == unCheckedImage {
            sender.setImage(checkedImage, for: .normal)
            if let item = tasks?[sender.tag]{
                try! localRealm.write{
                    item.checkClicked = true
                }
            }
        } else {
            sender.setImage(unCheckedImage, for: .normal)
            if let item = tasks?[sender.tag]{
                try! localRealm.write{
                    item.checkClicked = false
                }
            }
        }
    }
    
    @IBAction func starButtonClicked(_ sender: UIButton) {
        if sender.currentImage == unStarredImage {
            sender.setImage(StarredImage, for: .normal)
            if let item = tasks?[sender.tag]{
                try! localRealm.write{
                    item.starClicked = true
                }
            }
        } else {
            sender.setImage(unStarredImage, for: .normal)
            if let item = tasks?[sender.tag]{
                try! localRealm.write{
                    item.starClicked = false
                }
            }
        }
    }
    /*
     func saveData(){
     Userdefaults 코드
     // myShopList에 넣을 inputList 생성
     var inputList : [[String:Any]] = []
     // 전체 리스트에서 하나씩 가져와서 넣어두자. -> UserDefaults로 넣어두자!
     for member in myShopList {
     let data : [ String: Any ] = [
     "productName" : member.productName,
     "checkButton" : member.checkButton,
     "starButton" : member.starButton
     ]
     inputList.append(data)
     }
     //유저 디폴트에 myShopList로 저장해두자.
     let userDefaults = UserDefaults.standard
     userDefaults.set(inputList,forKey: "myShopList")
     //리로드!
     tableView.reloadData()
     }
     
     func loadData(){
     Userdefaults 코드
     let userDefaults = UserDefaults.standard
     
     if let data = userDefaults.object(forKey: "myShopList") as? [[String : Any]]{
     var inputList = [Bucket]()
     
     for datum in data {
     guard let productName = datum["productName"] as? String else { return }
     guard let checkButton = datum["checkButton"] as? Int else { return }
     guard let starButton = datum["starButton"] as? Int else { return }
     
     inputList.append(Bucket(productName: productName, checkButton: checkButton, starButton: starButton))
     }
     self.myShopList = inputList
     }
     }
     */
    //섹션의 row 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Userdefaults 코드
        // return myShopList.count
        return tasks.count
    }
    
    //cell 조작
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingListTableViewCell", for: indexPath) as? ShoppingListTableViewCell else {
            return UITableViewCell()
        }
        /* Userdefaults 코드
         cell.shopListLabel.text = myShopList[indexPath.row].productName*/
        
        cell.shopListLabel.text = tasks[indexPath.row].name
        cell.tag = indexPath.row
        if tasks[indexPath.row].starClicked == true {
            cell.starButton.setImage(StarredImage, for: .normal)
        } else {
            cell.starButton.setImage(unStarredImage,for:.normal)
        }
        if tasks[indexPath.row].checkClicked == true {
            cell.checkBoxButton.setImage(checkedImage, for: .normal)
        } else {
            cell.checkBoxButton.setImage(unCheckedImage,for:.normal)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    //섹션과 상단의 뷰와의 거리 조정 -> 섹션간의 거리조정
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    // 셀의 스와이프 스타일
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        /* Userdeaults 코드
         // 딜리트 ? 해당 row 삭제
         if editingStyle == .delete {
         myShopList.remove(at: indexPath.row)
         }
         */
        if editingStyle == .delete{
            do{
                try localRealm.write{                    localRealm.delete(tasks[indexPath.row])
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
}
extension UITextField {
    func addLeftPadding(){
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.frame.height))
        self.leftView = padding
        self.leftViewMode = ViewMode.always
    }
}

