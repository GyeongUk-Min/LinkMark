//
//  UrlListTableViewController.swift
//  LinkMark
//
//  Created by Woogie on 2021/01/07.
//
import Foundation
import UIKit
import CoreData
import SafariServices

class UrlListTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet var tvListView: UITableView!
    @IBOutlet var URLSearchBar: UISearchBar!
    
    var filteredData: NSFetchRequest<Favorite> = Favorite.fetchRequest()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //배열을 데이터로 채움
        URLAddress.shared.startFetchURL()
        tableView.reloadData()
        
        print(#function)
    }
    
    // 빈 공간 터치시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // 옵저버 생성
    var token: NSObjectProtocol?
    deinit {
        if let token = token {
            NotificationCenter.default.removeObserver(token)
        }
    }
    
    // segue가 연결된 화면을 생성 및 화면 전환 직전에 호출
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
            if let vc = segue.destination as? DetailViewController {
                vc.urlDetail = URLAddress.shared.urlList[indexPath.row]
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        // 테이블 구분 줄 없애기
        tvListView.separatorStyle = UITableViewCell.SeparatorStyle.none
        // setup delegates
        tvListView.delegate = self
        tvListView.dataSource = self
        URLSearchBar.delegate = self
        // addViewController에서 url save시 leload 옵저버 생성
        token = NotificationCenter.default.addObserver(forName: AddViewController.newUrlDidInsert, object: nil, queue: OperationQueue.main) { [weak self] (noti) in
            self?.tableView.reloadData()
        }
    }
    
    
    
    // MARK: - search
    
    // 서치바 실시간 검색
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            URLAddress.shared.fetchURL()
            tableView.reloadData()
            return
        }
        URLAddress.shared.fetchURL(searchText)
        tableView.reloadData()
        print(#function)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        URLAddress.shared.fetchURL()
        tableView.reloadData()
        view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }

    //테이블 뷰 Detail Disclosure 버튼 구현
//    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
//
//    }
    
    //테이블 뷰 로드하기
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        if URLSearchBar.text == "" {
//            return URLAddress.shared.urlList.count
//        } else {
            return URLAddress.shared.urlList.count
//        }
    }

    //셀 수만큼 로드하기
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "linkList", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = URLAddress.shared.urlList[indexPath.row].name
        cell.detailTextLabel?.text = URLAddress.shared.urlList[indexPath.row].address
        
        // 검색어 텍스트 색상 변경
//        if URLSearchBar.text != nil {
//            let attString = NSMutableAttributedString(string: URLSearchBar.text!)
//            let range: NSRange = (URLSearchBar.text! as NSString).range(of: URLSearchBar.text!, options: .caseInsensitive)
//            attString.addAttribute(.foregroundColor, value: UIColor.blue, range: range)
//            cell.textLabel?.text = URLAddress.shared.urlList[indexPath.row].name
//        }

        return cell
    }


//    // Override to support conditional editing of the table view.
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//
//        return true
//    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let alert = UIAlertController(title: "확인", message: "삭제할까요?", preferredStyle: .alert)
            
            let removeAction = UIAlertAction(title: "삭제", style: .destructive) { (action) in
                let target = URLAddress.shared.urlList[indexPath.row]
                URLAddress.shared.deleteUrl(target)
                URLAddress.shared.urlList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
            }
            alert.addAction(removeAction)
            
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            
            present(alert, animated: true, completion: nil)
        }
        else if editingStyle == .none {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // 편집 후 목록 자리 바꾸기
    // Override to support rearranging the table view.
//    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
//        let urlToMove = URLAddress.shared.urlList[(fromIndexPath as NSIndexPath).row]
//        URLAddress.shared.urlList.remove(at: (fromIndexPath as NSIndexPath).row)
//        URLAddress.shared.urlList.insert(urlToMove, at: (to as NSIndexPath).row)
//        URLAddress.shared.saveContext()
//    }
    
    
    // 테이블 셀 터치시 링크 접속
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = String(URLAddress.shared.urlList[indexPath.row].address!)
        let encodedURL = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        if let myURL = URL(string: encodedURL) {
            UIApplication.shared.open(myURL as URL, options: [:], completionHandler: nil)
        }
        print(#function)
    }
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
