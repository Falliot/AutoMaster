//
//  LikedView.swift
//  AutoMaster
//
//  Created by Anton on 07.11.2021.
//

import SwiftUI

struct LikedView: View {
    @ObservedObject var viewModel = FavoritesViewModel()
    @EnvironmentObject var sharedData: SharedDataModel
    
    @State var showDeleteOption: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Favorites")
                    .font(.system(size: 29, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Spacer()
                
                Button {
                    withAnimation {
                        showDeleteOption.toggle()
                    }
                } label:  {
                    Image(systemName: "trash")
                        .font(.title2)
                        .foregroundColor(.red)
                        .padding(10)
                        .background(.white, in: Circle())
                }
                .opacity(sharedData.likedTransports.isEmpty ? 0 : 1)
            }
            .padding()
            .background(Color("Green"))
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    if sharedData.likedTransports.isEmpty {
                        Group {
                            Image("favorites1")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding()
                                .padding(.top, 35)
                            
                            Text("No favorites yes")
                                .font(.system(size: 25, weight: .semibold, design: .rounded))
                                .foregroundColor(Color("Green"))
                            
                            Text("Hit the like button on each transport page to save favorite ones.")
                                .font(.system(size: 18, weight: .regular, design: .rounded))
                                .foregroundColor(.gray)
                                .padding(.horizontal, 50)
                                .padding(.top, 10)
                                .multilineTextAlignment(.center)
                        }
                    } else {
                        //MARK: - Displaying transports
                        VStack(spacing: 15) {
                            ForEach(sharedData.likedTransports) { transport in
                                HStack(spacing: 0) {
                                    if showDeleteOption {
                                        Button {
                                            sharedData.deleteFavorite(transport)
                                        } label: {
                                            Image(systemName: "minus.circle.fill")
                                                .font(.title2)
                                                .foregroundColor(.red)
                                        }
                                        .padding(.trailing)
                                    }
                                    
                                    CardView(transport: transport)
                                        .frame(maxWidth: getRect().width, alignment: .center)
                                }
                            }
                        }
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
    func CardView(transport: Transport) -> some View {
        HStack(spacing: 15) {
            //MARK: - right side(image)
            Image(transport.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: getRect().width * 0.3)
                .cornerRadius(25)
            
            //MARK: - left side
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(transport.year)
                            .font(.system(size: 15, weight: .regular, design: .rounded))
                            .foregroundColor(.gray)
                        Text(transport.manufacturer)
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                            .padding(.bottom, 5)
                    }
                    Spacer()
                    Button {
                        sharedData.deleteFavorite(transport)
                    } label: {
                        Image(systemName: "suit.heart.fill")
                            .foregroundColor(.white)
                            .frame(width: 25, height: 25)
                            .padding(5)
                            .background(sharedData.isLiked(transport) ? .red : Color("Green"), in: Circle())
                            .offset(y: -10)
                    }
                }
                
                HStack(spacing: 5) {
                    Group {
                        Text(transport.price)
                        Text(transport.mileage)
                        Text(transport.location)
                    }
                    .font(.system(size: 15, weight: .regular, design: .rounded))
                    .lineLimit(1)
                    .minimumScaleFactor(.leastNormalMagnitude)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        //FIXME: padding - 15, mileage shanges
        .padding(.horizontal, 4)
        .padding(.vertical, 10)
        
        .background(
            Color.white.cornerRadius(25)
                .shadow(color: Color.black.opacity(0.2), radius: 1, x: 0, y: 1)
        )
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        LikedView()
            .environmentObject(SharedDataModel())
    }
}
