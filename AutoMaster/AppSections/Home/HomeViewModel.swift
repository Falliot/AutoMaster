//
//  HomeViewModel.swift
//  AutoMaster
//
//  Created by Anton on 07.11.2021.
//

import Alamofire
import Foundation

// cXVCdZeOo2uYeYyunKBEGFiqootf7wOlBYdi9eYd

class HomeViewModel: ObservableObject {
    func request() {
//        AF.request("https://developers.ria.com/auto/search?api_key=cXVCdZeOo2uYeYyunKBEGFiqootf7wOlBYdi9eYd&PARAMETERS").response { response in
        AF.request("https://api.autoscout24.com/vehicles").response { response in
            debugPrint(response)
        }
    }
}
