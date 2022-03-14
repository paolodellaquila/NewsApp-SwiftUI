//
//  SourceResponse.swift
//  NewsApp
//
//  Created by Francesco Paolo Dellaquila on 14/03/22.
//

import Foundation


struct SourcesResponse: Codable {
    let status: String
    let sources: [Source]
}

struct Source: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let description: String?
    let url: String
    let category: String
    let language: String
    let country: String
}
