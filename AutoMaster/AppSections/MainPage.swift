//
//  MainPage.swift
//  AutoMaster
//
//  Created by Anton on 07.11.2021.
//

import SwiftUI

struct MainPage: View {
    @Namespace var animation
    
    @State var currentTab: Tab = .home
    @StateObject var sharedData: SharedDataModel = SharedDataModel()
    
    init() {
        UITabBar.appearance().isHidden = true
    }

    var body: some View {
        
        VStack(spacing: 0) {
            TabView(selection: $currentTab) {
                HomeView(animation: animation)
//                    .environmentObject(viewModel)
                    .environmentObject(sharedData)
                    .tag(Tab.home)

                SavedSearchView()
                    .tag(Tab.search)

                LikedView()
                    .environmentObject(sharedData)
                    .tag(Tab.favorites)

                MenuView()
                    .tag(Tab.menu)
            }
            
            if !sharedData.isHidden {
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
        .background(Color("HomeBG").ignoresSafeArea())
        .overlay(
            ZStack{
                if let transport = sharedData.detailTransport, sharedData.showDetailTransport {
                    TransportDetailsView(animation: animation, transport: transport)
                        .environmentObject(sharedData)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
                }
            })
    }
}

struct PaggingView_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
