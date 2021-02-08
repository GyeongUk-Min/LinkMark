//
//  ViewController.swift
//  LinkMark
//
//  Created by Woogie on 2021/01/06.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var urlAddress: UITextField!
    @IBOutlet var urlName: UITextField!
    @IBOutlet var saveBtn: UIButton!
    
    var urlDetail: Favorite?
    var editBtnClicked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureTextField()
        configureTapGesture()
        saveBtn.layer.cornerRadius = 20
    }
    
    // url 수정 (
    @IBAction func saveBtnClicked(_ sender: UIButton) {
        
        // 비교
        let editUrlDetailAddress = urlAddress.text
        let editUrlDetailName = urlName.text
        
        guard editUrlDetailName!.count > 0 else {
            alert(message: "주소를 입력하세요")
            return
        }
        guard editUrlDetailAddress!.count > 0 else {
            alert(message: "이름을 입력하세요")
            return
        }
        
        // 값이 다를경우 수정본으로 덮어쓰기
        if editUrlDetailAddress != urlDetail?.address || editUrlDetailName != urlDetail?.name {
            urlDetail?.address = editUrlDetailAddress
            urlDetail?.name = editUrlDetailName
            URLAddress.shared.saveContext()
        }
        
        view.endEditing(true)
        print(#function)
    }
    
    
    // copy
    @IBAction func urlCopyBtn(_ sender: UIBarButtonItem) {
        UIPasteboard.general.string = urlAddress.text
        alert(message: "클립보드에 복사되었습니다")
        print(#function)
    }
    
    // 삭제
    @IBAction func urlDelete(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "알림", message: "삭제할까요?", preferredStyle: .alert)
        let removeAction = UIAlertAction(title: "삭제", style: .destructive) { [weak self] (action) in
            print(#function)
            URLAddress.shared.deleteUrl(self?.urlDetail)
            self?.navigationController?.popViewController(animated: true)
        }
        alert.addAction(removeAction)
    
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
        
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
