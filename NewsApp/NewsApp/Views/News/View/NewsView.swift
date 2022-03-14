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
            
            NewsViewContent(vm: vm)
                .navigationTitle("News")
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            vm.getTopHeadlines()
                        } label: {
                            Image(systemName: "arrow.counterclockwise")
                                .foregroundColor(.secondary)
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            //TODO: route to searchview
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.secondary)
                        }
                    }
                }.onAppear(){
                    vm.getTopHeadlines()
                }.alert(isPresented: $vm.showErrorDialog){
                    Alert(
                        title: Text("Error"),
                        message: Text(vm.errorState?.readableMessage() ?? "Unknown Error"),
                        primaryButton: .default(Text("Ok"), action: {
                            vm.refreshState()
                        }),
                        secondaryButton: .destructive(Text("Retry"), action: {
                            vm.getTopHeadlines()
                        })
                    )
                }
        }
        
    }
}


struct NewsViewContent: View {
    
    @ObservedObject var vm = NewsViewModel()
    
    var body: some View {
        
        if(vm.loadingState){
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                .scaleEffect(1.5, anchor: .center)
                
        }else{
            
            if(vm.articles.count > 0){
                HomeList(news: vm.articles)
            }else{
                Text("No Source Available")
                    .foregroundColor(.white)
 
            }
            
        }
        
    }
}

struct HomeList: View {
    
    var news: [Article] = []
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
        
            VStack(){
                
                TopHeadlineRow(news: Array(news.shuffled()[0...5]))
                    .animation(.easeIn)
                
                NewsList(news: news)
                    .animation(.easeIn)
                
            }

        }
        .fixFlickering()
    }
}


struct TopHeadlineRow: View {
    
    var news: [Article] = []
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            
            HStack(){
                
                ForEach(news, id: \.self) { article in
                    
                    TopHeadlineCard(article: article)
                        .frame(width: UIScreen.main.bounds.size.width,
                               height: 300,
                               alignment: .center)
                    
                }
            }
        }
        
    }
}


struct NewsList: View {
    
    var news: [Article] = []
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            LazyVStack(){
                
                ForEach(news, id: \.self) { article in
                    
                    NewsCard(article: article)
                    
                }
            }
        }
        
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
