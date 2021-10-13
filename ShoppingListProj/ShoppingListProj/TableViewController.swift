//
//  TableViewController.swift
//  ShoppingListProj
//
//  Created by 이경후 on 2021/10/13.
//

import UIKit

class TableViewController: UITableViewController {
    
    var myShopList = ["쌀 1kg","삼겹살 2근","쌈장","상추","맥주"] {
        didSet{
            tableView.reloadData()
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
        cell.shopListLabel.text = myShopList[indexPath.row]
        cell.layer.cornerRadius = 10

        return cell
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
    
    @IBAction func addButtonClickedAction(_ sender: UIButton) {
        if let newList = addShopListTextField.text {
            myShopList.append(newList)
            addShopListTextField.text = .none
            addShopListTextField.placeholder = "무엇을 구매하실 예정인가요?"

        } else {
            print("새로운 리스트를 추가할 수 없음.")
        }
    }
}
extension UITextField {
    func addLeftPadding(){
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.frame.height))
        self.leftView = padding
        self.leftViewMode = ViewMode.always
    }
}
