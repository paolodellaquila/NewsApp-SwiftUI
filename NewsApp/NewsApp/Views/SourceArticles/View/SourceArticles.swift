//
//  NewsDetail.swift
//  NewsApp
//
//  Created by Francesco Paolo Dellaquila on 14/03/22.
//

import SwiftUI

struct SourceArticles: View {
    
    var source: Source
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct NewsDetail_Previews: PreviewProvider {
    static var previews: some View {
        SourceArticles(source: Source(
            id: "",
            name: "test",
            description: "test",
            url: "",
            category: "",
            language: "",
            country: ""))
    }
}
