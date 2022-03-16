//
//  SourceArticleViewModel.swift
//  NewsApp
//
//  Created by Francesco Paolo Dellaquila on 12/03/22.
//

import Foundation
import Combine
import SwiftUI

class SourceArticleViewModel: ObservableObject {
    
    private let provider: SourceArticleProvider!
    private var bag = Set<AnyCancellable>()
    
    private(set) var articles = [ArticleResponse]()
    var errorState: HandledError?
    
    @Published var loadingState: Bool = true
    @Published var showErrorDialog: Bool = false
    
    init(provider: SourceArticleProvider = SourceArticleProvider()){
        self.provider = provider
    }
    
    
    func getArticlesFromSource(source: SourceResponse) {
        
        refreshState()
        loadingState = true
        
        provider.fetchNewsFromSource(source: source.id)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] data in
                
                if let articlesResponse = try? JSONDecoder().decode(NewsApiArticleResponse.self, from: data){
                    self?.articles = articlesResponse.articles
                    
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
    
    func saveFavoriteArticle(article: ArticleResponse){
        
        do{
            try self.provider.saveFavoriteNews(article: article)
        }catch{
            self.errorState = HandledError(status: "error", code: "500", message: error.localizedDescription)
            self.showErrorDialog = true
        }
    }
    
    func refreshState(){
        errorState = nil
        showErrorDialog = false
    }
    
}
