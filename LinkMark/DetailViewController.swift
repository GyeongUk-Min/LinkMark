//
//  ViewController.swift
//  LinkMark
//
//  Created by Woogie on 2021/01/06.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var openURLBtn: UIButton!
    @IBOutlet var urlAddress: UITextField!
    @IBOutlet var urlName: UITextField!
    @IBOutlet var urlEditBtn: UIBarButtonItem!
    var urlDetail: Favorite?
    var editBtnClicked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureTextField()
        configureTapGesture()
        openURLBtn.layer.cornerRadius = 20
        
        
        
    }
    
    // 버튼 터치 시 사파리로 접속
    @IBAction func openURLBtnClicked(_ sender: UIButton) {
        if let url = URL(string: "\(String(urlAddress.text!))") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    // url편집 기능
    @IBAction func urlEditItem(_ sender: UIBarButtonItem) {
        if (editBtnClicked) {
            self.navigationItem.rightBarButtonItem?.title = "Edit"
        } else {
            self.navigationItem.rightBarButtonItem?.title = "Done"
        }
        editBtnClicked = !editBtnClicked
    }
    
    // copy
    @IBAction func urlCopyBtn(_ sender: UIBarButtonItem) {
    }
    
    // 공유
    @IBAction func urlShareBtn(_ sender: UIBarButtonItem) {
    }
    
    // 삭제
    @IBAction func urlDelete(_ sender: UIBarButtonItem) {
    }
    
    // 텍스트 불러오기
    func configureTextField() {
        urlAddress.text = urlDetail?.address
        urlName.text = urlDetail?.name
        urlAddress.delegate = self
        urlName.delegate = self
    }
    
    // 빈 공간 터치 시 키보드 내리기
    func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func handleTap() {
        print("Handle tap was called")
        view.endEditing(true)
    }
    
    
}




extension DetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
