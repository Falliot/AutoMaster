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
                    Label("Home", systemImage: "car")
                }
                .tag(TabItem.home)

            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tag(TabItem.search)

            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
                .tag(TabItem.favorites)

            MenuView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
                .tag(TabItem.menu)
        }
        .accentColor(.green)
    }
}

struct PaggingView_Previews: PreviewProvider {
    static var previews: some View {
        PaggingView()
    }
}
