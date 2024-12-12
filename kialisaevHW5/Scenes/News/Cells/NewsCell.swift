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
        descriptionLabel.numberOfLines = 3
        return descriptionLabel
    }()
    
    private let shimmerLayer: ShimmerView = ShimmerView(frame: CGRect(x: 20, y: 75, width: 350, height: 200))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureShimmerView() {
        contentView.addSubview(shimmerLayer)
        shimmerLayer.layer.cornerRadius = 10
        shimmerLayer.startAnimating()
    }
    
    private func configureNewsImageView() {
        contentView.addSubview(newsImageView)
        newsImageView.pinCentreY(contentView)
        newsImageView.pinHorizontal(contentView, 20)
        newsImageView.setHeight(200)
        newsImageView.setWidth(350)
    }
    
    private func configureNewsTitleLabel() {
        contentView.addSubview(newsTitleLabel)
        newsTitleLabel.pinTop(newsImageView.bottomAnchor, 5)
        newsTitleLabel.pinHorizontal(newsImageView, 10)
    }
    
    private func configureNewsDescriptionLabel() {
        contentView.addSubview(newsDescriptionLabel)
        newsDescriptionLabel.pinTop(newsTitleLabel.bottomAnchor, 5)
        newsDescriptionLabel.pinHorizontal(newsImageView, 10)
    }
    
    private func configureUI() {
        configureShimmerView()
        configureNewsImageView()
        configureNewsTitleLabel()
        configureNewsDescriptionLabel()
    }
    
    private func loadImage(from imageURL: URL) {
        if let cachedImage = ImageCache.shared.getImage(for: imageURL as NSURL) {
            self.shimmerLayer.isHidden = true
            self.newsImageView.image = cachedImage
            return
        }
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: imageURL) else {return}
            guard let image = UIImage(data: data) else {return}
            
            ImageCache.shared.saveImage(image, for: imageURL as NSURL)
            
            DispatchQueue.main.async {
                self?.shimmerLayer.isHidden = true
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
