//
//  NewsCell.swift
//  kialisaevHW5
//
//  Created by Кирилл Исаев on 11.12.2024.
//

import UIKit

final class NewsCell: UITableViewCell {
    //MARK: - Constants
    enum Constants {
        static let reuseId: String = "NewsCell"
        
        static let imageViewCornerRadius: CGFloat = 10
        
        static let titleLabelFontSize: CGFloat = 14
        static let titleLabelTextColor: UIColor = .green
        static let titleLabelNumberOfLines: Int = 2
        
        static let descriptionLabelFontSize: CGFloat = 12
        static let descriptionLabelTextColor: UIColor = .white
        static let descriptionLabelNumberOfLines: Int = 3
        
        static let shimmerViewFrame: CGRect = CGRect(x: 20, y: 75, width: 350, height: 200)
        static let shimmerViewCornerRadius: CGFloat = 10
        
        static let imageViewHorizontal: CGFloat = 20
        static let imageViewHeight: CGFloat = 200
        static let imageViewWidth: CGFloat = 350
        
        static let newsTitleLabelTop: CGFloat = 5
        static let newsTitleLabelHorizontal: CGFloat = 10
        
        static let newsDescriptionLabelTop: CGFloat = 5
        static let newsDescriptionLabelHorizontal: CGFloat = 10
    }

    //MARK: - Variables
    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.imageViewCornerRadius
        return imageView
    }()
    
    private let newsTitleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .boldSystemFont(ofSize: Constants.titleLabelFontSize)
        titleLabel.textColor = Constants.titleLabelTextColor
        titleLabel.numberOfLines = Constants.titleLabelNumberOfLines
        return titleLabel
    }()
    
    private let newsDescriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.font = .systemFont(ofSize: Constants.descriptionLabelFontSize)
        descriptionLabel.textColor = Constants.descriptionLabelTextColor
        descriptionLabel.numberOfLines = Constants.descriptionLabelNumberOfLines
        return descriptionLabel
    }()
    
    private let shimmerLayer: ShimmerView = ShimmerView(frame: Constants.shimmerViewFrame)
    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods
    private func configureShimmerView() {
        contentView.addSubview(shimmerLayer)
        shimmerLayer.layer.cornerRadius = Constants.shimmerViewCornerRadius
        shimmerLayer.startAnimating()
    }
    
    private func configureNewsImageView() {
        contentView.addSubview(newsImageView)
        newsImageView.pinCentreY(contentView)
        newsImageView.pinHorizontal(contentView, Constants.imageViewHorizontal)
        newsImageView.setHeight(Constants.imageViewHeight)
        newsImageView.setWidth(Constants.imageViewWidth)
    }
    
    private func configureNewsTitleLabel() {
        contentView.addSubview(newsTitleLabel)
        newsTitleLabel.pinTop(newsImageView.bottomAnchor, Constants.newsTitleLabelTop)
        newsTitleLabel.pinHorizontal(newsImageView, Constants.newsTitleLabelHorizontal)
    }
    
    private func configureNewsDescriptionLabel() {
        contentView.addSubview(newsDescriptionLabel)
        newsDescriptionLabel.pinTop(newsTitleLabel.bottomAnchor, Constants.newsDescriptionLabelTop)
        newsDescriptionLabel.pinHorizontal(newsImageView, Constants.newsDescriptionLabelHorizontal)
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
