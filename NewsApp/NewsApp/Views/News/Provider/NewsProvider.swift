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
    
    func fetchTopNews() -> AnyPublisher<[Article], Error>
}


class NewsProvider: NewsAPI {
    
    var provider = HttpClient<ArticleEndpoint>()
    
    
    func fetchTopNews() -> AnyPublisher<[Article], Error> {
        
        return provider.getData(from: .getTopHeadlines)
            .decode(type: ArticleResponse.self, decoder: JSONDecoder())
            .map { $0.articles }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    
}

