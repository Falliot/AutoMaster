//
//  HomeViewModel.swift
//  AutoMaster
//
//  Created by Anton on 07.11.2021.
//

import Alamofire
import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published var searchActivated: Bool = false
    @Published var showDetailCar: Bool = false
    
    @Published var manufacturerModel: [ManufacturerModel] = []
    @Published var carModel: [TransportModel] = []
    
    @Published var transport: [Transport] =
    [
        Transport(manufacturer: "Opel", model: "Corsa", price: "1,000$", mileage: "54.300 km", year: "2001", fuel: .gasoline, transmission: "Manual", location: "Gliwice", image: "opel", icon: "opelIcon"),
        //        Transport(maker: "Mazda", model: "6", price: "3,600$", mileage: "154.300 km", year: "2009", fuel: .gasoline, transmission: "Auto", location: "Krakow", image: "mazda", icon: ""),
        Transport(manufacturer: "Audi", model: "A6", price: "3,000$", mileage: "104.300 km", year: "1998", fuel: .gasoline, transmission: "Manual", location: "Gliwice", image: "audi", icon: ""),
        Transport(manufacturer: "Fiat", model: "Panda", price: "600$", mileage: "234.300 km", year: "2004", fuel: .gasoline, transmission: "Manual", location: "Gliwice", image: "fiat", icon: ""),
        Transport(manufacturer: "Tesla", model: "Model 3", price: "45,700$", mileage: "24.300 km", year: "2019", fuel: .electric, transmission: "Manual", location: "Gliwice", image: "tesla", icon: "teslaIcon"),
        Transport(manufacturer: "Ford", model: "Mustang", price: "21,000$", mileage: "54.300 km", year: "2001", fuel: .gasoline, transmission: "Manual", location: "Gliwice", image: "ford", icon: "fordIcon"),
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
    
    func carsRequest() {
        AF.request(Constants.Endpoints.carsAPI)
            .validate()
            .responseData { [weak self] response in
                
                guard let cars = response.value else {
                    print(response.debugDescription)
                    return
                }
                
                let decoder = JSONDecoder()
                decoder.userInfo[CodingUserInfoKey(rawValue: "site")!] = TransportModel.Site.carAPI
                
                do {
                    let carsData = try decoder.decode([TransportModel].self, from: cars)
                    DispatchQueue.main.async {
                        self?.carModel = carsData
                    }
                } catch(let error) {
                    print(error)
                }
                
            }
    }
    
    func autoRiaRequest() {
        AF.request(Constants.Endpoints.autoRia)
            .validate()
            .responseDecodable(of: AutoRiaData.self) { response in
                guard let cars = response.value else {
                    print(response.debugDescription)
                    return
                }
                for id in cars.ids {
                    self.autoRiaSingleTransportRequest(carId: id)
                }
            }
    }
    
    func autoRiaSingleTransportRequest(carId: String) {
        AF.request(Constants.Endpoints.autoRiaSingle + "\(carId)")
            .validate()
            .responseData { [weak self] response in
                
                guard let car = response.value else {
                    print(response.debugDescription)
                    return
                }
                
                let decoder = JSONDecoder()
                decoder.userInfo[CodingUserInfoKey(rawValue: "site")!] = TransportModel.Site.autoria
                do {
                    let carData = try decoder.decode(TransportModel.self, from: car)
                    DispatchQueue.main.async {
                        self?.carModel.append(carData)
                    }
                } catch(let error) {
                    print(error)
                }
            }
    }
}