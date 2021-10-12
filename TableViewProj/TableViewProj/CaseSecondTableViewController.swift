//
//  CaseSecondTableViewController.swift
//  TableViewProj
//
//  Created by 이경후 on 2021/10/12.
//

import UIKit

enum Sections : Int {
    case totalSetting,personalSetting,etc
}

class CaseSecondTableViewController: UITableViewController {
    
    var sectionTitle : [String] = ["전체 설정","개인 설정","기타"]
    var myTableList : [[String]] = [["공지사항","실험실","버전 정보"],["개인/보안","알림","채팅","멀티프로필"],["고객센터/도움말"]]
    var myTableListCount : [Int] = [3,4,1]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Section 개수
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    //Section의 셀 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myTableListCount[section]
    }
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
    //섹션 타이틀 부여
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return sectionTitle[section]
    }
    
    //헤더의 폰트를 조정하기 위한 함수
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionLabel = UILabel()
        sectionLabel.frame = CGRect(x: 20, y: 0, width: 320, height: 20)
        sectionLabel.font = UIFont.boldSystemFont(ofSize: 18)
        sectionLabel.text = sectionTitle[section]
        sectionLabel.textColor = .gray
        
        let headerView = UIView()
        headerView.addSubview(sectionLabel)
        
        return headerView
    }
}
