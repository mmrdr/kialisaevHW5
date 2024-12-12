//
//  NewsProtocols.swift
//  kialisaevHW5
//
//  Created by Кирилл Исаев on 11.12.2024.
//

import UIKit

//MARK: - News business protocol
protocol NewsBusinessLogic {
    func loadFreshNews()
    func loadMoreNews()
    func routeToWebNews(_ request: News.RouteToWebNews.Request)
    func createViewForNewsShare(_ request: News.ShareNews.Request)
}

protocol NewsDataStore {
    var articles: [News.Article] {get set}
}

//MARK: - News presentation protocol
protocol NewsPresentationLogic {
    func presentNews()
    func routeToWebNews(_ response: News.RouteToWebNews.Response)
    func showShareMenu(_ response: News.ShareNews.Response)
}
