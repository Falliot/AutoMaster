//
//  PaggingView.swift
//  AutoMaster
//
//  Created by Anton on 07.11.2021.
//

import SwiftUI

struct PaggingView: View {
    enum Tab: String, CaseIterable {
        case home = "home"
        case search = "search"
        case favorites = "favorites"
        case menu = "menu"
    }

    @State var currentTab: Tab = .home
    
    init() {
        UITabBar.appearance().isHidden = true
    }

    var body: some View {
        
        VStack(spacing: 0) {
            TabView(selection: $currentTab) {
                HomeView()
                    .tag(Tab.home)

                SearchView()
                    .tag(Tab.search)

                FavoritesView()
                    .tag(Tab.favorites)

                MenuView()
                    .tag(Tab.menu)
            }
            
            HStack(spacing: 0) {
                ForEach(Tab.allCases, id: \.self) { tab in
                    Button {
                        currentTab = tab
                    } label: {
                        Image(tab.rawValue)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .background(
                                Color("Green")
                                    .opacity(0.1)
                                    .cornerRadius(5)
                                    .blur(radius: 5)
                                    .padding(-7)
                                    .opacity(currentTab == tab ? 1 : 0)
                            )
                            .frame(maxWidth: .infinity)
                            .foregroundColor(currentTab == tab ? Color("Green") : Color.black.opacity(0.3))
                    }
                }
            }
            .padding([.horizontal, .top])
            .padding(.bottom, 10)
        }
    }
}

struct PaggingView_Previews: PreviewProvider {
    static var previews: some View {
        PaggingView()
    }
}
