//
//  SearchCarsView.swift
//  AutoMaster
//
//  Created by Anton Pustovidko on 02/01/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct SearchCarsView: View {
    @Environment(\.presentationMode) var presentationMode
    @Namespace var animation
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var sharedData: SharedDataModel
    
    var savedSearch: SavedSearch
    
    @State var isTapped: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            //MARK: - Header
            HStack(spacing: 20) {
                Button {
                    withAnimation(.easeIn) {
                        presentationMode.dismiss()
                    }
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                Text("Search")
                    .font(.system(size: 23, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Spacer()
                
                Button {
                    isTapped.toggle()
                    sharedData.likedSearches.append(savedSearch)
                } label:  {
                    Image(systemName: isTapped ? "heart.fill" : "heart")
                        .font(.title2)
                        .foregroundColor(.red)
                        .padding(10)
                        .background(.white, in: Circle())
                }
            }
            .frame(maxWidth: .infinity)
            .padding(10)
            .padding(.horizontal, 15)
            .background(Color("Green"))
            
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15) {
                    ForEach(homeViewModel.searchCars) { transport in
                        TransportCardView(transport: transport)
                            .frame(maxWidth: getRect().width, alignment: .leading)
                            .padding(.leading, 25)
                    }
                }
                .padding(.vertical)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("HomeBG"))
        .overlay(
            ZStack{
                if let transport = sharedData.detailTransport, sharedData.showDetailTransport {
                    TransportDetailsView(animation: animation, transport: transport)
                        .environmentObject(sharedData)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
                }
            })
    }
    
    @ViewBuilder
    func TransportCardView(transport: TransportModel) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top, spacing: 10) {
                ZStack {
                    if sharedData.showDetailTransport {
                        WebImage(url: URL(string: transport.image!))
                            .resizable()
                            .placeholder(Image(systemName: "photo"))
                            .placeholder {
                                Rectangle().foregroundColor(.white)
                            }
                            .indicator(.activity)
                            .transition(.fade(duration: 0.5))
                            .opacity(0)
                    } else {
                        WebImage(url: URL(string: transport.image!))
                            .resizable()
                            .placeholder(Image(systemName: "photo"))
                            .placeholder {
                                Rectangle().foregroundColor(.white)
                            }
                            .indicator(.activity)
                            .transition(.fade(duration: 0.5))
                            .aspectRatio(contentMode: .fill)
                        //                            .matchedGeometryEffect(id: "\(transport.id)IMAGE", in: animation)
                    }
                }
                .frame(width: getRect().width * 0.53, height: 130)
                .cornerRadius(25, corners: [.topLeft])
                .offset(y: -9.7)
                .frame(width: getRect().width / 1.9)
                .shadow(color: Color.black.opacity(0.5), radius: 1, x: 1, y: 1)
                
                
                VStack(alignment: .leading, spacing: 5) {
                    Group {
                        DetailsInformation(icon: "speed", info: transport.mileage!)
                        DetailsInformation(icon: "calendar", info: String(transport.year!))
                        DetailsInformation(icon: "gas", info: transport.fuel!)
                        DetailsInformation(icon: "gearbox", info: transport.transmission!)
                        DetailsInformation(icon: "location", info: transport.location!)
                    }
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                }
                .frame(width: getRect().width / 3.3)
            }
            .padding(5)
            
            
            VStack(alignment: .leading) {
                Text(transport.title!)
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                Text(String(transport.price!) + " $")
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundColor(Color("Green"))
            }
            .offset(y: -7)
            .padding(.horizontal, 15)
        }
        .frame(width: getRect().width / 1.2)
        .padding(5)
        .background(
            Color.white.cornerRadius(25)
                .shadow(color: Color.black.opacity(0.2), radius: 1, x: 0, y: 1)
        )
        .onTapGesture {
            withAnimation(.easeInOut) {
                sharedData.detailTransport = transport
                sharedData.showDetailTransport = true
            }
        }
    }
    
    
    @ViewBuilder
    func DetailsInformation(icon: String, info: String) -> some View {
        HStack(alignment: .center, spacing: 10) {
            Image(icon)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(Color("Green"))
                .frame(width: 20, height: 20)
            Text(info)
                .lineLimit(1)
                .minimumScaleFactor(0.9)
        }
    }
}

struct SearchCarsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCarsView(savedSearch: SavedSearch(year: "2001", manufacturer: "Opel", model: "Vectra C", country: "Poland", color: "Black"))
    }
}
