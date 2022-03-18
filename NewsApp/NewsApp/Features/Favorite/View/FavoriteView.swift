//
//  FavoriteView.swift
//  NewsApp
//
//  Created by Francesco Paolo Dellaquila on 12/03/22.
//

import SwiftUI
import SwipeCellSUI

struct FavoriteView: View {
    
    @ObservedObject var vm = FavoriteViewModel()

    var body: some View {
        
        NavigationView {
            FavoriteNewsContent(vm: vm)
                .navigationTitle("Favorite News")
                .navigationBarTitleDisplayMode(.large)
                .onAppear(){
                    vm.getFavoriteNews()
                }.alert(isPresented: $vm.showErrorDialog){
                    Alert(
                        title: Text("Error"),
                        message: Text(vm.errorState?.readableMessage() ?? "Unknown Error"),
                        primaryButton: .default(Text("Ok"), action: {
                            vm.refreshState()
                        }),
                        secondaryButton: .destructive(Text("Retry"), action: {
                            vm.getFavoriteNews()
                        })
                    )
                }
        }
            

        
    }
}

struct FavoriteNewsContent: View {
    
    @ObservedObject var vm = FavoriteViewModel()
    
    var body: some View {
        
        if(vm.loadingState){
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                .scaleEffect(1.5, anchor: .center)
                
        }else{
            
            if(vm.articles.count > 0){
                FavoriteNewsList(news: vm.articles)
            }else{
                Text("No Favorite News Available")
                    .foregroundColor(.white)
            }
            
        }
    }
}

struct FavoriteNewsList: View {
    
    @ObservedObject var vm = FavoriteViewModel()
    @State var news: [ArticleResponse] = []
    
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
        .fixFlickering()
        
    }
    
    func rightGroup(article: ArticleResponse)->[SwipeCellActionItem] {

        let items =  [

            SwipeCellActionItem(buttonView: {
                    VStack(spacing: 2)  {
                    Image(systemName: "trash").font(.system(size: 22)).foregroundColor(.white)
                        Text("Remove").fixedSize().font(.system(size: 12)).foregroundColor(.white)
                    }.frame(maxHeight: 80).castToAnyView()
          
            }, backgroundColor: .red, actionCallback: {
                
                vm.deleteFromFavorite(article: article)
                news = news.filter{$0.id != article.id}
            }),
            
          ]
        
        return items
    }
}

struct FavoriteView_Previews: PreviewProvider {
    
    static var previews: some View {
        FavoriteView()
    }
}
