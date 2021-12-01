//
//  AutoMasterApp.swift
//  AutoMaster
//
//  Created by Anton on 07.11.2021.
//

import SwiftUI

@main
struct AutoMasterApp: App {
    
    let paggingViewModel = PaggingViewModel()
    
    var body: some Scene {
        WindowGroup {
            PaggingView()
                .environmentObject(paggingViewModel)
        }
    }
}
