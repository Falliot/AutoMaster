//
//  SearchView.swift
//  AutoMaster
//
//  Created by Anton Pustovidko on 01/12/2021.
//

import SwiftUI
import SwiftUIX

struct SearchView: View {
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var sharedData: SharedDataModel
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 20) {
                Button {
                    withAnimation(.easeIn) {
                        homeViewModel.searchActivated.toggle()
                        sharedData.isHidden.toggle()
                    }
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
//                        .foregroundColor(Color.black.opacity(0.7))
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                Text("Search")
                    .font(.system(size: 23, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
//                    .foregroundColor(Color.black.opacity(0.3))
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image("broom")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
//                        .foregroundColor(Color("Green"))
//                        .foregroundColor(Color.black.opacity(0.3))
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(10)
            .padding(.horizontal, 15)
            .padding(.bottom, 10)
            .background(Color("Green"))
//            .ignoresSafeArea()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(
            Color("HomeBG")
                .ignoresSafeArea(.all)
        )
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(HomeViewModel())
            .environmentObject(SharedDataModel())
    }
}
