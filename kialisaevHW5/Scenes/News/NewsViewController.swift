//
//  NewsViewController.swift
//  kialisaevHW5
//
//  Created by Кирилл Исаев on 11.12.2024.
//

import UIKit

final class NewsViewController: UIViewController {
    //MARK: - Constants
    enum Constants {
        static let backgroundColor: UIColor = UIColor(red: 51/255.0, green: 48/255.0, blue: 48/255.0, alpha: 1)
        
        static let shareButtonName: String = "Share"
        
        static let tableViewHeightForRowAt: CGFloat = 350
    }
    
    var articleTableView: UITableView = UITableView()
    private var interactor: (NewsBusinessLogic & NewsDataStore)?
    let refreshControl = UIRefreshControl()
    
    init(interactor: (NewsBusinessLogic & NewsDataStore)?) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        configureArticleTableView()
        interactor?.loadFreshNews()
    }
    
    private func configureArticleTableView() {
        view.addSubview(articleTableView)
        articleTableView.backgroundColor = Constants.backgroundColor
        articleTableView.delegate = self
        articleTableView.dataSource = self
        articleTableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.Constants.reuseId)
        articleTableView.separatorColor = UIColor.clear
        articleTableView.refreshControl = refreshControl
        articleTableView.pinTop(view.safeAreaLayoutGuide.topAnchor)
        articleTableView.pinBottom(view.safeAreaLayoutGuide.bottomAnchor)
        articleTableView.pinLeft(view.leadingAnchor)
        articleTableView.pinRight(view.trailingAnchor)
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    @objc
    private func refreshData() {
        interactor?.loadFreshNews()
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor?.articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.Constants.reuseId, for: indexPath) as? NewsCell else {
            return UITableViewCell()
        }
        if let article = interactor?.articles[indexPath.row] {
            cell.backgroundColor = Constants.backgroundColor
            cell.selectionStyle = .none
            cell.configure(with: article)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let articleURL = interactor?.articles[indexPath.row].articleUrl
        interactor?.routeToWebNews(
            News.RouteToWebNews.Request(
                articleURL: articleURL)
        )
    }
    
    func tableView(_ tableView: UITableView,
                       trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let share = UIContextualAction(
            style: .normal, title: Constants.shareButtonName) { (action, view, completionHandler) in
                self.interactor?.createViewForNewsShare(News.ShareNews.Request(newId: self.interactor?.articles[indexPath.row].newsId))
                completionHandler(true)
        }
        let swipe = UISwipeActionsConfiguration(actions: [share])
        return swipe
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.tableViewHeightForRowAt
    }
}
