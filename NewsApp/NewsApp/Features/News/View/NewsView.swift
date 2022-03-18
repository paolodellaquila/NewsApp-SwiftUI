//
//  HomeView.swift
//  NewsApp
//
//  Created by Francesco Paolo Dellaquila on 12/03/22.
//

import SwiftUI
import SwipeCellSUI

struct NewsView: View {
    
    @ObservedObject var vm = NewsViewModel()
    @State var searchText = ""
    @State var searching = false
    
    var body: some View {
        
        NavigationView {
            
            NewsViewContent(vm: vm, searchText: $searchText, searching: $searching)
                .navigationTitle(searching ? "Searching..." : "News")
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        if !vm.loadingState {
                            
                            Button {
                                searching = !searching
                            } label: {
                                
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.secondary)
                            }
                            .animation(.easeIn)
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        if searching {
                            Button("Cancel") {
                                searchText = ""
                                withAnimation {
                                    searching = false
                                    UIApplication.shared.dismissKeyboard()
                                }
                            }
                        }else{
                            
                            if !vm.loadingState {
                                Button {
                                    vm.getTopHeadlines()
                                } label: {
                                    
                                    Image(systemName: "arrow.counterclockwise")
                                            .foregroundColor(.secondary)
                                }
                                .animation(.easeIn)
                            }

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
    @Binding var searchText: String
    @Binding var searching: Bool
    
    var body: some View {
        
        if vm.loadingState{
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                .scaleEffect(1.5, anchor: .center)
                
        }else{
            
            if(vm.articles.count > 0){
                VStack{
                    
                    if searching {
                        SearchBar(searchText: $searchText, searching: $searching)
                            .animation(.spring())
                    }
                    
                    HomeList(vm: vm, searchText: $searchText, searching: $searching, news: vm.latestArticle)
                }

            }else{
                Text("No Source Available")
                    .foregroundColor(.white)
 
            }
            
        }
        
    }
}

struct SearchBar: View {
    
    @Binding var searchText: String
    @Binding var searching: Bool
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .foregroundColor(.secondary)
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                TextField("Typing keywords..", text: $searchText){ startedEditing in
                    if startedEditing {
                        withAnimation {
                            searching = true
                        }
                    }
                } onCommit: {
                    withAnimation {
                        searching = false
                    }
                }
            }
            .foregroundColor(.secondary)
            .padding(.leading,13)
        }
        .frame(height: 40)
        .cornerRadius(16)
        .padding()
    }
}

struct HomeList: View {
    
    @ObservedObject var vm = NewsViewModel()
    @Binding var searchText: String
    @Binding var searching: Bool
    
    var news: [ArticleResponse] = []
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
        
            VStack(){
                
                if !searching {
                    TopHeadlineRow(news: news)
                }
                
                NewsList(vm: vm, news: news.filter({(article: ArticleResponse) -> Bool in
                    return article.title.hasPrefix(searchText) || searchText == ""
                }))
                
            }

        }
        .fixFlickering()
        .gesture(DragGesture()
                     .onChanged({ _ in
                         UIApplication.shared.dismissKeyboard()
                     })
         )
    }
    
}


struct TopHeadlineRow: View {
    
    @ObservedObject var vm = NewsViewModel()
    var news: [ArticleResponse] = []
    
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
    
    @ObservedObject var vm = NewsViewModel()
    var news: [ArticleResponse] = []
    
    @State var selectedArticleID: String?
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(){
                ForEach(news, id: \.self) { article in
                    
                    NewsCard(article: article)
                        .swipeCell(id: article.id, cellWidth: UIScreen.main.bounds.size.width, leadingSideGroup: [], trailingSideGroup: rightGroup(article: article), currentUserInteractionCellID: $selectedArticleID)
                        .onTapGesture {
                            selectedArticleID = article.id
                        }
                    
                }
            }
        }
    }
    
    func rightGroup(article: ArticleResponse)->[SwipeCellActionItem] {

        let items =  [

            SwipeCellActionItem(buttonView: {
                    VStack(spacing: 2)  {
                    Image(systemName: "folder.fill").font(.system(size: 22)).foregroundColor(.white)
                        Text("Save").fixedSize().font(.system(size: 12)).foregroundColor(.white)
                    }.frame(maxHeight: 80).castToAnyView()
          
            }, backgroundColor: .purple, actionCallback: {
                vm.saveFavoriteArticle(article: article)
            }),
            
          ]
        
        return items
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
