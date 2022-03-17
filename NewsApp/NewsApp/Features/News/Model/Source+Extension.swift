//
//  Source+Extension.swift
//  NewsApp
//
//  Created by Francesco Paolo Dellaquila on 16/03/22.
//

import Foundation

extension Source: CoreDataBaseModel {
    
    func asArticleResponseSource() -> ArticleSourceResponse{
        return ArticleSourceResponse(id: self.id,
                                     name: self.name!)
    }
}
