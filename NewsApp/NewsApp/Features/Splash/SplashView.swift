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
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            
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
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        VStack{
            
            if(colorScheme == .dark){
                
                LottieView(name: "origami_dark", loopMode: .playOnce)
                    .frame(width: 300, height: 300)
            }else{
                
                LottieView(name: "origami_light", loopMode: .playOnce)
                    .frame(width: 300, height: 300)
            }
         }
    }
}

struct SplashIntro_Previews: PreviewProvider {
    static var previews: some View {
        
        SplashView()
            .preferredColorScheme(.dark)
    }
}
