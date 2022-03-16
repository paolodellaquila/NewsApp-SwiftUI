//
//  ArticleResponse.swift
//  NewsApp
//
//  Created by Francesco Paolo Dellaquila on 12/03/22.
//

import Foundation

struct NewsApiArticleResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [ArticleResponse]
}

struct ArticleResponse: Codable, Identifiable, Hashable {
    var id: String = UUID().uuidString
    let source: ArticleSourceResponse
    let author: String?
    let title: String
    let articleDescription: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}

extension ArticleResponse{
    
    func asEntity() -> Article{
        let article = Article(context: Article.viewContext)
        article.id = id
        article.source = source.asEntity()
        article.author = author
        article.title = title
        article.articleDescription = articleDescription
        article.url = url
        article.urlToImage = urlToImage
        article.publishedAt = publishedAt
        article.content = content
        
        return article
    }
}


// MARK: - Source
struct ArticleSourceResponse: Codable, Identifiable, Hashable{
    let id: String?
    let name: String
}

extension ArticleSourceResponse{
       
    func asEntity() -> Source{
        let source = Source(context: Source.viewContext)
        source.id = id
        source.name = name
        
        return source
    }
}
