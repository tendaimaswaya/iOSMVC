//
//  ContentCell.swift
//  CodeChallenge
//
//  Created by Tendai Maswaya on 10/21/21.
//

import Foundation
import UIKit


class ContentCell : UITableViewCell{
    static let reuseId  = "ContentCell"
    
    var content: Item?{
        didSet{
            
            guard let data = content?.data[0] else { return }
            var photographer = ""
            if let _photographer = data.photographer {
                photographer = "\(_photographer) | "
            }
            var dateCreated = ""
            if let _dateCreated = data.date_created {
                dateCreated = _dateCreated.convertDateToFriendly()
            }
            subtitleLabel.text = "\(photographer)\(dateCreated)"
            titleLabel.text = data.title

            if let imageUrl = content?.links[0].href {
                imageContainer.image = UIImage(named: Constants.Assets.imagePlaceholder)
                imageContainer.downloaded(from: imageUrl)
            }
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: ContentCell.reuseId)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = label.font.withSize(14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    lazy var imageContainer: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    func setupCell(){
        contentView.addSubview(imageContainer)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 90),

            imageContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant:10),
            imageContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            imageContainer.widthAnchor.constraint(equalToConstant: 60),
            imageContainer.heightAnchor.constraint(equalToConstant: 60),
     
            titleLabel.leadingAnchor.constraint(equalTo: imageContainer.trailingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: imageContainer.trailingAnchor, constant: 5),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
           
        ])
    }

}

