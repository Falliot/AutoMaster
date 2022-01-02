//
//  SavedSearch.swift
//  AutoMaster
//
//  Created by Anton Pustovidko on 02/01/2022.
//

import Foundation

struct SavedSearch: Identifiable {
    var id: String = UUID().uuidString
    var year: String
    var manufacturer: String
    var model: String
    var country: String
    var color: String
}
