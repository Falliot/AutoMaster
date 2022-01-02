//
//  SearchViewModel.swift
//  AutoMaster
//
//  Created by Anton Pustovidko on 06/12/2021.
//

import SwiftUI
import Alamofire

class Maker: Identifiable {
    internal init(make: String, image: String, isSelected: Bool = false, index: String) {
        self.make = make
        self.image = image
        self.isSelected = isSelected
        self.index = index
    }
    
    let id = UUID().uuidString
    let make: String
    let image: String
    var isSelected: Bool
    var index: String
}

class SearchViewModel: ObservableObject {
    
    @Published var selectedBodyTypes: [Maker] = []
    @Published var selectedFuelTypes: [FuelType] = []
    @Published var selectedColors: [InteriorColor] = []
    
    let maker: [Maker] = [
        Maker(make: "BMW", image: "bmwIcon", index: "9"),
        Maker(make: "Audi", image: "audiIcon", index: "6"),
        Maker(make: "Mercedes", image: "mercedesIcon", index: "48"),
        Maker(make: "Volkswagen", image: "volkswagenIcon", index: "84"),
        Maker(make: "Renault", image: "renaultIcon", index: "62"),
        Maker(make: "Opel", image: "opelIcon", index: "56"),
        Maker(make: "Fiat", image: "fiatIcon", index: "23"),
        Maker(make: "Ford", image: "fordIcon", index: "24")
    ]
    
    
    var bodyType: [Maker] = [
        Maker(make: "Sedan", image: "sedan", index: "3"),
        Maker(make: "Hatchback", image: "hatchback", index: "4"),
        Maker(make: "Coupe", image: "coupe", index: "6"),
        Maker(make: "SUV", image: "suv", index: "5"),
        Maker(make: "Van", image: "van", index: "254"),
        Maker(make: "Pickup", image: "pickup", index: "9"),
        Maker(make: "Convertible", image: "convertible", index: "7")
    ]
}
