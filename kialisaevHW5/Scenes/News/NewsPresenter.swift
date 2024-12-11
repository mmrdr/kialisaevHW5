//
//  NewsPresenter.swift
//  kialisaevHW5
//
//  Created by Кирилл Исаев on 11.12.2024.
//

import UIKit

final class NewsPresenter: NewsPresentationLogic {

    weak var view: NewsViewController?
    
    func presentNews() {
        DispatchQueue.main.async {
            self.view?.articleTableView.reloadData()
            self.view?.refreshControl.endRefreshing()
        }
    }
    
    func routeToWebNews(_ response: News.RouteToWebNews.Response) {
        view?.navigationController?.pushViewController(
            WebNewsAssembly.build(with: response.articleURL), 
            animated: true)
    }
}
