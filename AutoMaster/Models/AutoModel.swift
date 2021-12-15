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


extension TransportModel {
    var icon: String {
        return maker!
//        switch maker {
//        case "9ff":
//            return "9ff"
//        case "Abadal":
//            return "Abadal"
//        case "Abarth":
//            return "Abarth"
//        case "ABT":
//            return "ABT"
//        case "AC":
//            return "AC"
//        case "Acura":
//            return "Acura"
//        case "Aixam":
//            return "Aixam"
//        case "Alfa Romeo":
//            return "Alfa Romeo"
//        case "Alpina":
//            return "Alpina"
//        case "Alpine":
//            return "Alpine"
//        case "Alvis":
//            return "Alvis"
//        case "American Motors":
//            return "American Motors"
//        case "AMG":
//            return "AMG"
//        case "Apollo":
//            return "Apollo"
//        case "Arash":
//            return "Arash"
//        case "Arcfox":
//            return "Arcfox"
//        case "Ariel":
//            return "Ariel"
//        case "ARO":
//            return "ARO"
//        case "Arrinera":
//            return "Arrinera"
//        case "Arrival":
//            return "Arrival"
//        case "Artega":
//            return "Artega"
//        case "Ascari":
//            return "Ascari"
//        case "Askam":
//            return "Askam"
//        case "Aspark":
//            return "Aspark"
//        case "Aston Martin":
//            return "Aston Martin"
//        case "Atalanta Motors":
//            return "Atalanta Motors"
//        case "Audi":
//            return "Audi"
//        case "Austin":
//            return "Austin"
//        case "Autobacs":
//            return "Autobacs"
//        case "Autobianchi":
//            return "Autobianchi"
//        case "Axon":
//            return "Axon"
//        case "BAC":
//            return "BAC"
//        case "BAIC Motor":
//            return "BAIC Motor"
//        case "Baojun":
//            return "Baojun"
//        case "Beiben":
//            return "Beiben"
//        case "Bentley":
//            return "Bentley"
//        case "Berliet":
//            return "Berliet"
//        case "Bertone":
//            return "Bertone"
//        case "Bestune":
//            return "Bestune"
//        case "BharatBenz":
//            return "BharatBenz"
//        case "Bitter":
//            return "Bitter"
//        case "BMW M":
//            return "BMW M"
//        case "BMW":
//            return "BMW"
//        case "Borgward":
//            return "Borgward"
//        case "Bowler":
//            return "Bowler"
//        case "Brabus":
//            return "Brabus"
//        case "Brammo":
//            return "Brammo"
//        case "Brilliance":
//            return "Brilliance"
//        case "Brooke":
//            return "Brooke"
//        case "Bufori":
//            return "Bufori"
//        case "Bugatti":
//            return "Bugatti"
//        case "Buick":
//            return "Buick"
//        case "BYD":
//            return "BYD"
//        case "Byton":
//            return "Byton"
//        case "Cadillac":
//            return "Cadillac"
//        case "Camc":
//            return "Camc"
//        case "Canoo":
//            return "Canoo"
//        case "Caparo":
//            return "Caparo"
//        case "Carlsson":
//            return "Carlsson"
//        case "Caterham":
//            return "Caterham"
//        case "Changan":
//            return "Changan"
//        case "Changfeng":
//            return "Changfeng"
//        case "Chery":
//            return "Chery"
//        case "Chevrolet":
//            return "Chevrolet"
//        case "Chrysler":
//            return "Chrysler"
//        case "Citroen":
//            return "Citroen"
//        case "Cizeta":
//            return "Cizeta"
//        case "Corvette":
//            return "Corvette"
//        case "Dacia":
//            return "Dacia"
//        case "Daewoo":
//            return "Daewoo"
//        case "DAF":
//            return "DAF"
//        case "Daihatsu":
//            return "Daihatsu"
//        case "Daimler":
//            return "Daimler"
//        case "Datsun":
//            return "Datsun"
//        case "David Brown":
//            return "David Brown"
//        case "Dayun":
//            return "Dayun"
//        case "Delage":
//            return "Delage"
//        case "Desoto":
//            return "Desoto"
//        case "Detroit Electric":
//            return "Detroit Electric"
//        case "Devel Sixteen":
//            return "Devel Sixteen"
//        case "DINA":
//            return "DINA"
//        case "Dodge":
//            return "Dodge"
//        case "Dongfeng":
//            return "Dongfeng"
//        case "Donkervoort":
//            return "Donkervoort"
//        case "Drako":
//            return "Drako"
//        case "DS":
//            return "DS"
//        case "Duesenberg":
//            return "Duesenberg"
//        case "Eagle":
//            return "Eagle"
//        case "EDAG":
//            return "EDAG"
//        case "Edsel":
//            return "Edsel"
//        case "Eicher":
//            return "Eicher"
//        case "Elemental":
//            return "Elemental"
//        case "Englon":
//            return "Englon"
//        case "ERF":
//            return "ERF"
//        case "Exeed":
//            return "Exeed"
//        case "Faraday":
//            return "Faraday"
//        case "FAW":
//            return "FAW"
//        case "Ferrari":
//            return "Ferrari"
//        case "Fiat":
//            return "Fiat"
//        case "Fisker":
//            return "Fisker"
//        case "Foden":
//            return "Foden"
//        case "Force":
//            return "Force"
//        case "Ford":
//            return "Ford"
//        case "Foton":
//            return "Foton"
//        case "Freightliner":
//            return "Freightliner"
//        case "FSO":
//            return "FSO"
//        case "GAC":
//            return "GAC"
//        case "Gardner Douglas":
//            return "Gardner Douglas"
//        case "GAZ":
//            return "GAZ"
//        case "Geely":
//            return "Geely"
//        case "General Motors":
//            return "General Motors"
//        case "Genesis":
//            return "Genesis"
//        case "Geo":
//            return "Geo"
//        case "Geometry":
//            return "Geometry"
//        case "Ginetta":
//            return "Ginetta"
//        case "GMC":
//            return "GMC"
//        case "Golden":
//            return "Golden"
//        case "Gonow":
//            return "Gonow"
//        case "Great Wall":
//            return "Great Wall"
//        case "Grinnall":
//            return "Grinnall"
//        case "GT-R":
//            return "GT-R"
//        case "GTA Motor":
//            return "GTA Motor"
//        case "Gumpert":
//            return "Gumpert"
//        case "Hafei":
//            return "Hafei"
//        case "Haima":
//            return "Haima"
//        case "Haval":
//            return "Haval"
//        case "Hawtai":
//            return "Hawtai"
//        case "Hennessey":
//            return "Hennessey"
//        case "Higer":
//            return "Higer"
//        case "Hino":
//            return "Hino"
//        case "Holden":
//            return "Holden"
//        case "Hommell":
//            return "Hommell"
//        case "Honda":
//            return "Honda"
//        case "Hongqi":
//            return "Hongqi"
//        case "Hongyan":
//            return "Hongyan"
//        case "Horch":
//            return "Horch"
//        case "HSV":
//            return "HSV"
//        case "Hudson":
//            return "Hudson"
//        case "Hummer":
//            return "Hummer"
//        case "Hyundai":
//            return "Hyundai"
//        case "IC Bus":
//            return "IC Bus"
//        case "Infiniti":
//            return "Infiniti"
//        case "International Harvester":
//            return "International Harvester"
//        case "International Trucks":
//            return "International Trucks"
//        case "Iran Khodro":
//            return "Iran Khodro"
//        case "Irizar":
//            return "Irizar"
//        case "Iso":
//            return "Iso"
//        case "Isuzu":
//            return "Isuzu"
//        case "Iveco":
//            return "Iveco"
//        case "JAC Motors":
//            return "JAC Motors"
//        case "Jaguar":
//            return "Jaguar"
//        case "JBA Motors":
//            return "JBA Motors"
//        case "Jeep":
//            return "Jeep"
//        case "Jetta":
//            return "Jetta"
//        case "Jiangling":
//            return "Jiangling"
//        case "Kamaz":
//            return "Kamaz"
//        case "Karlmann King":
//            return "Karlmann King"
//        case "Karma":
//            return "Karma"
//        case "Keating Supercars":
//            return "Keating Supercars"
//        case "Kenworth":
//            return "Kenworth"
//        case "Kia":
//            return "Kia"
//        case "King Long":
//            return "King Long"
//        case "Koenigsegg":
//            return "Koenigsegg"
//        case "KTM":
//            return "KTM"
//        case "Lada":
//            return "Lada"
//        case "Lagonda":
//            return "Lagonda"
//        case "Lamborghini":
//            return "Lamborghini"
//        case "Lancia":
//            return "Lancia"
//        case "Land Rover":
//            return "Land Rover"
//        case "Landwind":
//            return "Landwind"
//        case "Laraki":
//            return "Laraki"
//        case "Lexus":
//            return "Lexus"
//        case "Leyland":
//            return "Leyland"
//        case "Lifan":
//            return "Lifan"
//        case "Ligier":
//            return "Ligier"
//        case "Lincoln":
//            return "Lincoln"
//        case "Lister":
//            return "Lister"
//        case "Lixiang":
//            return "Lixiang"
//        case "Lloyd":
//            return "Lloyd"
//        case "Lobini":
//            return "Lobini"
//        case "London EV":
//            return "London EV"
//        case "Lordstown":
//            return "Lordstown"
//        case "Lotus":
//            return "Lotus"
//        case "Lucid":
//            return "Lucid"
//        case "Luxgen":
//            return "Luxgen"
//        case "Lynkco":
//            return "Lynkco"
//        case "Mack":
//            return "Mack"
//        case "Mahindra":
//            return "Mahindra"
//        case "MAN":
//            return "MAN"
//        case "Mansory":
//            return "Mansory"
//        case "Marlin":
//            return "Marlin"
//        case "Maserati":
//            return "Maserati"
//        case "Mastretta":
//            return "Mastretta"
//        case "Maxus":
//            return "Maxus"
//        case "Maybach":
//            return "Maybach"
//        case "MAZ":
//            return "MAZ"
//        case "Mazda":
//            return "Mazda"
//        case "Mazzanti-Automobili":
//            return "Mazzanti-Automobili"
//        case "McLaren":
//            return "McLaren"
//        case "Melkus":
//            return "Melkus"
//        case "Mercedes Benz":
//            return "Mercedes Benz"
//        case "Mercury":
//            return "Mercury"
//        case "Merkur":
//            return "Merkur"
//        case "MG":
//            return "MG"
//        case "Microcar":
//            return "Microcar"
//        case "Mills Extreme Vehicles":
//            return "Mills Extreme Vehicles"
//        case "Mini":
//            return "Mini"
//        case "Mitsubishi":
//            return "Mitsubishi"
//        case "Mitsuoka":
//            return "Mitsuoka"
//        case "MK Sportscars":
//            return "MK Sportscars"
//        case "Morgan":
//            return "Morgan"
//        case "Navistar":
//            return "Navistar"
//        case "Nevs":
//            return "Nevs"
//        case "Nikola":
//            return "Nikola"
//        case "Nio":
//            return "Nio"
//        case "Nismo":
//            return "Nismo"
//        case "Nissan":
//            return "Nissan"
//        case "Noble":
//            return "Noble"
//        case "Oldsmobile":
//            return "Oldsmobile"
//        case "Opel":
//            return "Opel"
//        case "Paccar":
//            return "Paccar"
//        case "Packard":
//            return "Packard"
//        case "Pagani":
//            return "Pagani"
//        case "Panoz":
//            return "Panoz"
//        case "Pegaso":
//            return "Pegaso"
//        case "Perodua":
//            return "Perodua"
//        case "Peterbilt":
//            return "Peterbilt"
//        case "Peugeot":
//            return "Peugeot"
//        case "Pininfarina":
//            return "Pininfarina"
//        case "Plymouth":
//            return "Plymouth"
//        case "Polestar":
//            return "Polestar"
//        case "Pontiac":
//            return "Pontiac"
//        case "Porsche":
//            return "Porsche"
//        case "Praga":
//            return "Praga"
//        case "Premier":
//            return "Premier"
//        case "Prodrive":
//            return "Prodrive"
//        case "Proton":
//            return "Proton"
//        case "Qoros":
//            return "Qoros"
//        case "Radical":
//            return "Radical"
//        case "RAM":
//            return "RAM"
//        case "Rambler":
//            return "Rambler"
//        case "Ranz":
//            return "Ranz"
//        case "Renault Samsung Motors":
//            return "Renault Samsung Motors"
//        case "Renault":
//            return "Renault"
//        case "Rezvani":
//            return "Rezvani"
//        case "Rimac":
//            return "Rimac"
//        case "Rinspeed":
//            return "Rinspeed"
//        case "Rivian":
//            return "Rivian"
//        case "Roewe":
//            return "Roewe"
//        case "Rolls Royce":
//            return "Rolls Royce"
//        case "Ronart":
//            return "Ronart"
//        case "Rossion":
//            return "Rossion"
//        case "Rover":
//            return "Rover"
//        case "Ruf":
//            return "Ruf"
//        case "Saab":
//            return "Saab"
//        case "SAIC Motor":
//            return "SAIC Motor"
//        case "Saipa":
//            return "Saipa"
//        case "Saturn":
//            return "Saturn"
//        case "Scania":
//            return "Scania"
//        case "Scion":
//            return "Scion"
//        case "SEAT":
//            return "SEAT"
//        case "Setra":
//            return "Setra"
//        case "Shacman":
//            return "Shacman"
//        case "Simca":
//            return "Simca"
//        case "Singulato":
//            return "Singulato"
//        case "Sinotruk":
//            return "Sinotruk"
//        case "Sisu":
//            return "Sisu"
//        case "Skoda":
//            return "Skoda"
//        case "Smart":
//            return "Smart"
//        case "Soueast":
//            return "Soueast"
//        case "Spirra":
//            return "Spirra"
//        case "Spyker":
//            return "Spyker"
//        case "SsangYong":
//            return "SsangYong"
//        case "SSC":
//            return "SSC"
//        case "Sterling":
//            return "Sterling"
//        case "Studebaker":
//            return "Studebaker"
//        case "Stutz":
//            return "Stutz"
//        case "Subaru":
//            return "Subaru"
//        case "Suffolk Sportscars":
//            return "Suffolk Sportscars"
//        case "Suzuki":
//            return "Suzuki"
//        case "Talbot":
//            return "Talbot"
//        case "Tata":
//            return "Tata"
//        case "Tatra":
//            return "Tatra"
//        case "TechArt":
//            return "TechArt"
//        case "Tesla":
//            return "Tesla"
//        case "Toyota Alphard":
//            return "Toyota Alphard"
//        case "Toyota Century":
//            return "Toyota Century"
//        case "Toyota Crown":
//            return "Toyota Crown"
//        case "Toyota":
//            return "Toyota"
//        case "Tramontana":
//            return "Tramontana"
//        case "Trion":
//            return "Trion"
//        case "Triumph":
//            return "Triumph"
//        case "Troller":
//            return "Troller"
//        case "Tucker":
//            return "Tucker"
//        case "TVR":
//            return "TVR"
//        case "UAZ":
//            return "UAZ"
//        case "UD Trucks":
//            return "UD Trucks"
//        case "Ultima":
//            return "Ultima"
//        case "Vauxhall":
//            return "Vauxhall"
//        case "Vector Motors":
//            return "Vector Motors"
//        case "Vencer":
//            return "Vencer"
//        case "Venucia":
//            return "Venucia"
//        case "Vinfast":
//            return "Vinfast"
//        case "Viper":
//            return "Viper"
//        case "Volkswagen":
//            return "Volkswagen"
//        case "Volvo":
//            return "Volvo"
//        case "W Motors":
//            return "W Motors"
//        case "Wanderer":
//            return "Wanderer"
//        case "Wartburg":
//            return "Wartburg"
//        case "Weltmeister":
//            return "Weltmeister"
//        case "Western Star":
//            return "Western Star"
//        case "Westfield":
//            return "Westfield"
//        case "Wey":
//            return "Wey"
//        case "Wiesmann":
//            return "Wiesmann"
//        case "Willys Overland":
//            return "Willys Overland"
//        case "Workhorse":
//            return "Workhorse"
//        case "Wuling":
//            return "Wuling"
//        case "Xpeng":
//            return "Xpeng"
//        case "Yulon":
//            return "Yulon"
//        case "Yutong":
//            return "Yutong"
//        case "ZAZ":
//            return "ZAZ"
//        case "Zenos Cars":
//            return "Zenos Cars"
//        case "Zenvo":
//            return "Zenvo"
//        case "Zhinuo":
//            return "Zhinuo"
//        case "Zhongtong":
//            return "Zhongtong"
//        case "Zotye":
//            return "Zotye"
//        case .none:
//            return ""
//        case .some(_):
//            return ""
//        }
    }
}
