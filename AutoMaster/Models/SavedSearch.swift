//
//  SavedSearch.swift
//  AutoMaster
//
//  Created by Anton Pustovidko on 02/01/2022.
//

import SwiftUI
import RealmSwift
import SwiftUIX

class SavedSearch: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var year: String
    @Persisted var manufacturer: String
    @Persisted var model: String
    @Persisted var country: String
    @Persisted var color: String
}
