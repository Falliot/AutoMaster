//
//  FavoritesView.swift
//  AutoMaster
//
//  Created by Anton on 07.11.2021.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel = FavoritesViewModel()

    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            Image("favoriteCar")
                .resizable()
                .frame(width: 200, height: 200, alignment: .center)
            Text("Your favorites list is empty")
                .font(.system(size: 25, weight: .semibold, design: .rounded))
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
