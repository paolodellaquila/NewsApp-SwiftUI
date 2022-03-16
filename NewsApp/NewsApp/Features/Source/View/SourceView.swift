//
//  SourceView.swift
//  NewsApp
//
//  Created by Francesco Paolo Dellaquila on 12/03/22.
//

import SwiftUI

struct SourceView: View {
    
    @ObservedObject var vm = SourceViewModel()
    
    var body: some View {

        NavigationView {
            
            SourceViewContent(vm: vm)
                .navigationTitle("Sources")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            vm.getSources()
                        } label: {
                            if !vm.loadingState {
                                
                                Image(systemName: "arrow.counterclockwise")
                                .foregroundColor(.primary)
                            }
                        }
                    }
                }.onAppear(){
                    vm.getSources()
                }.alert(isPresented: $vm.showErrorDialog){
                    Alert(
                        title: Text("Error"),
                        message: Text(vm.errorState?.readableMessage() ?? "Unknown Error"),
                        primaryButton: .default(Text("Ok"), action: {
                            vm.refreshState()
                        }),
                        secondaryButton: .destructive(Text("Retry"), action: {
                            vm.getSources()
                        })
                    )
                }
        }
    }
}

struct SourceViewContent: View {
    
    @ObservedObject var vm = SourceViewModel()
    
    var body: some View {
        
        if(vm.loadingState){
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                .scaleEffect(1.5, anchor: .center)
                
        }else{
            
            if(vm.sources.count > 0){
                SourceListView(sources: vm.sources)
            }else{
                Text("No Source Available")
                    .foregroundColor(.white)
            }
            
        }
        

        
    }
}


struct SourceListView: View {
    
    var sources: [SourceResponse] = []
    
    var body: some View {
        
        List(sources, id: \.self) { source in
            NavigationLink(
                destination: SourceArticlesView(source: source)
                    .navigationBarTitle(Text(source.name))
                    .accentColor(.white),
                label: {
                    Text(source.name)
                }
            )
        }
        .listStyle(InsetGroupedListStyle())
        .environment(\.verticalSizeClass, .regular)
        .animation(.spring())
    }
    
}

struct SourceView_Previews: PreviewProvider {
    static var previews: some View {
        SourceView()
    }
}
