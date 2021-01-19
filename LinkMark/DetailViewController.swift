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
    @IBOutlet var editBtnItem: UIBarButtonItem!
    var urlDetail: Favorite?
    var barEditBtn = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureTextField()
        configureTapGesture()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        if #available(iOS 14.0, *) {
//            self.navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: nil, menu: menuItems())
//        } else {
//            // Fallback on earlier versions
//        }
//    }
    
//    func menuItems() -> UIMenu {
//        let addMenuItems = UIMenu(title: "", options: .displayInline, children: [
//
//            UIAction(title: "Copy", image: UIImage(systemName: <#T##String#>)) { (_) in
//                print("Copy")
//            }
//        ])
//    }
    
    func configureTextField() {
        urlAddress.text = urlDetail?.address
        urlName.text = urlDetail?.name
        urlAddress.delegate = self
        urlName.delegate = self
    }
    
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
