//
//  TabView.swift
//  NewsApp
//
//  Created by Francesco Paolo Dellaquila on 12/03/22.
//

import SwiftUI

struct SharedTabView: View {
    
    var body: some View {

        TabView {
            HomeView()
                .tabItem {
                    Label("News", systemImage: "newspaper")
                }
            
            SourceView()
                .tabItem {
                    Label("Source", systemImage: "eyeglasses")
                }
            
            SearchView()
                .tabItem {
                    Label("News", systemImage: "doc.text.magnifyingglass")
                }
            
            FavoriteView()
                .tabItem {
                    Label("News", systemImage: "heart")
                }
        }
        .accentColor(.black)
        
    }
}

struct SharedTabView_Previews: PreviewProvider {
    static var previews: some View {
        SharedTabView()
    }
}
