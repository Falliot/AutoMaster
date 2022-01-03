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
    
    var opelIcons = ["opelImg", "opelImg1", "opelImg2", "opelImg3", "opelImg4", "opelImg5"]
    
    @ObservedResults(TransportDetailsShort.self) var transportFetched
    @Published var transportCopy: TransportDetailsShort = TransportDetailsShort()
    
    @Published var likedSearches: [SavedSearch] = []
    @Published var carIds: [Int] = []
    
    
    
    var isHidden: Bool = false {
        willSet {
            objectWillChange.send()
        }
    }
    
    // TODO: FIX TO GENERICS for both liked transports and search
        
    func isLiked(_ object: Results<TransportDetailsShort>, _ currentTransport: TransportModel) -> Bool {
        object.contains(where: { transport in
            currentTransport.id == transport.transportId
        })
    }
    
    func addToLiked(_ object: Results<TransportDetailsShort>, _ observableObject: ObservedResults<TransportDetailsShort>, _ currentTransport: TransportModel) {
        
        if object.contains(where: { transport in
            self.transportCopy = transport
            return currentTransport.id == transport.transportId
        }) {
            observableObject.remove(self.transportCopy)
        } else {
            if !object.contains(where: { trans in
                currentTransport.id == trans.transportId
            }) {
                observableObject.append(TransportDetailsShort(
                    value:
                        [
                            "transportId" : currentTransport.id!,
                            "imageURL" : currentTransport.image!,
                            "year" : String(currentTransport.year!),
                            "maker" : currentTransport.maker!,
                            "price" : String(currentTransport.price!),
                            "mileage" : currentTransport.mileage!,
                            "location" : currentTransport.location!,
                        ])
                )
            }
        }
    }
    
    func deleteFavorite(_ observableObject: ObservedResults<TransportDetailsShort>, _ currentTransport: TransportDetailsShort) {
        observableObject.remove(currentTransport)
    }
}
