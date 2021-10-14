//
//  TableViewController.swift
//  ShoppingListProj
//
//  Created by 이경후 on 2021/10/13.
//

import UIKit

class TableViewController: UITableViewController {
    
    var myShopList : [Bucket] = [] {
        didSet{
            saveData()
        }
    }
    
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
        
        loadData()
        
    }
    //추가 버튼 클릭시
    @IBAction func addButtonClickedAction(_ sender: UIButton) {
        
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
    }
    @IBAction func checkButtonClicked(_ sender: UIButton) {}
    
    @IBAction func starButtonClicked(_ sender: UIButton) {}
    
    func saveData(){
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
    
    //섹션의 row 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myShopList.count
    }
    
    //cell 조작
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingListTableViewCell", for: indexPath) as? ShoppingListTableViewCell else {
            return UITableViewCell()
        }
        cell.shopListLabel.text = myShopList[indexPath.row].productName
        
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
        // 딜리트 ? 해당 row 삭제
        if editingStyle == .delete {
            myShopList.remove(at: indexPath.row)
        }
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
