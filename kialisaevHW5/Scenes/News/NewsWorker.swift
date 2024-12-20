//
//  NewsWorker.swift
//  kialisaevHW5
//
//  Created by Кирилл Исаев on 11.12.2024.
//

import UIKit

final class NewsWorker {
    //MARK: - Errors
    enum URLError: Error {
        case invalidRequest
    }
    
    //MARK: - Constants
    enum Constants {
        static let rubricNumber: Int = 4
        static let pageIndex: Int = 1
    }
    
    //MARK: - Variables
    private let jsonDecoder: JSONDecoder = JSONDecoder()
    private var newsPage: News.NewsPage = News.NewsPage()
    
    //MARK: - Fetch news
    func fetchNews(completion: @escaping (Result<News.NewsPage, Error>) -> Void) {
        guard let url = getURL(Constants.rubricNumber, Constants.pageIndex) else {
            completion(.failure(NewsWorker.URLError.invalidRequest))
            print("Failed in fetchNews")
            return
        }
        URLSession.shared.dataTask(with: url) {[weak jsonDecoder] data, response, error in
            if let error = error {
                completion(.failure(error))
                print("Failed in fetchNews1")
                return
            }
            if
                let data = data, let jsonDecoder,
                var newsPage = try? jsonDecoder.decode(News.NewsPage.self, from: data)
            {
                newsPage.passTheRequestId()
                completion(.success(newsPage))
                print("success")
            }
        }.resume()
    }
    
    //MARK: - Private method getURL
    private func getURL(_ rubric: Int, _ pageIndex: Int) -> URL? {
        URL(string: "https://news.myseldon.com/api/Section?rubricId=\(rubric)&pageSize=8&pageIndex=\(pageIndex)")
    }
}
