//
//  QuickSearchViewController.swift
//  LinkMark
//
//  Created by Woogie on 2021/02/25.
//

import UIKit

class QuickSearchViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var searchNaver: UITextField!
    @IBOutlet var searchGoogle: UITextField!
    @IBOutlet var searchYoutube: UITextField!
    @IBOutlet var searchGoogleImage: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldSetting()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillhide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y = -150 // 뷰의 Y축을 150 만큼 올림
    }
    
    @objc func keyboardWillhide(_ sender: Notification) {
        self.view.frame.origin.y = 0 // 뷰를 원래 위치로 되돌림
    }
    
    // textField 키보드 셋팅
    func textFieldSetting() {
        self.searchNaver.keyboardType = .default
        self.searchGoogle.keyboardType = .default
        self.searchYoutube.keyboardType = .default
        self.searchGoogleImage.keyboardType = .default
        self.searchNaver.delegate = self
        self.searchGoogle.delegate = self
        self.searchYoutube.delegate = self
        self.searchGoogleImage.delegate = self
//        self.searchNaver.returnKeyType
    }
    
    // return 키
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // 빈 공간 터치 시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    
    // MARK: - Quick Search
    
    // 네이버 검색
    @IBAction func searchNaverBtn(_ sender: UIButton) {
        view.endEditing(true)
        if searchNaver.text != "" {
            let search = "https://search.naver.com/search.naver?query=" + searchNaver.text!
            let encodedSearchURL = search.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            if let searchURL = URL(string: encodedSearchURL) {
                UIApplication.shared.open(searchURL as URL, options: [:], completionHandler: nil)
            }
        }
        searchNaver.text = ""
        print(#function)
    }
    
    // 구글 검색
    @IBAction func searchGoogleBtn(_ sender: UIButton) {
        view.endEditing(true)
        if searchGoogle.text != "" {
            let search = "https://www.google.com/search?q=" + searchGoogle.text!
            let encodedSearchURL = search.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            if let searchURL = URL(string: encodedSearchURL) {
                UIApplication.shared.open(searchURL as URL, options: [:], completionHandler: nil)
            }
        }
        searchGoogle.text = ""
        print(#function)
    }
    
    // 유튜브 검색
    @IBAction func searchYoutubeBtn(_ sender: UIButton) {
        view.endEditing(true)
        if searchYoutube.text != "" {
            let search = "https://www.youtube.com/results?search_query=" + searchYoutube.text!
            let encodedSearchURL = search.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            if let searchURL = URL(string: encodedSearchURL) {
                UIApplication.shared.open(searchURL as URL, options: [:], completionHandler: nil)
            }
        }
        searchYoutube.text = ""
        print(#function)
    }
    
    // 구글 이미지 검색
    @IBAction func searchGoogleImageBtn(_ sender: UIButton) {
        view.endEditing(true)
        if searchGoogleImage.text != "" {
            let search = "https://www.google.com/search?&tbm=isch&q=" + searchGoogleImage.text!
            let encodedSearchURL = search.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            if let searchURL = URL(string: encodedSearchURL) {
                UIApplication.shared.open(searchURL as URL, options: [:], completionHandler: nil)
            }
        }
        searchGoogleImage.text = ""
        print(#function)
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
