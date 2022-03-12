//
//  HomeView.swift
//  NewsApp
//
//  Created by Francesco Paolo Dellaquila on 12/03/22.
//

import SwiftUI

struct NewsView: View {
    
    @ObservedObject var vm = NewsViewModel()
    
    var body: some View {
        
        NavigationView {
            
            NewsViewContent()
                .navigationTitle("News")
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            //TODO Refresh action
                        } label: {
                            Image(systemName: "arrow.counterclockwise")
                                .foregroundColor(.black)
                        }
                    }
                }.onAppear(){
                    vm.getTopHeadlines()
                }
        }
        
    }
}


struct NewsViewContent: View {
    
    var body: some View {
        
        Text("hello world")
        
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
