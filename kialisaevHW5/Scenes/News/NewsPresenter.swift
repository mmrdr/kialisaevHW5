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
        }
    }
}
