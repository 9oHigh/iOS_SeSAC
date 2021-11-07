//
//  TableViewController.swift
//  ShoppingListProj
//
//  Created by 이경후 on 2021/10/13.
//

import UIKit
import RealmSwift
import SwiftUI
import JGProgressHUD
import Zip
import MobileCoreServices


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
    @IBOutlet weak var settingButton: UIButton!
    
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
        print("위치 :",localRealm.configuration.fileURL!)
    }
    //갱신용
    //MARK: super.viewWillAppear 반드시 하고 넘어가기
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainTableView.reloadData()
    }
    
    @IBAction func backupAndRestoreClicked(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "백업 및 복구", message: "백업/복구 당신의 선택은!", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "백업", style: .default, handler: { action in
            self.backUp()
        }))
        alert.addAction(UIAlertAction(title: "복구", style: .default, handler: { action in
            self.restore()
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func backUp(){
        /*
         1.도큐먼트 폴더 위치
         2.백업하고자하는 파일 확인
         3.백업
         */
        //4. 백업할 파일에 대한 URL 배열
        var urlPath = [URL]()
        
        //1. 도큐먼트 폴더 위치확인
        if let path = documentDirectoryPath(){
            //2. 백업하고자 하는 파일 URL확인
            //타입 캐스팅 반드시 해야함 + 이미지 같은 경우 백업 편의성을 위해 폴더안에 넣어두는 것이 유리
            let realm = (path as NSString).appendingPathComponent("default.realm")
            //3.백업하고자 하는 파일 존재 여부 확인
            if FileManager.default.fileExists(atPath: realm){
                //5. URL배열에 백업 파일 URL 추가하기
                urlPath.append(URL(string: realm)!)
                
            } else {
                showAlert(title: "백업", message: "백업할 데이터가 없습니다!", actionTitle: "확인")
            }
        }
        do {
            //6. 압축파일 만들기
            let zipFilePath = try Zip.quickZipFiles(urlPath, fileName: "ShopList")
            print("압축 경로: \(zipFilePath)")
            //압축파일 만들고 바로 공유할 수 있게 ( 드라이브 등등 )
            presentActivityViewController()
        }
        catch {
            print("Something went wrong")
        }
    }
    func restore(){
        //1. 파일앱 열기 + 확장자
        //import MobileCoreServices
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypeArchive as String], in: .import)
        
        documentPicker.delegate = self
        //여러개 선택 못하게 하는 메소드
        documentPicker.allowsMultipleSelection = false
        
        self.present(documentPicker,animated: true,completion: nil)
    }
    //Document 폴더 위치 가지고 오기
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
    //7.액티비티 뷰 컨트롤러 : 공유
    func presentActivityViewController(){
        //압축파일 경로 가지고오기
        let fileName = (documentDirectoryPath()! as NSString).appendingPathComponent("ShopList.zip")
        //경로 URL 저장
        let fileURL = URL(fileURLWithPath: fileName)
        
        let vc = UIActivityViewController(activityItems: [fileURL], applicationActivities: [])
        
        self.present(vc,animated: true,completion: nil)
    }
    //추가 버튼 클릭시
    @IBAction func addButtonClickedAction(_ sender: UIButton) {
        
        if let name = addShopListTextField.text {
            if name == "" {
                showAlert(title: "오입력 안내", message: "입력이 되지 않았거나 잘못된 문자를 입력하셨습니다.", actionTitle: "확인")
            } else {
                let task  = ShopList(name: name)
                try! localRealm.write{
                    localRealm.add(task)
                }
            }
        } else {
            showAlert(title: "오입력안내", message: "입력이 되지 않았거나 잘못된 문자를 입력하셨습니다.", actionTitle: "확인")
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
    
    @IBAction func settingButtonClicked(_ sender: UIButton) {
        let alert = UIAlertController(title: "정렬 기준", message: "어떤 순으로 정렬하시겠어요?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "할일", style: .default, handler: { action in
            self.alertHandler(name:action.title!)
        }))
        alert.addAction(UIAlertAction(title: "즐겨찾기", style: .default, handler: { action in
            self.alertHandler(name:action.title!)
        }))
        alert.addAction(UIAlertAction(title: "제목", style: .default, handler: { action in
            self.alertHandler(name:action.title!)
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
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
        cell.starButton.tag = indexPath.row
        cell.checkBoxButton.tag = indexPath.row
        
        tasks[indexPath.row].starClicked  == true ? cell.starButton.setImage(StarredImage, for: .normal) :cell.starButton.setImage(unStarredImage,for:.normal)
        
        tasks[indexPath.row].checkClicked == true ? cell.checkBoxButton.setImage(checkedImage, for: .normal) : cell.checkBoxButton.setImage(unCheckedImage,for:.normal)
        
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
extension TableViewController : UIDocumentPickerDelegate{
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function)
    }
    //복구 : 파일 선택
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print(#function)
        //2. 선택한 파일에 대한 경로를 가져와야한다.
        // iphone/jack/fileapp/archive.zip = selectedFileURL
        guard let selectedFileURL = urls.first else {return}
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let sandboxFileURL = directory.appendingPathComponent(selectedFileURL.lastPathComponent)
        //3. 압축 해제
        if FileManager.default.fileExists(atPath: sandboxFileURL.path){
            //기존에 복구하고자 하는 zip파일을 도큐먼트에 가지고 있을 경우, 도큐먼트에 위치한 zip을 압축해제하면 된다.
            do{
                let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                //지금 이 프로젝트만 항상 이름이 같음!!! 유의!!!
                let fileURL = documentDirectory.appendingPathComponent("ShopList.zip")
                try Zip.unzipFile(fileURL, destination: documentDirectory, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                    //복구완료 -> 메세지 얼럿
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile : \(unzippedFile)")
                })
                let alert = UIAlertController(title: "재시작", message: "복구된 파일을 확인하기 위해 어플을 종료후 재시작해야합니다.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default,handler: { out in
                    exit(0)
                }))
                                
                self.present(alert, animated: true, completion: nil)
            } catch {
                print("ERROR")
            }
        } else {
            //파일 앱의 zip-> 도큐먼트 폴더에 복사
            do{
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                //기존것과 동일
                let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                
                let fileURL = documentDirectory.appendingPathComponent("archive.zip")
                try Zip.unzipFile(fileURL, destination: documentDirectory, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                    
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile : \(unzippedFile)")
                })
                let alert = UIAlertController(title: "재시작", message: "복구된 파일을 확인하기 위해 어플을 종료후 재시작해야합니다.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default,handler: { out in
                    exit(0)
                }))
                                
                self.present(alert, animated: true, completion: nil)
            } catch{
                print("ERROR")
            }
        }
    }
}
extension TableViewController {
    func showAlert(title : String, message: String, actionTitle: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default, handler: nil)
        alert.addAction(action)
        
        present(alert,animated: true,completion: nil)
    }
}
