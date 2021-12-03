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
}
