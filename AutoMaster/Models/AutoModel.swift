//
//  AutoModel.swift
//  AutoMaster
//
//  Created by Anton on 17.11.2021.
//

import UIKit

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
    var images: [Int]?
    
    //MARK: - AutoRia Specific
    var title: String?
    var driveName: String?
    var linkToView: String?
    var subCategoryName: String?
    var description: String?
    
    var userPhone: String?
    
    var colorName: String?
    var engColorName: String?
    var hexColorName: String?
    
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
        case color
        case linkToView
        case subCategoryName
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
        case driveName
    }
    
    enum AutoRiaColorDataKeys: String, CodingKey {
        case name
        case eng
        case hex
    }
    
    enum AutoRiaPhotoDataKeys: String, CodingKey {
        case all
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
            location = try container.decodeIfPresent(String.self, forKey: .locationCityName) ?? "Unknown"
            price = try container.decodeIfPresent(Int.self, forKey: .price) ?? 0
            maker = try container.decodeIfPresent(String.self, forKey: .maker) ?? "Unknown"
            model = try container.decodeIfPresent(String.self, forKey: .model) ?? "Unknown"
            linkToView = try container.decodeIfPresent(String.self, forKey: .linkToView) ?? "None"
            subCategoryName = try container.decodeIfPresent(String.self, forKey: .subCategoryName) ?? "Unknown"
            title = try container.decodeIfPresent(String.self, forKey: .title) ?? "Unknown"
            
            let autoDataContainer = try container.nestedContainer(keyedBy: AutoRiaAutoDataKeys.self, forKey: .autoData)
            description = try autoDataContainer.decodeIfPresent(String.self, forKey: .description) ?? "No details"
            id =  try autoDataContainer.decodeIfPresent(Int.self, forKey: .autoId) ?? 0
            year =  try autoDataContainer.decodeIfPresent(Int.self, forKey: .year) ?? 0
            mileage =  try autoDataContainer.decodeIfPresent(String.self, forKey: .race) ?? "Unknown"
            fuel =  try autoDataContainer.decodeIfPresent(String.self, forKey: .fuelName) ?? "Unknown"
            transmission =  try autoDataContainer.decodeIfPresent(String.self, forKey: .gearboxName) ?? "Unknown"
            driveName = try autoDataContainer.decodeIfPresent(String.self, forKey: .driveName) ?? "Unknown"
            
            let colorDataContainer = try container.nestedContainer(keyedBy: AutoRiaColorDataKeys.self, forKey: .color)
            colorName = try colorDataContainer.decodeIfPresent(String.self, forKey: .name) ?? "Unknown"
            engColorName = try colorDataContainer.decodeIfPresent(String.self, forKey: .eng) ?? "Unknown"
            hexColorName = try colorDataContainer.decodeIfPresent(String.self, forKey: .hex) ?? "Unknown"
            
            
            let userPhoneDataContainer = try container.nestedContainer(keyedBy: AutoRiaPhoneDataKeys.self, forKey: .userPhoneData)
            userPhone = try userPhoneDataContainer.decodeIfPresent(String.self, forKey: .phone) ?? "Unknown"
            
            let autoPhotoDataContainer = try container.nestedContainer(keyedBy: AutoRiaPhotoDataKeys.self, forKey: .photoData)
            image = try autoPhotoDataContainer.decodeIfPresent(String.self, forKey: .seoLinkB) ?? "Unknown"
            images = try autoPhotoDataContainer.decodeIfPresent([Int].self, forKey: .all) ?? []
            
        }
        //        case .olx:
        //            print("olx")
        //        case .allegro:
        //            print("allegro")
        //        }
    }
}


//MARK: - Cars Photos
struct AutoRiaPhotoData: Decodable {
    let formats: [String]
}

struct AutoRiaCarIdPhotoResponse: Decodable {
    let photos: [String:[String: AutoRiaPhotoData]]
    
    private enum CodingKeys: String, CodingKey {
        case photos = "data"
    }
}
//cXVCdZeOo2uYeYyunKBEGFiqootf7wOlBYdi9eYd

//MARK: - Cars Ids
struct AutoRiaData: Decodable, Hashable {
    var ids: [String]
    var count: Int
    
    enum ResultCodingKey: String, CodingKey {
        case result
    }
    
    enum SearchCodingKey: String, CodingKey {
        case searchResult = "search_result"
    }
    
    enum IdsCodingKey: String, CodingKey {
        case ids
        case count
    }
    
    init(from decoder: Decoder) throws {
        let resultContainer = try decoder.container(keyedBy: ResultCodingKey.self)
        let searchContainer = try resultContainer.nestedContainer(keyedBy: SearchCodingKey.self, forKey: .result)
        let idsContainer = try searchContainer.nestedContainer(keyedBy: IdsCodingKey.self, forKey: .searchResult)
        ids = try idsContainer.decode([String].self, forKey: .ids)
        count = try idsContainer.decode(Int.self, forKey: .count)
    }
}


extension TransportModel {
    var icon: String {
        return maker!
    }
}
