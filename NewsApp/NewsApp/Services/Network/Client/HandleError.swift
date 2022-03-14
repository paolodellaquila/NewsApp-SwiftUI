//
//  HandleError.swift
//  NewsApp
//
//  Created by Francesco Paolo Dellaquila on 13/03/22.
//

import Foundation

struct HandledError: Codable{
    
    let status, code, message: String
    
    public func readableMessage() -> String {
        if(!code.isEmpty){
            return "Status code: \(code) \n \(message)"
        }else{
            return message
        }
    }
    
}
