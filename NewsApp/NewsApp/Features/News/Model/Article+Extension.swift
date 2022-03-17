//
//  Article+Extension.swift
//  NewsApp
//
//  Created by Francesco Paolo Dellaquila on 16/03/22.
//

import Foundation
import CoreData

extension Article: CoreDataBaseModel {
    
    static func getArticleById(id: String) throws -> Article?{
        
        let request: NSFetchRequest<Article> = Article.fetchRequest()
        request.predicate = NSPredicate(
            format: "id = %@", id
        )
        
        do {
            return try viewContext.fetch(request).first
        } catch {
            return nil
        }
        
    }
    
    static func deleteArticleById(id: String) throws{
        
        do{
            guard let article = try getArticleById(id: id) else{
                return
            }
            
            try article.delete()
            
        }catch{
            throw error
        }
        
        
    }
    
    
    
    static func asArticleResponse(article: Article) -> ArticleResponse{
        
        return ArticleResponse(id: article.id!,
                               source: article.source!.asArticleResponseSource(),
                               author: article.author,
                               title: article.title!,
                               articleDescription: article.articleDescription,
                               url: article.url!,
                               urlToImage: article.urlToImage,
                               publishedAt: article.publishedAt!,
                               content: article.content)
    }
}
