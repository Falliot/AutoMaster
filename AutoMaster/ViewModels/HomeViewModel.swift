//
//  HomeViewModel.swift
//  AutoMaster
//
//  Created by Anton on 07.11.2021.
//

import Alamofire
import SwiftUI
import SwiftUIX

class HomeViewModel: ObservableObject {
    
    @Published var searchActivated: Bool = false
    @Published var showDetailCar: Bool = false
    
    @Published var carSearch: Bool = false
    
    @Published var manufacturerModel: [ManufacturerModel] = []
    
    @Published var carModel: [TransportModel] = []
    @Published var searchCars: [TransportModel] = []
    
    @Published var manufacturer: String = ""
    @Published var yearFrom: String = ""
    @Published var yearTo: String = ""
    @Published var priceFrom: String = ""
    @Published var priceTo: String = ""
    @Published var bodyTypes: [String] = []
    @Published var fuelTypes: [String] = []
    @Published var colors: [String] = []
    @Published var gearbox: [String] = []
    
    
    
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
                print(cars.count)
                for id in cars.ids {
                    self.autoRiaSingleTransportRequest(carId: id)
                }
            }
    }
    
    //    &category_id=1
    //    &bodystyle=3
    //    &bodystyle=2
    //    &marka_id=79
    //    &model_id=0
    //    &s_yers=2010
    //    &po_yers=2017
    //    &price_ot=1000
    //    &price_do=60000
    
    
    func autoRiaSearchRequest(parameters: String) {
        let urlString = Constants.Endpoints.autoRiaSearch + "\(parameters)&currency=1&with_photo=1&countpage=30"
        print(urlString)
        AF.request(urlString)
            .validate()
            .responseDecodable(of: AutoRiaData.self) { response in
                guard let cars = response.value else {
                    print(response.debugDescription)
                    return
                }
                self.carSearch = true
                print(cars.count)
                for id in cars.ids {
                    self.autoRiaSearhSingleTransport(carId: id)
                }
            }
    }
    
    func autoRiaSearhSingleTransport(carId: String) {
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
                        self?.searchCars.append(carData)
                    }
                } catch(let error) {
                    print(error)
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
extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        
        return prettyPrintedString
    }
}
