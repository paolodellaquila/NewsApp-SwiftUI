//
//  TabView.swift
//  NewsApp
//
//  Created by Francesco Paolo Dellaquila on 12/03/22.
//

import SwiftUI

struct SharedTabView: View {
    
    init() {
        
        UITabBar.appearance().barTintColor = UIColor(red: 32/255, green: 36/255, blue: 38/255, alpha: 1.0)
        
        UITabBar.appearance().tintColor = UIColor(red: 32/255, green: 36/255, blue: 38/255, alpha: 1.0)
    }
    
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
        .accentColor(.black)
        
    }
}

struct SharedTabView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SharedTabView()
        }
    }
}
