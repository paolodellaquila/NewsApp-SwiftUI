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
            NewsView()
                .tabItem {
                    Label("News", systemImage: "newspaper")
                }
            
            SourceView()
                .tabItem {
                    Label("Source", systemImage: "eyeglasses")
                }
            
            FavoriteView()
                .tabItem {
                    Label("Saved", systemImage: "heart")
                }
        }
        .accentColor(.primary)
        
    }
}

struct SharedTabView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SharedTabView()
                .preferredColorScheme(.light)
        }
    }
}
