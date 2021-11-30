//
//  AutoModel.swift
//  AutoMaster
//
//  Created by Anton on 17.11.2021.
//

import Foundation

struct AutoModel {
    let manufacturer: String
    let model: String
    let price: String
    
    
    // seller ?
//    let seller: String
    // Basic Data
    let bodyType: BodyType
    let condition: AutoCondition
    let numberOfSeats: Int
    let doorCount: Int
    
    // Vehicle History
    let mileage: String
    let firstRegistration: String
    let nonSmokerCar: Bool
    let previousOwnerCount: Int
    
    // change to date
    let generalInspection: String
    let recentTechnicalService: String
    
    // Technical Data
    let power: String
    let transmission: Transmission
    let engineSize: String
    let gears: String
    let cylinder: String
    let kerbWeight: String
    
//    Energy Consumption
    let fuelType: FuelType
    let fuelConsumption: String
//    let CO2Emission: String
    let equipment: Equipment
    let colorAbdUpholstery: ColorAndUpholstery // probably find a better naming
    
    let description: String
}

struct Product: Identifiable, Hashable {
    var id = UUID().uuidString
    var manufacturer: String
    var model: String
    var price: String
    var mileage: String
    var year: String
    var fuel: String
    var transmission: String
    var location: String
    var image: String
}
