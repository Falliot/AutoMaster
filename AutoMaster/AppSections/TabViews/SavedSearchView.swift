//
//  SavedSearchView.swift
//  AutoMaster
//
//  Created by Anton on 07.11.2021.
//

import SwiftUI

struct SavedSearchView: View {
//    @EnvironmentObject var sharedData: SharedDataModel
    
    @State var showDeleteOption: Bool = false
    @State private var notification = false

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Saved searches")
                    .font(.system(size: 23, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Spacer()
                
                Button {
                    withAnimation {
                        showDeleteOption.toggle()
                    }
                } label:  {
                    Text("Edit")
                          .font(.system(size: 17, weight: .semibold, design: .rounded))
                          .foregroundColor(.white)
                }
            }
            .padding(10)
            .padding(.horizontal, 15)
            .padding(.bottom, 10)
            .background(Color("Green"))
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
//                    if sharedData.likedTransports.isEmpty {
//                        Group {
//                            Image("noSavedSearch")
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .padding()
//                                .padding(.top, 35)
//
//                            Text("No saved search yet")
//                                .font(.system(size: 25, weight: .semibold, design: .rounded))
//                                .foregroundColor(Color("Green"))
//
//                            Text("Hit the star button after search search to save favorite ones.")
//                                .font(.system(size: 18, weight: .regular, design: .rounded))
//                                .foregroundColor(.gray)
//                                .padding(.horizontal, 50)
//                                .padding(.top, 10)
//                                .multilineTextAlignment(.center)
//                        }
//                    } else {
                    //MARK: - Displaying searches
                    VStack(spacing: 15) {
//                        ForEach(sharedData.likedTransports) { transport in
                            HStack(spacing: 0) {
                                if showDeleteOption {
                                    Button {
//                                        sharedData.deleteFavorite(transport)
                                    } label: {
                                        Image(systemName: "minus.circle.fill")
                                            .font(.title2)
                                            .foregroundColor(.red)
                                    }
                                    .padding(.trailing)
                                }
                                
                                SavedView()
                                    .frame(maxWidth: getRect().width, alignment: .center)
                            }
//                        }
//                    }
                    .padding(.top, 25)
                    .padding(.horizontal)
                }
                    
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color("HomeBG")
                    .ignoresSafeArea()
            )
        }
    }

    
    @ViewBuilder
    func SavedView() -> some View {
        VStack {
            VStack(alignment: .leading, spacing: 0) {
                
                Group {
                    Text("to 2021 - Poland")
                        .font(.system(size: 19, weight: .semibold, design: .rounded))
                        .padding(.vertical)
                    HStack {
                        Text("First registration:")
                            .font(.system(size: 17, weight: .regular, design: .rounded))
                        Text("to 2021")
                            .font(.system(size: 17, weight: .semibold, design: .rounded))
                    }
                    HStack {
                        Text("Location:")
                            .font(.system(size: 17, weight: .regular, design: .rounded))
                        Text("Poland")
                            .font(.system(size: 17, weight: .semibold, design: .rounded))
                            .padding(.bottom, 10)
                    }
                }
                .padding(.horizontal, 15)
                
                Divider()
                
                
                Toggle(isOn: $notification) {
                    Text("Notification")
                        .font(.system(size: 17, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .padding(10)
                .background(Color("Green"))
                .cornerRadius(25, corners: [.bottomLeft, .bottomRight])
            }
            .background(
                Color.white.cornerRadius(25)
            )
            .padding([.horizontal, .bottom], 15)
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
