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
        
        // Do any additional setup after loading the view.
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
    }
    
    // return 키
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
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
