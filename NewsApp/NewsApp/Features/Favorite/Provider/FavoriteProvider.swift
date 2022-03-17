//
//  FavoriteProvider.swift
//  NewsApp
//
//  Created by Francesco Paolo Dellaquila on 16/03/22.
//

import Foundation
import CoreData

protocol FavoriteNewsStorage {
    
    func getFavoriteNews() -> [ArticleResponse]
    
    func deleteFavoriteNews(id: String) throws
}


class FavoriteProvider: FavoriteNewsStorage {
    
    func getFavoriteNews() -> [ArticleResponse]{
        
        return Article.all().map{Article.asArticleResponse(article: $0 as! Article)}

    }
    
    
    func deleteFavoriteNews(id: String) throws {
        
        do{
            try Article.deleteArticleById(id: id)
            
        }catch {
            throw error
        }
        
    }
    
    
}

