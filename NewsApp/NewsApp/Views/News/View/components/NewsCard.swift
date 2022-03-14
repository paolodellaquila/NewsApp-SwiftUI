//
//  NewsCard.swift
//  NewsApp
//
//  Created by Francesco Paolo Dellaquila on 13/03/22.
//

import Foundation
import SwiftUI
import Kingfisher

struct NewsCard: View {
    
    @State private var shouldPresentURL: Bool = false
    @State private var shouldShowShareSheet: Bool = false
    
    var article: Article
    
    var body: some View {
        
        HStack(alignment: .center) {
        
            KFImage(URL(string: article.urlToImage ?? ""))
                .resizable()
                .scaledToFill()
                .frame(width: 80)
                .padding([.leading, .trailing], 16)
                .modifier(CardModifier())

        

            VStack(alignment: .leading) {
                
                Spacer()
                
                Text(article.title)
                    .font(.system(size: 16, weight: .bold, design: .default))
                    .foregroundColor(.white)
                    .lineLimit(3)
                
                Spacer()
                
                Text(article.articleDescription ?? "")
                    .font(.system(size: 12, weight: .bold, design: .default))
                    .foregroundColor(.gray)
                    .lineLimit(3)
                HStack {
                    Text(article.source.name)
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .foregroundColor(.white)
                        .padding(.top, 8)
                }
            }.padding(.all, 8)
        
        }
        .onTapGesture {
            shouldPresentURL = true
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color(red: 32/255, green: 36/255, blue: 38/255))
        .modifier(CardModifier())
        .padding([.leading, .trailing], 8)
        .padding([.top, .bottom], 8)
        .contextMenu {
            VStack{
                Button(
                    action: {
                        //TODO: save article to db
                    },
                    label: {
                        Text("Add to favorites")
                        Image(systemName: "heart.fill")
                    }
                )
                Button(
                    action: {
                        self.shouldShowShareSheet.toggle()
                    },
                    label: {
                        Text("Share")
                        Image(systemName: "square.and.arrow.up")
                    }
                )
            }
        }
        .sheet(isPresented: $shouldPresentURL) {
            
            if let url = URL(string: self.article.url){
                SafariView(url: url)
            }
        }
        .sheet(isPresented: $shouldShowShareSheet) {
            ShareViewController(activityItems: [
                self.article.title,
                self.article.url
            ])
        }
        
    }
}

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 0)
    }
}


struct NewsCard_Previews: PreviewProvider {
    
    static var previews: some View {
        
        NewsCard(article: Article(
            source: ArticleSource(id: "", name: "CNN"),
            author: "test",
            title: "Russian Missiles Strike Ukrainian Military Training Base Near Polish Border - The Wall Street Journal",
            articleDescription: "Attack on site where U.S. trained local forces kills at least 35, follows Moscow warning that arms shipments to Kyiv won’t be tolerated",
            url: "https://www.wsj.com/articles/russian-missiles-strike-ukrainian-military-training-base-near-polish-border-11647169428",
            urlToImage: "https://images.wsj.net/im-503948/social",
            publishedAt: "2022-03-13T16:44:47Z",
            content: "A Russian airstrike killed 35 people at a Ukrainian military training center about 10 miles from the Polish border early Sunday, one day after Moscow warned the West that it would consider arms deliv…"))
            .frame(width: .infinity, height: 220, alignment: .center)
    }
}
