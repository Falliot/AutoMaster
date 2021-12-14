//
//  Constants.swift
//  AutoMaster
//
//  Created by Anton on 07.11.2021.
//

import Foundation
import SwiftUI

struct Constants {
    struct Colors {
        static let any = (Color.clear, "Any")
        static let beige = (Color(red: 245, green: 245, blue: 220), "Beige")
        static let black = (Color.black, "Black")
        static let blue = (Color.blue, "Blue")
        static let bronze = (Color(red: 205, green: 127, blue: 50), "Bronze")
        static let brown = (Color.brown, "Brown")
        static let gold = (Color(red: 255, green: 215, blue: 0), "Gold")
        static let green = (Color.green, "Green")
        static let gray = (Color.gray, "Gray")
        static let orange = (Color.orange, "Orange")
        static let red = (Color.red, "Red")
        static let silver = (Color(red: 192, green: 192, blue: 192), "Silver")
        static let violet = (Color(red: 143, green: 0, blue: 255), "Violet")
        static let white = (Color.white, "White")
        static let yellow = (Color.yellow, "Yellow")
    }
    
    struct APIKeys {
        static let autoRiaAPI = "cXVCdZeOo2uYeYyunKBEGFiqootf7wOlBYdi9eYd"
    }
    
    struct Endpoints {
        static let carsAPI = "https://private-anon-aae480db7d-carsapi1.apiary-mock.com/cars"
        static let lebonCoin = "https://leboncoin1.p.rapidapi.com/api/v1/leboncoin/search_api"
        static let mobileDe = "https://services.mobile.de/search-api/ad/{ad-key}"
        static let autoRia = "https://developers.ria.com/auto/search?api_key=\(APIKeys.autoRiaAPI)&bodystyle=2&bodystyle=3&bodystyle=4&price_ot=1000&price_do=60000&with_photo=1&countpage=30"//50"
        static let autoRiaSingle = "https://developers.ria.com/auto/info?api_key=\(APIKeys.autoRiaAPI)&auto_id="
        static let autoRiaCarPhotos = "https://developers.ria.com/auto/fotos/"
    }
}
