//
//  HomeView.swift
//  NewsApp
//
//  Created by Francesco Paolo Dellaquila on 12/03/22.
//

import SwiftUI

struct NewsView: View {
    
    @ObservedObject var vm = NewsViewModel()
    
    init() {

        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 32/255, green: 36/255, blue: 38/255, alpha: 1.0)
    }
    
    
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
                                .foregroundColor(.white)
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            vm.getTopHeadlines()
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.white)
                        }
                    }
                }.onAppear(){
                    vm.getTopHeadlines()
                }
        }
        
    }
}


struct NewsViewContent: View {
    
    @ObservedObject var vm = NewsViewModel()
    
    var body: some View {
        
        ZStack{
            
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            if(vm.loadingState){
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                    .scaleEffect(1.5, anchor: .center)
                    
            }else{
                
                ScrollView(.vertical, showsIndicators: false) {
                
                    VStack(){
                        
                        TopHeadlineRow(news: vm.articles)
                            .alert(isPresented: $vm.showErrorDialog){
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
                        
                        NewsList(news: vm.articles)
                        
                    }

                }
                
            }
        }
        
    }
}


struct TopHeadlineRow: View {
    
    var news: [Article] = []
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(){
                ForEach(news.shuffled(), id: \.self) { article in
                    
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
        
 
        LazyVStack(){
            ForEach(news, id: \.self) { article in
                
                NewsCard(article: article)
                
            }
        }
        
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
