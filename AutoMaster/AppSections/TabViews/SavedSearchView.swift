//
//  SavedSearchView.swift
//  AutoMaster
//
//  Created by Anton on 07.11.2021.
//

import SwiftUI

struct SavedSearchView: View {
    @ObservedObject var viewModel = SavedSearchViewModel()

    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            Image("searchCar")
                .resizable()
                .frame(width: 250, height: 250, alignment: .center)
            Text("No saved searches")
                .font(.system(size: 25, weight: .semibold, design: .rounded))
        }
    }
}

struct SavedSearchView_Previews: PreviewProvider {
    static var previews: some View {
        SavedSearchView()
    }
}
