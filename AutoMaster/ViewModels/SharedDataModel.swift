//
//  SharedDataModel.swift
//  AutoMaster
//
//  Created by Anton Pustovidko on 03/12/2021.
//

import SwiftUI
import RealmSwift

class SharedDataModel: ObservableObject {
    @Published var detailTransport: TransportModel?
    @Published var showDetailTransport: Bool = false
    
    @Published var transportCopy: TransportDetailsShort = TransportDetailsShort()
    @Published var searchCopy: SavedSearch = SavedSearch()
    
    var opelIcons = ["opelImg", "opelImg1", "opelImg2", "opelImg3", "opelImg4", "opelImg5"]
    
    var isHidden: Bool = false {
        willSet {
            objectWillChange.send()
        }
    }
    
    // TODO: FIX TO GENERICS for both liked transports and search
        
    func isLiked(_ object: Results<TransportDetailsShort>, _ savedTransport: TransportModel) -> Bool {
        object.contains(where: { transport in
            savedTransport.id == transport.transportId
        })
    }
    
    func addToLiked(_ object: Results<TransportDetailsShort>, _ observableObject: ObservedResults<TransportDetailsShort>, _ savedTransport: TransportModel) {
        
        if object.contains(where: { transport in
            self.transportCopy = transport
            return savedTransport.id == transport.transportId
        }) {
            observableObject.remove(self.transportCopy)
        } else {
            if !object.contains(where: { trans in
                savedTransport.id == trans.transportId
            }) {
                observableObject.append(TransportDetailsShort(
                    value:
                        [
                            "transportId" : savedTransport.id!,
                            "imageURL" : savedTransport.image!,
                            "year" : String(savedTransport.year!),
                            "maker" : savedTransport.maker!,
                            "price" : String(savedTransport.price!),
                            "mileage" : savedTransport.mileage!,
                            "location" : savedTransport.location!,
                        ])
                )
            }
        }
    }
    
    func deleteFavoriteTransport(_ observableObject: ObservedResults<TransportDetailsShort>, _ savedTransport: TransportDetailsShort) {
        observableObject.remove(savedTransport)
    }
    
    func addToLikedSearch(_ object: Results<SavedSearch>, _ observableObject: ObservedResults<SavedSearch>, year: String, manufacturer: String, model: String, color: String) {
        
//        if object.contains(where: { search in
//            self.searchCopy = search
//            return savedSearch.id == search.id
//        }) {
//            observableObject.remove(self.searchCopy)
//        } else {
//            if !object.contains(where: { search in
//                savedSearch.id == search.id
//            }) {
                observableObject.append(SavedSearch(
                    value:
                        [
                            "year" : year,
                            "manufacturer" : manufacturer,
                            "model" : model,
                            "country" : "Poland",
                            "color" : color,
                        ])
                )
//            }
//        }
    }
    
    func deleteFavoriteSearch(_ observableObject: ObservedResults<SavedSearch>, _ savedSearch: SavedSearch) {
        observableObject.remove(savedSearch)
    }
}
