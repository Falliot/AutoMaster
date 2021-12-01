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
    @EnvironmentObject var pagginViewModel: PaggingViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 20) {
                Button {
                    withAnimation(.easeIn) {
                        homeViewModel.searchActivated.toggle()
                        pagginViewModel.isHidden.toggle()
                    }
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
//                        .foregroundColor(Color.black.opacity(0.7))
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                Text("Search")
                    .font(.system(size: 30, weight: .semibold, design: .rounded))
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
            .padding([.horizontal, .top])
            .padding([.top, .bottom])
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
        HomeView()
    }
}
