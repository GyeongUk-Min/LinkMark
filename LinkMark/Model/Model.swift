//
//  Model.swift
//  LinkMark
//
//  Created by Woogie on 2021/01/07.
//

import Foundation

class URLAddress {
    var name: String
    var url: String
    
    init(name: String, url: String) {
        self.url = url
        self.name = name
    }
    
    static var exampleLinkList = [
        URLAddress(name: "Naver", url: "https://naver.com"),
        URLAddress(name: "Google", url: "https://google.com"),
        URLAddress(name: "Youtube", url: "https://youtube.com")
    ]
}
