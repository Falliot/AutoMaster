//
//  PaggingViewModel.swift
//  AutoMaster
//
//  Created by Anton Pustovidko on 01/12/2021.
//

import SwiftUI
import Combine

class PaggingViewModel: ObservableObject {
    var isHidden: Bool = false {
        willSet {
            objectWillChange.send()
        }
    }
}
