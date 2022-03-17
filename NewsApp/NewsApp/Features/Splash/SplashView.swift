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
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            endSplash = true
        }
    }
    
    var body: some View {
        
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


struct SplashContent: View {
    
    var body: some View {
        
        VStack{
             
             Image("news_icon")
                .frame(width: 64.0, height: 64.0)
                .foregroundColor(.secondary)
            
         }

        
        
    }
    
}

struct SplashIntro_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
