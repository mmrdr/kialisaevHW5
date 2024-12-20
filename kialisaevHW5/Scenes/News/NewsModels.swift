//
//  NewsModels.swift
//  kialisaevHW5
//
//  Created by Кирилл Исаев on 11.12.2024.
//

import UIKit

enum News {
    //MARK: - NewsModels
    struct Article: Decodable {
        var newsId: Int?
        var title: String?
        var announce: String?
        var img: ImageContainer?
        var requestId: String?
        var articleUrl: URL? {
            let requestId = requestId ?? ""
            let newsId = newsId ?? 0
            return URL(string: "https://news.myseldon.com/ru/news/index/\(newsId)?requestId=\(requestId)")
        }
    }
    
    struct ImageContainer: Decodable {
        var url: URL?
    }
    
    struct NewsPage: Decodable {
        var news: [Article]?
        var requestId: String?
        mutating func passTheRequestId() {
            for i in 0..<(news?.count ?? 0) {
                news?[i].requestId = requestId
            }
        }
    }
    
    enum RouteToWebNews {
        struct Request {
            let articleURL: URL?
        }
        struct Response {
            let articleURL: URL?
        }
    }
    
    enum ShareNews {
        struct Request {
            let newId: Int?
        }
        struct Response {
            let shareVC: UIActivityViewController
        }
    }
}
