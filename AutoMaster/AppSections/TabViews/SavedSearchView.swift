//
//  SavedSearchView.swift
//  AutoMaster
//
//  Created by Anton on 07.11.2021.
//

import SwiftUI

struct SavedSearchView: View {
//    @EnvironmentObject var sharedData: SharedDataModel
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Saved searches")
                    .font(.system(size: 23, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding(10)
            .padding(.horizontal, 15)
            .padding(.bottom, 10)
            .background(Color("Green"))
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
//                    if sharedData.likedTransports.isEmpty {
                        Group {
                            Image("noSavedSearch")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding()
                                .padding(.top, 35)
                            
                            Text("No saved search yet")
                                .font(.system(size: 25, weight: .semibold, design: .rounded))
                                .foregroundColor(Color("Green"))
                            
                            Text("Hit the star button after search search to save favorite ones.")
                                .font(.system(size: 18, weight: .regular, design: .rounded))
                                .foregroundColor(.gray)
                                .padding(.horizontal, 50)
                                .padding(.top, 10)
                                .multilineTextAlignment(.center)
                        }
//                    }
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color("HomeBG")
                    .ignoresSafeArea()
            )
        }
    }
    
}

struct SavedSearchView_Previews: PreviewProvider {
    static var previews: some View {
        SavedSearchView()
            .environmentObject(SharedDataModel())
            .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
    }
}
