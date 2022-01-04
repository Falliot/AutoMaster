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
        static let allegroAccessToken = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzY29wZSI6WyJhbGxlZ3JvOmFwaTpvcmRlcnM6cmVhZCIsImFsbGVncm86YXBpOnByb2ZpbGU6d3JpdGUiLCJhbGxlZ3JvOmFwaTpzYWxlOm9mZmVyczp3cml0ZSIsImFsbGVncm86YXBpOmJpbGxpbmc6cmVhZCIsImFsbGVncm86YXBpOmNhbXBhaWducyIsImFsbGVncm86YXBpOmRpc3B1dGVzIiwiYWxsZWdybzphcGk6c2FsZTpvZmZlcnM6cmVhZCIsImFsbGVncm86YXBpOmJpZHMiLCJhbGxlZ3JvOmFwaTpvcmRlcnM6d3JpdGUiLCJhbGxlZ3JvOmFwaTphZHMiLCJhbGxlZ3JvOmFwaTpwYXltZW50czp3cml0ZSIsImFsbGVncm86YXBpOnNhbGU6c2V0dGluZ3M6d3JpdGUiLCJhbGxlZ3JvOmFwaTpwcm9maWxlOnJlYWQiLCJhbGxlZ3JvOmFwaTpyYXRpbmdzIiwiYWxsZWdybzphcGk6c2FsZTpzZXR0aW5nczpyZWFkIiwiYWxsZWdybzphcGk6cGF5bWVudHM6cmVhZCIsImFsbGVncm86YXBpOm1lc3NhZ2luZyJdLCJhbGxlZ3JvX2FwaSI6dHJ1ZSwiZXhwIjoxNjM5NjQyODI0LCJqdGkiOiI5ZGI5ZGE3Zi02OGViLTQyMDEtYmRmZi1jZTk0ZGUyMjczMGEiLCJjbGllbnRfaWQiOiJmZGYzZWFiZTgyNjQ0ZjFjOTI1ZDE5NDhlNDc0ZTU0OCJ9.FTbAcQo-OXWpl42C-0j7S_uXUGBTkdVW9gdtqGf9GC8NJGTg5nuyX1Ncjx2xneTfVMnyrRh_VZa9qW-8TVdzFD1JM9Fi3zU992hAsCWpJn3TkZNFJkYud-ao7uPXrwbzz55Kn-j5WUvZW8FdlnUGUZw2lUfOkNAW0FUjtH_0pAXw6ij32m-hh3DMfrZ-_OUAn9USw0jx1WeYVfTiYxoPS1FKPin3fDSRzwJrKgc6gyaEM8g_m2ZstxOKGwAZJeix7guVIa9X8F_qQWYOyOu2i4WISctbwi9Qj9cgFifdCFmipR8NmYHVtM0wNBqCyNu-p4ys5V4c4l-V0s2R1CW1MGyZL-rTrMr4U5BCcyG-1oPeIOvzng60CpsLL48dHjKrdVS_4Fke0OGxW2o1YJkYw7HQ7FH4clueobwYuOgqvU7fiB-ysGVm01ZQ7B8Jdak7oY-SF3FqOd7STbNvPFp9J_mkYRthcH-xxpGXtEPxTAghaWr8WWPMtKm2gavPhkZWAgPqDiYYD5HaMOfT52dHBvwCPdToOoSczx7jt6bD8QiYsK3eyO7C_BiTbTdCG5R3fJCAZuR4zIx9KXrOc1LcsoSOk_XTrIm0HfpJa0XnX3NZNmNaCg6Rhw7GZnnPZdhWbfUm0WbyBYdvib2Iu7IU_WRPhws8oeIP1fzY53jHCC0"
    }
    
    struct Endpoints {
        static let carsAPI = "https://private-anon-aae480db7d-carsapi1.apiary-mock.com/cars"
        static let lebonCoin = "https://leboncoin1.p.rapidapi.com/api/v1/leboncoin/search_api"
        static let mobileDe = "https://services.mobile.de/search-api/ad/{ad-key}"

        static let autoRia = "https://developers.ria.com/auto/search?api_key=\(APIKeys.autoRiaAPI)&bodystyle=2&bodystyle=3&bodystyle=4&price_ot=1000&price_do=60000&with_photo=1&countpage=30"//50"
        
        static let autoRiaSearch = "https://developers.ria.com/auto/search?api_key=\(APIKeys.autoRiaAPI)"
        static let autoRiaSingle = "https://developers.ria.com/auto/info?api_key=\(APIKeys.autoRiaAPI)&auto_id="
        static let autoRiaCarPhotos = "https://developers.ria.com/auto/fotos/"
    }
}
