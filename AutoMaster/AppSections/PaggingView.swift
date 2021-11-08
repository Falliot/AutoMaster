//
//  PaggingView.swift
//  AutoMaster
//
//  Created by Anton on 07.11.2021.
//

import SwiftUI

struct PaggingView: View {
    enum TabItem {
        case home, search, favorites, menu
    }

    @State var selectedItem: TabItem = .home

    var body: some View {
        TabView(selection: $selectedItem) {
            HomeView()
                .tabItem {
                    Image(systemName: "1.circle.fill")
                    Text("🍌🍌")
                }
                .tag(TabItem.home)

            SearchView()
                .tabItem {
                    Image(systemName: "2.square.fill")
                    Text("🍏🍏")
                }
                .tag(TabItem.search)

            FavoritesView()
                .tabItem {
                    Image(systemName: "3.square.fill")
                    Text("🍑🍑")
                }
                .tag(TabItem.favorites)

            MenuView()
                .tabItem {
                    Image(systemName: "1.square.fill")
                    Text("🍑🍑")
                }
                .tag(TabItem.menu)
        }
    }
}

struct PaggingView_Previews: PreviewProvider {
    static var previews: some View {
        PaggingView()
    }
}
