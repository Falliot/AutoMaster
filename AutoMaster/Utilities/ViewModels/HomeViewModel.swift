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
    @Published var manufacturerModel: [ManufacturerModel] = []
    @Published var product: [Product] =
    [
        Product(manufacturer: "Opel", model: "Corsa", price: "1,000$", mileage: "54.300 km", year: "2001", fuel: "Petrol", transmission: "Manual", location: "Gliwice", image: "opel"),
        Product(manufacturer: "Mazda", model: "6", price: "3,600$", mileage: "154.300 km", year: "2009", fuel: "Diesel", transmission: "Auto", location: "Krakow", image: "mazda"),
        Product(manufacturer: "Audi", model: "A6", price: "3,000$", mileage: "104.300 km", year: "1998", fuel: "Petrol", transmission: "Manual", location: "Gliwice", image: "audi"),
        Product(manufacturer: "Fiat", model: "Panda", price: "600$", mileage: "234.300 km", year: "2004", fuel: "Petrol", transmission: "Manual", location: "Gliwice", image: "fiat"),
        Product(manufacturer: "Tesla", model: "Model 3", price: "45,700$", mileage: "24.300 km", year: "2019", fuel: "Electric", transmission: "Manual", location: "Gliwice", image: "tesla"),
        Product(manufacturer: "Ford", model: "Mustang", price: "21,000$", mileage: "54.300 km", year: "2001", fuel: "Petrol", transmission: "Manual", location: "Gliwice", image: "ford"),
    ]
    
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
