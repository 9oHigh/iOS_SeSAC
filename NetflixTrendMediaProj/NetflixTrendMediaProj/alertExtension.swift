//
// alertExtension.swift
//
//  Created by 이경후 on 2021/10/25.
//

import UIKit

extension UIViewController {
    
    
    func showAlert(title: String, message: String, okTitle : String, okAction : @escaping ()->()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        // 클로저!!
        let ok = UIAlertAction(title: okTitle, style: .default) { _ in
            
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: true) {
        }
    }
    
}

