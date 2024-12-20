//
//  NewsPresenter.swift
//  kialisaevHW5
//
//  Created by Кирилл Исаев on 11.12.2024.
//

import UIKit

final class NewsPresenter: NewsPresentationLogic {
    //MARK: - Variables
    weak var view: NewsViewController?
    
    //MARK: - Public methods
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
    
    func showShareMenu(_ response: News.ShareNews.Response) {
        view?.present(response.shareVC, animated: true)
    }
}
