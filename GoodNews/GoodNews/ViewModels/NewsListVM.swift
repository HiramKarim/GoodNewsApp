//
//  NewsListVM.swift
//  GoodNews
//
//  Created by Hiram Castro on 10/10/20.
//

import Foundation

struct ArticleListVM {
    let articles: [Articles]
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.articles.count
    }
    
    func articleAtIndex(_ index: Int) -> NewsListVM {
        let article = self.articles[index]
        return NewsListVM(article)
    }
}

struct NewsListVM {
    private let article:Articles
    
    init(_ article: Articles) {
        self.article = article
    }
    
    var title:String {
        return self.article.title ?? ""
    }
    
    var description:String {
        return self.article.description ?? ""
    }
}
