//
//  NewsInteractor.swift
//  kialisaevHW5
//
//  Created by Кирилл Исаев on 11.12.2024.
//

import UIKit

final class NewsInteractor: NewsBusinessLogic, NewsDataStore {

    private var presenter: NewsPresentationLogic
    private var worker = NewsWorker()
    
    init(presenter: NewsPresentationLogic) {
        self.presenter = presenter
    }
    
    var articles: [News.Article] = [] {
        didSet {
            presenter.presentNews()
        }
    }
    
    func routeToWebNews(_ request: News.RouteToWebNews.Request) {
        presenter.routeToWebNews(
            News.RouteToWebNews.Response(
                articleURL: request.articleURL)
        )
    }
    
    func loadFreshNews() {
        worker.fetchNews { [weak self] result in
            switch result {
            case .success(let newsPage):
                self?.articles = newsPage.news ?? []
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadMoreNews() {
        worker.fetchNews { [weak self] result in
            switch result {
            case .success(let newsPage):
                self?.articles += newsPage.news ?? []
            case .failure(let error):
                print(error)
            }
        }
    }
}
