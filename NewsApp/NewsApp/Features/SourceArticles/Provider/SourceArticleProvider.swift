//
//  SourceArticleProvider.swift
//  NewsApp
//
//  Created by Francesco Paolo Dellaquila on 14/03/22.
//

import Foundation
import Combine

protocol SourceArticlesAPI {

    var provider: HttpClient<ArticleEndpoint> { get }
    
    func fetchNewsFromSource(source: String) -> AnyPublisher<Data, Error>
    
}

protocol SourceArticlesStorage {
    
    func saveFavoriteNews(article: ArticleResponse) throws
}

class SourceArticleProvider: SourceArticlesAPI, SourceArticlesStorage {
    
    var provider = HttpClient<ArticleEndpoint>()
    
    
    func fetchNewsFromSource(source: String) -> AnyPublisher<Data, Error> {
        
        return provider.getData(from: .getArticlesFromSource(source))
            
    }
    
    func saveFavoriteNews(article: ArticleResponse) throws {
        
        do{
           try article.asEntity().save()
            
        }catch {
            throw error
        }

    }
    
    
}
