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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        urlAddItem.becomeFirstResponder()
        nameAddItem.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        urlAddItem.resignFirstResponder()
        nameAddItem.resignFirstResponder()
    }
    @IBAction func keyboardDownBtn(_ sender: UIButton) {
        urlAddItem.resignFirstResponder()
        nameAddItem.resignFirstResponder()
    }
    
    // done 버튼
    @IBAction func btnAddItemClicked(_ sender: UIButton) {

        // url 공란 확인
        guard let urltext = urlAddItem.text,
        urltext.count > 0 else {
            alert(message: "URL주소를 입력하세요")
            return
        }
        
        // nickname 공란 확인
        guard let nametext = nameAddItem.text,
              nametext.count > 0 else {
            alert(message: "저장할 이름을 입력하세요")
            return
        }
        
        // 저장 시 (https://)프로토콜 확인, 누락 된 경우 삽입
        let addressCheck = urlAddItem.text!.hasPrefix("https://")
        if !addressCheck {
            urlAddItem.text = "https://" + urlAddItem.text!
        }
        
        URLAddress.shared.addUrl(urlAddItem.text, nameAddItem.text)
//        let newUrl = URLAddress.shared.urlList(name: nametext, address: urltext)
//        URLAddress.shared.urlList.append(newUrl)
        
        NotificationCenter.default.post(name: AddViewController.newUrlDidInsert, object: nil)
        
        print(#function)
        
        dismiss(animated: true, completion: nil)
    }
    
    // cancel 버튼
    @IBAction func closeBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // 버튼 UI
    func configui() {
        btnAddItem.layer.cornerRadius = 20
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

extension AddViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
