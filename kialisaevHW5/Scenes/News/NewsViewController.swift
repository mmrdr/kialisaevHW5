//
//  NewsViewController.swift
//  kialisaevHW5
//
//  Created by Кирилл Исаев on 11.12.2024.
//

import UIKit

final class NewsViewController: UIViewController {
    
    var articleTableView: UITableView = UITableView()
    private var interactor: (NewsBusinessLogic & NewsDataStore)?
    
    init(interactor: (NewsBusinessLogic & NewsDataStore)?) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 51/255.0, green: 48/255.0, blue: 48/255.0, alpha: 1)
        configureArticleTableView()
        interactor?.loadFreshNews()
    }
    
    private func configureArticleTableView() {
        view.addSubview(articleTableView)
        articleTableView.backgroundColor = UIColor(red: 51/255.0, green: 48/255.0, blue: 48/255.0, alpha: 1)
        articleTableView.delegate = self
        articleTableView.dataSource = self
        articleTableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.reuseId)
        articleTableView.separatorColor = UIColor.clear
        articleTableView.pinTop(view.safeAreaLayoutGuide.topAnchor)
        articleTableView.pinBottom(view.safeAreaLayoutGuide.bottomAnchor)
        articleTableView.pinLeft(view.leadingAnchor)
        articleTableView.pinRight(view.trailingAnchor)
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor?.articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reuseId, for: indexPath) as? NewsCell else {
            return UITableViewCell()
        }
        if let article = interactor?.articles[indexPath.row] {
            cell.backgroundColor = UIColor(red: 51/255.0, green: 48/255.0, blue: 48/255.0, alpha: 1)
            cell.configure(with: article)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1000
    }
}
