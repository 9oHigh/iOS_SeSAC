//
//  ViewController.swift
//  KakaoOCR_API_Proj
//
//  Created by 이경후 on 2021/10/27.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ocrImageView: UIImageView!
    @IBOutlet weak var outputTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func transportToTextClicked(_ sender: UIButton) {
        OCRManager.shared.fetchData(image: ocrImageView.image!) { code, json in
            let cnt = json["result"].count
            var answer : String = ""
            
            for item in 0...cnt-1 {
                answer = answer + json["result"][item]["recognition_words"][0].stringValue + " "
            }
            self.outputTextView.text = answer
            self.outputTextView.font = UIFont.boldSystemFont(ofSize: 15)
            self.outputTextView.textColor = .white
        }
    }
}

