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
}

protocol NewsDataStore {
    var articles: [News.Article] {get set}
}

//MARK: - News presentation protocol
protocol NewsPresentationLogic {
    func presentNews()
}
