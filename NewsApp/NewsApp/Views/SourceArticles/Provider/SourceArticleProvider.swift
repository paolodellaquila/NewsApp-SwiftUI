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


class SourceArticleProvider: SourceArticlesAPI {
    
    var provider = HttpClient<ArticleEndpoint>()
    
    
    func fetchNewsFromSource(source: String) -> AnyPublisher<Data, Error> {
        
        return provider.getData(from: .getArticlesFromSource(source))
            
    }
    
    
}
