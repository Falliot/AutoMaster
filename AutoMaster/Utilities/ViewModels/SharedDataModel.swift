//
//  SharedDataModel.swift
//  AutoMaster
//
//  Created by Anton Pustovidko on 03/12/2021.
//

import SwiftUI

class SharedDataModel: ObservableObject {
    @Published var detailTransport: Transport?
    @Published var showDetailTransport: Bool = false
    
    
    @Published var likedTransports: [Transport] = []
    
    var isHidden: Bool = false {
        willSet {
            objectWillChange.send()
        }
    }
    
    func isLiked(_ currentTransport: Transport) -> Bool {
        return likedTransports.contains { transport in
            return currentTransport.id == transport.id
        }
    }
    
    func addToLiked(_ currentTransport: Transport) {
        if let index =  likedTransports.firstIndex(where: { transport in
            return currentTransport.id == transport.id
        }) {
             likedTransports.remove(at: index)
        } else {
             likedTransports.append(currentTransport)
        }
    }
    
    func deleteFavorite(_ currentTransport: Transport) {
        if let index = likedTransports.firstIndex(where: { selectedTransport in
            return currentTransport.id == selectedTransport.id
        }) {
            let _ = withAnimation {
                likedTransports.remove(at: index)
            }
        }
    }
}
