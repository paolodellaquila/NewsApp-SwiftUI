//
//  FavoriteViewModel.swift
//  NewsApp
//
//  Created by Francesco Paolo Dellaquila on 16/03/22.
//

import Foundation
import Combine
import SwiftUI

class FavoriteViewModel: ObservableObject {
    
    private let provider: FavoriteProvider!
    
    private(set) var articles = [ArticleResponse]()
    var errorState: HandledError?
    
    @Published var loadingState: Bool = true
    @Published var showErrorDialog: Bool = false
    
    init(provider: FavoriteProvider = FavoriteProvider()){
        self.provider = provider
    }
    
    
    func getFavoriteNews() {
        
        refreshState()
        loadingState = true
        
        DispatchQueue.main.async {
            self.articles = self.provider.getFavoriteNews()
            self.loadingState = false
        }
        
    }
    
    func deleteFromFavorite(article: ArticleResponse){
        
        do{
            try provider.deleteFavoriteNews(id: article.id)
            
        }catch {
            self.errorState = HandledError(status: "error", code: "500", message: error.localizedDescription)
            self.showErrorDialog = true
        }
    }
    

    func refreshState(){
        errorState = nil
        showErrorDialog = false
    }
    
}
