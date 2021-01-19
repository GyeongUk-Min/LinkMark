//
//  AddViewController.swift
//  LinkMark
//
//  Created by Woogie on 2021/01/08.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet var urlAddItem: UITextField!
    @IBOutlet var nameAddItem: UITextField!
    @IBOutlet var btnAddItem: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        configui()
    }
    
    // done 버튼
    @IBAction func btnAddItemClicked(_ sender: UIButton) {
//        URLAddress.exampleLinkList.append(URLAddress(name: "\(nameAddItem.text)", url: "\(urlAddItem.text)"))
        guard let urltext = urlAddItem.text,
        urltext.count > 0 else {
            alert(message: "URL주소를 입력하세요")
            return
        }
        guard let nametext = nameAddItem.text,
              nametext.count > 0 else {
            alert(message: "저장할 이름을 입력하세요")
            return
        }
        
//        let newUrl = URLAddress.shared.urlList(name: nametext, address: urltext)
//        URLAddress.shared.urlList.append(newUrl)
        
        NotificationCenter.default.post(name: AddViewController.newUrlDidInsert, object: nil)
        
        dismiss(animated: true, completion: nil)
    }
    
    // cancel 버튼
    @IBAction func closeBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // 버튼 UI
    func configui() {
        btnAddItem.layer.cornerRadius = 15
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AddViewController {
    static let newUrlDidInsert = Notification.Name(rawValue: "newUrlDidInsert")
}
