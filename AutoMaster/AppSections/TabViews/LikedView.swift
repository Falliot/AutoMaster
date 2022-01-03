//
//  LikedView.swift
//  AutoMaster
//
//  Created by Anton on 07.11.2021.
//

import SwiftUI
import SDWebImageSwiftUI
import RealmSwift

struct LikedView: View {
    @ObservedObject var viewModel = FavoritesViewModel()
    @EnvironmentObject var sharedData: SharedDataModel
    
    @ObservedResults(TransportDetailsShort.self) var transportFetch
    
    @State var showDeleteOption: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Favorites")
                    .font(.system(size: 23, weight: .bold, design: .rounded))
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
                .opacity(sharedData.transportFetched.isEmpty ? 0 : 1)
            }
            .padding(.horizontal, 15)
            .padding(.bottom, 10)
            .background(Color("Green"))
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    if transportFetch.isEmpty {
                        Group {
                            Image("noLiked")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding()
                                .padding(.top, 35)
                            
                            Text("No favorites yet")
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
                            ForEach(transportFetch) { transport in
                                HStack(spacing: 0) {
                                    if showDeleteOption {
                                        Button {
                                            sharedData.deleteFavorite($transportFetch, transport)
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
            .animation(.easeInOut, value: transportFetch)
            .background(
                Color("HomeBG")
                    .ignoresSafeArea()
            )
        }
    }
    
    @ViewBuilder
    func CardView(transport: TransportDetailsShort) -> some View {
        HStack(spacing: 7) {
            //MARK: - right side(image)
            WebImage(url: URL(string: transport.imageURL))
                .resizable()
                .placeholder(Image(systemName: "photo"))
                .placeholder {
                    Rectangle().foregroundColor(.white)
                }
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .aspectRatio(contentMode: .fill)
                .frame(width: getRect().width * 0.33, height: getRect().width * 0.24, alignment: .leading)
                .cornerRadius(25, corners: [.topLeft, .bottomLeft])
                .offset(x: -4)
            
            //MARK: - left side
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(String(transport.year))
                            .font(.system(size: 15, weight: .regular, design: .rounded))
                            .foregroundColor(.gray)
                        Text(transport.maker)
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                            .padding(.bottom, 5)
                    }
                    Spacer()
                    Button {
                        sharedData.deleteFavorite($transportFetch, transport)
                    } label: {
                        Image(systemName: "suit.heart.fill")
                            .foregroundColor(.white)
                            .frame(width: 25, height: 25)
                            .padding(5)
                            .background(.red, in: Circle())
                            .offset(y: -10)
                    }
                }
                
                HStack(spacing: 5) {
                    Group {
                        Text(String(transport.price) + " $")
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
        .frame(height: getRect().width * 0.24, alignment: .leading)
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
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        
        LikedView()
            .environmentObject(SharedDataModel())
            .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
        
        LikedView()
            .environmentObject(SharedDataModel())
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
        
        LikedView()
            .environmentObject(SharedDataModel())
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
    }
}
