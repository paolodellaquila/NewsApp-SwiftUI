//
//  SourceViewModel.swift
//  NewsApp
//
//  Created by Francesco Paolo Dellaquila on 14/03/22.
//

import Foundation
import Combine


class SourceViewModel: ObservableObject {
    
    private let provider: SourceProvider!
    private var bag = Set<AnyCancellable>()
    
    private(set) var sources = [SourceResponse]()
    var errorState: HandledError?
    
    @Published var loadingState: Bool = true
    @Published var showErrorDialog: Bool = false
    
    init(provider: SourceProvider = SourceProvider()){
        self.provider = provider
    }
    
    
    func getSources() {
        
        refreshState()
        loadingState = true
        
        provider.fetchSources()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] data in
                
                if let sourceResponse = try? JSONDecoder().decode(NewsApiSourcesResponse.self, from: data){
                    self?.sources = sourceResponse.sources
                    
                }else{
                    if let error = try? JSONDecoder().decode(HandledError.self, from: data){
                        self?.errorState = error
                        self?.showErrorDialog = true
                    }
                    
                }
                
                self?.loadingState = false
                
            })
            .store(in: &bag)
        
    }
    
    func refreshState(){
        errorState = nil
        showErrorDialog = false
    }
    
}
