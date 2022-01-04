//
//  TransportDetailsShort.swift
//  AutoMaster
//
//  Created by Anton Pustovidko on 03/01/2022.
//

import SwiftUI
import RealmSwift

class TransportDetailsShort: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var transportId: Int
    @Persisted var imageURL: String
    @Persisted var year: String
    @Persisted var maker: String
    @Persisted var price: String
    @Persisted var mileage: String
    @Persisted var location: String
}
