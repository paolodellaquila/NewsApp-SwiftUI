//
//  SourceProvider.swift
//  NewsApp
//
//  Created by Francesco Paolo Dellaquila on 14/03/22.
//

import Foundation
import Combine

protocol SourceAPI {

    var provider: HttpClient<ArticleEndpoint> { get }
    
    func fetchSources() -> AnyPublisher<Data, Error>
}


class SourceProvider: SourceAPI {
    
    var provider = HttpClient<ArticleEndpoint>()
    
    
    func fetchSources() -> AnyPublisher<Data, Error> {
        
        return provider.getData(from: .getSources)
            
    }
    
    
}
