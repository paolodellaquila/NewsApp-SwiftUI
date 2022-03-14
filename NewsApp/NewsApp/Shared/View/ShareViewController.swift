//
//  ShareViewController.swift
//  NewsApp
//
//  Created by Francesco Paolo Dellaquila on 14/03/22.
//

import Foundation

import SwiftUI
import UIKit

struct ShareViewController: UIViewControllerRepresentable {
    let activityItems: [Any]
    let applicationActivities: [UIActivity]? = nil
    
    let excludedActivityTypes: [UIActivity.ActivityType]? = nil
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let activityViewConrtoller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: applicationActivities
        )
        
        activityViewConrtoller.excludedActivityTypes = excludedActivityTypes
        
        return activityViewConrtoller
    }
    
    func updateUIViewController(
        _ uiViewController: UIActivityViewController,
        context: Context
    ) {}
}

