//
//  NewsInteractor.swift
//  kialisaevHW5
//
//  Created by Кирилл Исаев on 11.12.2024.
//

import UIKit

final class NewsInteractor: NewsBusinessLogic, NewsDataStore {
    //MARK: - Variables
    private var presenter: NewsPresentationLogic
    private var worker = NewsWorker()
    var articles: [News.Article] = [] {
        didSet {
            presenter.presentNews()
        }
    }
    
    //MARK: - Lifecycle
    init(presenter: NewsPresentationLogic) {
        self.presenter = presenter
    }
    
    //MARK: - Public methods
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
    
    func createViewForNewsShare(_ request: News.ShareNews.Request) {
        let textToShare = "Привет! Это пример использования меню 'Поделиться'."
        let urlToShare = URL(string: "https://news.myseldon.com/ru/news/index/\(request.newId!)")
        let itemsToShare: [Any] = [textToShare, urlToShare ?? []]
        let activityVC = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
        presenter.showShareMenu(News.ShareNews.Response(shareVC: activityVC))
    }
}
