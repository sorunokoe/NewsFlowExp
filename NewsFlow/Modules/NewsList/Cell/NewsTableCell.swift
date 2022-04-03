//
//  NewsTableCell.swift
//  NewsFlow
//
//  Created by Yeskendir Salgara on 31.03.2022.
//

import UIKit

final class NewsTableCell: UITableViewCell {
    
    static var reuseID = "NewsTableCellId"
    
    var tileView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .black.withAlphaComponent(0.2)
        return view
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.textColor = .black.withAlphaComponent(0.75)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func set(data: News) {
        titleLabel.text = data.title
        
        var description = ""
        if let author = data.author {
            description += author
        }
        if let date = data.publishedAt {
            description += description.isEmpty ? date : "\n\(date)"
        }
        
        descriptionLabel.text = description
        
        DispatchQueue.global().async { [weak self] in
            let url = URL(string: data.urlToImage ?? "")!
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self?.newsImageView.image = UIImage(data: data)    
                }
            }    
        }
        
    }
    
}
private extension NewsTableCell {
    
    func configure() {
        
        selectionStyle = .none
        
        contentView.addSubview(tileView)
        tileView.translatesAutoresizingMaskIntoConstraints = false
        
        [titleLabel, descriptionLabel, newsImageView].forEach {
            tileView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            tileView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            tileView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            tileView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
            tileView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            
            newsImageView.topAnchor.constraint(equalTo: tileView.topAnchor, constant: 16),
            newsImageView.leftAnchor.constraint(equalTo: tileView.leftAnchor, constant: 12),
            newsImageView.bottomAnchor.constraint(equalTo: tileView.bottomAnchor, constant: -16),
            newsImageView.widthAnchor.constraint(equalToConstant: 80),
            newsImageView.heightAnchor.constraint(equalToConstant: 80),
            
            titleLabel.topAnchor.constraint(equalTo: tileView.topAnchor, constant: 16),
            titleLabel.leftAnchor.constraint(equalTo: newsImageView.rightAnchor, constant: 9),
            titleLabel.rightAnchor.constraint(equalTo: tileView.rightAnchor, constant: -12),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            descriptionLabel.leftAnchor.constraint(equalTo: newsImageView.rightAnchor, constant: 9),
            descriptionLabel.rightAnchor.constraint(equalTo: tileView.rightAnchor, constant: -12),
        ])
        
    }
    
}
