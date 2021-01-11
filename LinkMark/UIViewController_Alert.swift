//
//  ComposeViewController.swift
//  LinkMark
//
//  Created by Woogie on 2021/01/08.
//


import UIKit

extension UIViewController {
    func alert(title: String = "알림", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
}

//extension UITableViewController {
//    func alert(title: String = "알림", message: String) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//
//        let removeAction = UIAlertAction(title: "삭제", style: .destructive)
//        alert.addAction(removeAction)
//        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
//        alert.addAction(cancelAction)
//
//        present(alert, animated: true, completion: nil)
//    }
//}
