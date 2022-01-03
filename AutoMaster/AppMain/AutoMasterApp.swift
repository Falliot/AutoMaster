//
//  AutoMasterApp.swift
//  AutoMaster
//
//  Created by Anton on 07.11.2021.
//

import SwiftUI
import RealmSwift

@main
struct AutoMasterApp: SwiftUI.App {
    
    var body: some Scene {
        WindowGroup {
            MainPage()
                .environment(\.realmConfiguration, Realm.Configuration())
        }
    }
}
