//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Francesco Paolo Dellaquila on 12/03/22.
//

import Foundation
import Combine
import SwiftUI

class NewsViewModel: ObservableObject {
    
    private let provider: NewsProvider!
    private var bag = Set<AnyCancellable>()
    
    private(set) var articles = [Article]()
    var errorState: HandledError?
    
    @Published var loadingState: Bool = false
    @Published var showErrorDialog: Bool = false
    
    init(provider: NewsProvider = NewsProvider()){
        self.provider = provider
    }
    
    
    func getTopHeadlines() {
        
        refreshState()
        loadingState = true
        
        provider.fetchTopNews()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] data in
                
                if let newsArticles = try? JSONDecoder().decode(ArticleResponse.self, from: data){
                    self?.articles = newsArticles.articles
                    
                }else{
                    if let error = try? JSONDecoder().decode(HandledError.self, from: data){
                        self?.errorState = error
                        self?.showErrorDialog = true
                    }
                    
                }
                
                self?.loadingState = false
                
            })
            .store(in: &bag)
        
    }
    
    func refreshState(){
        errorState = nil
        showErrorDialog = false
    }
    
}
