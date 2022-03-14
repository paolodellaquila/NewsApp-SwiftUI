//
//  SourceView.swift
//  NewsApp
//
//  Created by Francesco Paolo Dellaquila on 12/03/22.
//

import SwiftUI

struct SourceView: View {
    
    @ObservedObject var vm = SourceViewModel()
    
    init() {

        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().barTintColor = ColorTheme.specialGray
        
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = ColorTheme.specialGray
        UITableView.appearance().backgroundColor = .black
    }
    
    
    var body: some View {

        NavigationView {
            
            SourceViewContent(vm: vm)
                .navigationTitle("Sources")
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            vm.getSources()
                        } label: {
                            Image(systemName: "arrow.counterclockwise")
                                .foregroundColor(.white)
                        }
                    }
                }.onAppear(){
                    vm.getSources()
                }
        }
        
        
    }
}

struct SourceViewContent: View {
    
    @ObservedObject var vm = SourceViewModel()
    
    var body: some View {
        
        ZStack{
            
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            if(vm.loadingState){
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                    .scaleEffect(1.5, anchor: .center)
                    
            }else{
                
                SourceListView(sources: vm.sources)
                
            }
        }
        
    }
}


struct SourceListView: View {
    
    var sources: [Source] = []
    
    var body: some View {
        
        List {
            ForEach(sources, id: \.self) { source in
                HStack {
                   Text(source.name)
                        .foregroundColor(.white)
                   Spacer()
                   Image(systemName: "chevron.right")
                     .resizable()
                     .aspectRatio(contentMode: .fit)
                     .frame(width: 7)
                     .foregroundColor(.white) //Apply color for arrow only
                 }
                 .foregroundColor(.purple)
                 .background(
                    NavigationLink(
                        destination: SourceArticles(source: source)
                            .navigationBarTitle(Text(source.name)),
                        label: {
                            Text(source.name)
                        }
                    )
                    .opacity(0)
                 )
            }
            .listRowBackground(Color(ColorTheme.specialGray))
            .foregroundColor(.white)
        }
        

    }
    
}

struct SourceView_Previews: PreviewProvider {
    static var previews: some View {
        SourceView()
    }
}
