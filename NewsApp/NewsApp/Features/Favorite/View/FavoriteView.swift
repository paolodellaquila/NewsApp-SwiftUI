//
//  FavoriteView.swift
//  NewsApp
//
//  Created by Francesco Paolo Dellaquila on 12/03/22.
//

import SwiftUI

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
    var news: [ArticleResponse] = []
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(){
                ForEach(news, id: \.self) { article in
                    
                    TopHeadlineCard(article: article, favoriteCard: true, handleSelectedNews: { article in
                        vm.deleteFromFavorite(article: article)
                    })
                        .frame(width: UIScreen.main.bounds.size.width,
                               height: 300,
                               alignment: .center)
                        .padding()
                    
                }
            }
        }
        .fixFlickering()
        
    }
}

struct FavoriteView_Previews: PreviewProvider {
    
    static var previews: some View {
        SourceArticlesView(source: SourceResponse(
            id: "",
            name: "test",
            description: "test",
            url: "",
            category: "",
            language: "",
            country: ""))
    }
}
