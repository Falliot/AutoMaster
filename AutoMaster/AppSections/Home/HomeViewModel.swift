//
//  HomeViewModel.swift
//  AutoMaster
//
//  Created by Anton on 07.11.2021.
//

import Alamofire
import Foundation

// cXVCdZeOo2uYeYyunKBEGFiqootf7wOlBYdi9eYd

class HomeViewModel: ObservableObject, Identifiable {
    @Published var manufacturerModel: [ManufacturerModel] = []

    func request() {
        AF.request("https://private-anon-30d4671a7c-carsapi1.apiary-mock.com/manufacturers")
            .validate()
            .responseDecodable(of: [ManufacturerModel].self) { response in
                guard let cars = response.value else {
                    print(response.debugDescription)
                    return
                }
                self.manufacturerModel = cars
                print(cars)
            }
    }
}
