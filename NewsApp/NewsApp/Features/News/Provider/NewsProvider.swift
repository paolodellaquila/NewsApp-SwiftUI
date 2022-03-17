//
//  NewsProvider.swift
//  NewsApp
//
//  Created by Francesco Paolo Dellaquila on 12/03/22.
//

import Foundation
import Combine

protocol NewsAPI {

    var provider: HttpClient<ArticleEndpoint> { get }
    
    func fetchTopNews() -> AnyPublisher<Data, Error>
    
}

protocol NewsStorage {
    
    func saveFavoriteNews(article: ArticleResponse) throws
}


class NewsProvider: NewsAPI, NewsStorage {
    
    var provider = HttpClient<ArticleEndpoint>()
    
    
    func fetchTopNews() -> AnyPublisher<Data, Error> {
        
        return provider.getData(from: .getTopHeadlines)
            
    }
    
    func saveFavoriteNews(article: ArticleResponse) throws {
        
        do{
           try article.asEntity().save()
            
        }catch {
            throw error
        }

    }
    
    
}

