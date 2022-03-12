//
//  SplashIntro.swift
//  NewsApp
//
//  Created by Francesco Paolo Dellaquila on 12/03/22.
//

import SwiftUI

struct SplashView: View {
    
    @State private var endSplash = false
    
    func delayNavigation(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            
            endSplash = true
        }
    }
    
    var body: some View {
        
        ZStack{
            
            if(!endSplash){
                SplashContent()
                    .onAppear(){
                        delayNavigation()
                    }
            }else{
                SharedTabView()
                    .animation(.easeIn)
                    .transition(.opacity)
            }
            
        }
    }
}


struct SplashContent: View {
    
    var body: some View {
        
        VStack{
             
             Image("news_icon")
             
             Text("News App")
                 .font(.largeTitle.bold())
            
         }
        
        
    }
    
}

struct SplashIntro_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
