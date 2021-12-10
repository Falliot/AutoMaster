//
//  AutoModel.swift
//  AutoMaster
//
//  Created by Anton on 17.11.2021.
//

import UIKit

struct AutoModel {
    let maker: String
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

//MARK: - TransportModel
struct TransportModel: Decodable, Identifiable, Hashable {
    
    //TODO: - separate common, and for each api
    
    var id: Int?
    var maker: String?
    var model: String?
    var price: Int?
    var mileage: String?
    var year: Int?
    var fuel: String?
    var power: Int?
    var transmission: String?
    var location: String?
    var image: String?
    var icon: String?
    
    //MARK: - AutoRia Specific
    var title: String?
    var linkToView: String?
    var description: String?
    
    // practice
    var userPhone: String?
    
    enum Site {
        case carAPI
        case autoria
//        case olx
//        case allegro
    }
    
    enum SiteError: Error {
        case unknownSite
    }
    
    enum SiteCarAPICodingKeys: String, CodingKey {
        case year
        case id
        case power = "horsepower"
        case maker = "make"
        case model
        case price
        case image = "img_url"
    }
    
    enum SiteAutoRiaCodingKeys: String, CodingKey {
        case locationCityName
        case userPhoneData
        case price = "USD"
        case autoData

        case maker = "markName"
        case model = "modelName"
        case photoData
        case linkToView
        case title
    }
    
    enum AutoRiaPhoneDataKeys: String, CodingKey {
        case phone
    }
    
    enum AutoRiaAutoDataKeys: String, CodingKey {
        case description
        case autoId
        case year
        case race
        case fuelName
        case gearboxName
    }
    
    enum AutoRiaPhotoDataKeys: String, CodingKey {
        case seoLinkM
        case seoLinkSX
        case seoLinkB
        case seoLinkF
    }
    
    
    
    init(from decoder: Decoder) throws {
        
        guard let key = CodingUserInfoKey(rawValue: "site"),
        let value = decoder.userInfo[key],
        let site = value as? Site else {
            throw SiteError.unknownSite
        }
        
        switch site {
        case .carAPI:

            let values = try decoder.container(keyedBy: SiteCarAPICodingKeys.self)
            year = try values.decode(Int.self, forKey: .year)
            id = try values.decode(Int.self, forKey: .id)
            power = try values.decode(Int.self, forKey: .power)
            maker = try values.decode(String.self, forKey: .maker)
            model = try values.decode(String.self, forKey: .model)
            price = try values.decode(Int.self, forKey: .price)
            image = try values.decode(String.self, forKey: .image)
            
        case .autoria:
            
        let container = try decoder.container(keyedBy: SiteAutoRiaCodingKeys.self)
        location = try container.decode(String.self, forKey: .locationCityName)
        price = try container.decode(Int.self, forKey: .price)
        maker = try container.decode(String.self, forKey: .maker)
        model = try container.decode(String.self, forKey: .model)
        linkToView = try container.decode(String.self, forKey: .linkToView)
        title = try container.decode(String.self, forKey: .title)
        
        let autoDataContainer = try container.nestedContainer(keyedBy: AutoRiaAutoDataKeys.self, forKey: .autoData)
        description = try autoDataContainer.decode(String.self, forKey: .description)
        id =  try autoDataContainer.decode(Int.self, forKey: .autoId)
        year =  try autoDataContainer.decode(Int.self, forKey: .year)
        mileage =  try autoDataContainer.decode(String.self, forKey: .race)
        fuel =  try autoDataContainer.decode(String.self, forKey: .fuelName)
        transmission =  try autoDataContainer.decode(String.self, forKey: .gearboxName)
        
        let userPhoneDataContainer = try container.nestedContainer(keyedBy: AutoRiaPhoneDataKeys.self, forKey: .userPhoneData)
        userPhone = try userPhoneDataContainer.decode(String.self, forKey: .phone)
        
        let autoPhotoDataContainer = try container.nestedContainer(keyedBy: AutoRiaPhotoDataKeys.self, forKey: .photoData)
        image = try autoPhotoDataContainer.decode(String.self, forKey: .seoLinkB)
            
        }
//        case .olx:
//            print("olx")
//        case .allegro:
//            print("allegro")
//        }
    }
}


struct AutoRiaData: Decodable, Hashable {
    var ids: [String]

    enum ResultCodingKey: String, CodingKey {
        case result
    }
    
    enum SearchCodingKey: String, CodingKey {
        case searchResult = "search_result"
    }
    
    enum IdsCodingKey: String, CodingKey {
        case ids
    }
    
    init(from decoder: Decoder) throws {
        let resultContainer = try decoder.container(keyedBy: ResultCodingKey.self)
        let searchContainer = try resultContainer.nestedContainer(keyedBy: SearchCodingKey.self, forKey: .result)
        let idsContainer = try searchContainer.nestedContainer(keyedBy: IdsCodingKey.self, forKey: .searchResult)
        ids = try idsContainer.decode([String].self, forKey: .ids)
        
    }
}

struct Transport: Identifiable, Hashable {
    var id = UUID().uuidString
    var manufacturer: String
    var model: String
    var price: String
    var mileage: String
    var year: String
    var fuel: FuelType
    var transmission: String
    var location: String
    var image: String
    var icon: String
}
