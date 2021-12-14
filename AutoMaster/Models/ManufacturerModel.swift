//
//  ManufacturerModel.swift
//  AutoMaster
//
//  Created by Anton on 11.11.2021.
//

import Foundation

struct ManufacturerModel: Codable, Identifiable, Hashable {
//    static func == (lhs: ManufacturerModel, rhs: ManufacturerModel) -> Bool {
//        return true
//    }
    
//    static func == (lhs: ManufacturerModel, rhs: ManufacturerModel) -> Bool {
//        return true
//    }
//
//    static func < (lhs: ManufacturerModel, rhs: ManufacturerModel) -> Bool {
//        return lhs.name < rhs.name
//    }
    
    var name: String
//    var image: ManufacturerImage
    var id: String { name }
}
//
//struct ManufacturerImage: Codable, Hashable {
//    var optimized: String
//}
