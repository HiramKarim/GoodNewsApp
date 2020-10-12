//
//  Article.swift
//  GoodNews
//
//  Created by Hiram Castro on 10/10/20.
//

import Foundation

struct Article:Decodable {
    let status:String?
    let totalResults:Int?
    let articles:[Articles]
}

struct Articles:Decodable {
    let source:Source
    let author:String?
    let title:String?
    let description:String?
    let url:String?
    let urlToImage:String?
    let publishedAt:String?
    let content:String?
}

struct Source:Decodable {
    let id:String?
    let name:String?
}
