//
//  SharedDataModel.swift
//  AutoMaster
//
//  Created by Anton Pustovidko on 03/12/2021.
//

import SwiftUI

class SharedDataModel: ObservableObject {
    @Published var detailTransport: TransportModel?
    @Published var showDetailTransport: Bool = false
    
    var opelIcons = ["opelImg", "opelImg1", "opelImg2", "opelImg3", "opelImg4", "opelImg5"]
    
    @Published var likedTransports: [TransportModel] = []
    @Published var likedSearches: [SavedSearch] = []
    @Published var carIds: [Int] = []
    
    
    
    var isHidden: Bool = false {
        willSet {
            objectWillChange.send()
        }
    }
    
    // TODO: FIX TO GENERICS for both liked transports and search
    
    
    func isLiked(_ currentTransport: TransportModel) -> Bool {
        return likedTransports.contains { transport in
            return currentTransport.id == transport.id
        }
    }
    
    func addToLiked(_ currentTransport: TransportModel) {
        if let index =  likedTransports.firstIndex(where: { transport in
            return currentTransport.id == transport.id
        }) {
             likedTransports.remove(at: index)
        } else {
             likedTransports.append(currentTransport)
        }
    }
    
    func deleteFavorite(_ currentTransport: TransportModel) {
        if let index = likedTransports.firstIndex(where: { selectedTransport in
            return currentTransport.id == selectedTransport.id
        }) {
            let _ = withAnimation {
                likedTransports.remove(at: index)
            }
        }
    }
}
