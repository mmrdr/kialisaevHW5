//
//  NewsCell.swift
//  kialisaevHW5
//
//  Created by Кирилл Исаев on 11.12.2024.
//

import UIKit

final class NewsCell: UITableViewCell {
    static let reuseId: String = "NewsCell"
    
    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let newsTitleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .boldSystemFont(ofSize: 14)
        titleLabel.textColor = .green
        titleLabel.numberOfLines = 2
        return titleLabel
    }()
    
    private let newsDescriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.font = .systemFont(ofSize: 12)
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 4
        return descriptionLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureNewsImageView() {
        contentView.addSubview(newsImageView)
        newsImageView.pinCentreY(contentView)
        newsImageView.pinHorizontal(contentView, 20)
        newsImageView.setHeight(350)
        newsImageView.setWidth(350)
    }
    
    private func configureNewsDescriptionLabel() {
        newsImageView.addSubview(newsDescriptionLabel)
        newsDescriptionLabel.pinBottom(newsImageView.bottomAnchor, 5)
        newsDescriptionLabel.pinHorizontal(newsImageView, 10)
    }
    
    private func configureNewsTitleLabel() {
        newsImageView.addSubview(newsTitleLabel)
        newsTitleLabel.pinBottom(newsDescriptionLabel.topAnchor, 5)
        newsTitleLabel.pinHorizontal(newsImageView, 10)
    }
    
    private func configureUI() {
        configureNewsImageView()
        configureNewsDescriptionLabel()
        configureNewsTitleLabel()
    }
    
    private func loadImage(from imageURL: URL) {
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: imageURL) else {return}
            guard let image = UIImage(data: data) else {return}
            DispatchQueue.main.async {
                self?.newsImageView.image = image
            }
        }
    }
    
    func configure(with article: News.Article) {
        newsTitleLabel.text = article.title
        newsDescriptionLabel.text = article.announce
        if let url = article.img?.url {
            loadImage(from: url)
        }
    }
}
