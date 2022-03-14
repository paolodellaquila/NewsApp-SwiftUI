//
//  NewsDetail.swift
//  NewsApp
//
//  Created by Francesco Paolo Dellaquila on 14/03/22.
//

import SwiftUI

struct SourceArticlesView: View {
    
    var source: Source!
    @ObservedObject var vm = SourceArticleViewModel()

    
    var body: some View {
        
        SourceNewsContent(vm: vm)
            .onAppear(){
                vm.getArticlesFromSource(source: source)
            }.alert(isPresented: $vm.showErrorDialog){
                Alert(
                    title: Text("Error"),
                    message: Text(vm.errorState?.readableMessage() ?? "Unknown Error"),
                    primaryButton: .default(Text("Ok"), action: {
                        vm.refreshState()
                    }),
                    secondaryButton: .destructive(Text("Retry"), action: {
                        vm.getArticlesFromSource(source: source)
                    })
                )
            }
        
    }
}

struct SourceNewsContent: View {
    
    @ObservedObject var vm = SourceArticleViewModel()
    
    var body: some View {
        
        if(vm.loadingState){
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                .scaleEffect(1.5, anchor: .center)
                
        }else{
            
            if(vm.articles.count > 0){
                SourceNewsList(news: vm.articles)
            }else{
                Text("No Source Available")
                    .foregroundColor(.white)
            }
            
        }
    }
}

struct SourceNewsList: View {
    
    var news: [Article] = []
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(){
                ForEach(news.shuffled(), id: \.self) { article in
                    
                    TopHeadlineCard(article: article)
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

struct SourceArticlesView_Previews: PreviewProvider {
    
    static var previews: some View {
        SourceArticlesView(source: Source(
            id: "",
            name: "test",
            description: "test",
            url: "",
            category: "",
            language: "",
            country: ""))
    }
}
