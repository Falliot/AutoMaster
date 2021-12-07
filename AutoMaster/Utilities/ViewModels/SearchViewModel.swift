//
//  SearchViewModel.swift
//  AutoMaster
//
//  Created by Anton Pustovidko on 06/12/2021.
//

import SwiftUI

class Maker: Identifiable {
    internal init(make: String, image: String, isSelected: Bool = false) {
        self.make = make
        self.image = image
        self.isSelected = isSelected
    }
    
    let id = UUID().uuidString
    let make: String
    let image: String
    var isSelected: Bool
    
}

class SearchViewModel: ObservableObject {
    
    @Published var selectedBodyTypes: [Maker] = []
    @Published var selectedFuelTypes: [FuelType] = []
    @Published var selectedColors: [InteriorColor] = []
    
    let maker: [Maker] = [
        Maker(make: "BMW", image: "bmwIcon"),
        Maker(make: "Audi", image: "audiIcon"),
        Maker(make: "Mercedes", image: "mercedesIcon"),
        Maker(make: "Volkswagen", image: "volkswagenIcon"),
        Maker(make: "Renault", image: "renaultIcon"),
        Maker(make: "Opel", image: "opelIcon"),
        Maker(make: "Fiat", image: "fiatIcon"),
        Maker(make: "Ford", image: "fordIcon")
    ]
    
    
    var bodyType: [Maker] = [
        Maker(make: "Sedan", image: "sedan"),
        Maker(make: "Hatchback", image: "hatchback"),
        Maker(make: "Coupe", image: "coupe"),
        Maker(make: "SUV", image: "suv"),
        Maker(make: "Van", image: "van"),
        Maker(make: "Pickup", image: "pickup"),
        Maker(make: "Convertible", image: "convertible")
    ]
}
