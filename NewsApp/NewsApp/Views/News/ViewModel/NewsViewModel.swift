//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Francesco Paolo Dellaquila on 12/03/22.
//

import Foundation
import Combine

class NewsViewModel: ObservableObject {
    
    private let provider: NewsProvider!
    private var bag = Set<AnyCancellable>()
    
    @Published private(set) var articles = [Article]()
    
    
    init(provider: NewsProvider = NewsProvider()){
        self.provider = provider
    }
    
    
    func getTopHeadlines() {
        
        provider.fetchTopNews()
            .replaceError(with: [])
            .assign(to: \.articles, on: self)
            .store(in: &bag)
        
    }
    
}
