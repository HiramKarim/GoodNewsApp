//
//  NewsCell.swift
//  GoodNews
//
//  Created by Hiram Castro on 10/17/20.
//

import UIKit

class NewsCell: UITableViewCell {
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.textColor = .black
        //label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel:UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        //label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        
        configCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configCell() {
        
        self.addSubview(titleLabel)
        self.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
    }
    
}
