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


class NewsProvider: NewsAPI {
    
    var provider = HttpClient<ArticleEndpoint>()
    
    
    func fetchTopNews() -> AnyPublisher<Data, Error> {
        
        return provider.getData(from: .getTopHeadlines)
            
    }
    
    
}

