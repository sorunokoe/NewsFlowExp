//
//  News.swift
//  NewsFlow
//
//  Created by Yeskendir Salgara on 31.03.2022.
//

import Foundation

struct News: Decodable {
    
    var urlToImage: String?
    var title: String?
    var publishedAt: String?
    var content: String?
    var author: String?
    var source: NewsSource?
    
//    enum CodingKeys: CodingKey {
//        case title, url_to_image
//    }
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        urlToImage = try! container.decode(String.self, forKey: .url_to_image)
//        title = try! container.decode(String.self, forKey: .title)
//    }
    
}

struct NewsSource: Decodable {
    var name: String
}
