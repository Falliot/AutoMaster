//
//  TransportDetailsView.swift
//  AutoMaster
//
//  Created by Anton Pustovidko on 02/12/2021.
//

import SwiftUI
import SwiftUIX

struct TransportDetailsView: View {
    var animation: Namespace.ID
    var transport: Transport
    
    @EnvironmentObject var sharedData: SharedDataModel
    
    @State private var showingPopover = false
    @State var popOver: PopOver = .none
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                
                //MARK: - Top Bar
                VStack {
                    HStack {
                        Button {
                            withAnimation(.easeInOut) {
                                sharedData.showDetailTransport = false
                            }
                        } label: {
                            Image(systemName: "arrow.left")
                                .font(.title)
                                .foregroundColor(.white)
                            
                        }
                        Spacer()
                        //                    Text(transport.manufacturer + " " + transport.model)
                        Text("Details")
                            .font(.system(size: 25, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal, 15)
                    .padding(.bottom, 10)
                }
                .background(Color("Green"))
                
                //MARK: - ScrollView
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        Image(transport.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .matchedGeometryEffect(id: "\(transport.id)IMAGE", in: animation)
                            .frame(maxHeight: .infinity)
                            .padding(.bottom, 40)
                        
                        //MARK: - Like and Icon
                        ZStack(alignment: .top) {
                            HStack(alignment: .center) {
                                if transport.icon != "" {
                                    Image(transport.icon)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 35, height: 35)
                                        .offset(y: 5)
                                } else {
                                    VStack(alignment: .center, spacing: 0) {
                                        Text("Auto")
                                        Text("Master")
                                    }
                                    .font(.system(size: 15, weight: .bold, design: .rounded))
                                    .foregroundColor(Color("Green"))
                                    .offset(y: 10)
                                }
                                
                                Spacer()
                                //MARK: - change from gray to red, into animation
                                Button {
                                    sharedData.addToLiked(transport)
                                } label: {
                                    Image(systemName: "suit.heart.fill")
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .padding(10)
                                        .background(sharedData.isLiked(transport) ? .red : Color("Green"), in: Circle())
                                        .offset(y: -25)
                                }
                            }
                            .zIndex(1)
                            .padding(.horizontal, 20)
                            
                            //MARK: - Transport Data
                            VStack(alignment: .center, spacing: 15) {
                                HStack {
                                    Text(transport.manufacturer + " " + transport.model)
                                        .font(.system(size: 25, weight: .medium, design: .rounded))
                                    
                                    Spacer()
                                    Text(transport.price)
                                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                                }
                                .padding(.top, 40)
                                .padding(.horizontal, 5)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Group {
                                    DetailsField(icon: "calendar", "Year", transport.year)
                                    DetailsField(icon: "speed", "Mileage", transport.mileage)
                                    DetailsField(icon: "gearbox", "Transmission", transport.transmission)
                                    DetailsField(icon: transport.fuel == .gasoline ? "gas" : "battery", "Fuel", transport.fuel.rawValue)
                                    DetailsField(icon: "menu", "Seller", "Dealer")
                                    DetailsField(icon: "carLocation", "Location", transport.location)
                                }
                                .padding(.horizontal, 5)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                                
                                //MARK: - Line
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(Color("Green"))
                                    .padding(.horizontal, 5)
                                
                                SingkeNavigationLink(title: "Technical data", icon: "wrench", popOverType: .technical)//engineering, technicalData
                                
                                DetailsNavigationLink(title: "Basic data", icon: "carSearch", firstInfo: "Body type", secondInfo: "Coupe", thirdInfo: "Condition", forthInfo: "Used", navigation: true) { //carBadge
                                    Text("")
                                        .navigationTitle("Basic data")
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        .background(Color("HomeBG").ignoresSafeArea())
                                }
                                
                                DetailsNavigationLink(title: "Vehicle history", icon: "history", firstInfo: "Mileage", secondInfo: transport.mileage, thirdInfo: "First registration", forthInfo: transport.year) { //carBadge
                                    
                                }
                                
                                SingkeNavigationLink(title: "Color", icon: "colorDrop", popOverType: .color) //colorPallet, colorFill
                                
                                SingkeNavigationLink(title: "Equipment", icon: "carSeat", popOverType: .equipment)
                                
                                DescriptionNavigationLink(title: "Vehicle description", icon: "create", text: "Used car. Very good condition. All the documents are in place. Clean and nice. Not damadged, not painted") { // googleDocs, clipboard, activityHistory
                                    Text("Used car. Very good condition. All the documents are in place. Clean and nice. Not damadged, not painted")
                                        .navigationTitle("Vehicle description")
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        .background(Color("HomeBG").ignoresSafeArea())
                                }
                                
                            }
                            .padding([.horizontal, .bottom], 20)
                            .padding(.top, 20)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(.white)
                            .cornerRadius([.topLeft, .topRight], 40)
                        }
                    }
                }
            }
            .popover(isPresented: $showingPopover) {
                switch popOver {
                case .technical:
                    Text("Tech")
                        .font(.headline)
                        .padding()
                case .basic:
                    Text("Basic")
                case .equipment:
                    Text("Equipment")
                case .color:
                    Text("Color")
                case .none:
                    Text("")
                }
            }
            .navigationBarHidden(true)
            .animation(.easeInOut, value: sharedData.likedTransports)
            .background(
                Color("HomeBG")
                    .ignoresSafeArea(edges: .top)
            )
        }
        .print("\(popOver)")
    }
    
    @ViewBuilder
    func DetailsField(icon: String, _ leftDetail: String, _ rightDetail: String) -> some View {
        HStack {
            Label {
                Text(leftDetail)
                    .font(.system(size: 18, weight: .regular, design: .rounded))
            } icon: {
                Image(icon)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(Color("Green"))
                    .frame(width: 30, height: 30)
            }
            Spacer()
            Text(rightDetail)
                .font(.system(size: 18, weight: .semibold, design: .rounded))
        }
    }
    
    
    @ViewBuilder
    func SingkeNavigationLink(title: String, icon: String, popOverType: PopOver) -> some View {
        //        NavigationLink {
        //            content()
        //        } label: {
        HStack {
            Label {
                Text(title)
                    .font(.system(size: 17, weight: .semibold, design: .rounded))
            } icon: {
                Image(icon)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color("Green"))
                    .frame(width: 25, height: 25)
            }
            
            Spacer()
            Image(systemName: "chevron.right")
                .onTapGesture {
                    self.popOver = popOverType
                    showingPopover = true
                }
        }
        .foregroundColor(.black)
        //        }
        .padding(.horizontal, 5)
        Rectangle()
            .frame(height: 1)
            .foregroundColor(Color("Green"))
            .padding(5)
    }
    
    @ViewBuilder
    func DescriptionNavigationLink<Detail: View>(title: String, icon: String, text: String, @ViewBuilder content: @escaping () -> Detail) -> some View {
        NavigationLink {
            content()
        } label: {
            VStack(alignment: .leading) {
                HStack {
                    Label {
                        Text(title)
                            .font(.system(size: 17, weight: .semibold, design: .rounded))
                    } icon: {
                        Image(icon)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color("Green"))
                            .frame(width: 25, height: 25)
                    }
                }
                
                HStack {
                    Text(text)
                        .font(.system(size: 17, weight: .regular, design: .rounded))
                        .lineLimit(1)
                    Spacer()
                    Image(systemName: "chevron.right")
                }
            }
            .foregroundColor(.black)
        }
        .padding(.horizontal, 5)
        Rectangle()
            .frame(height: 1)
            .foregroundColor(Color("Green"))
            .padding(5)
    }
    
    @ViewBuilder
    func DetailsNavigationLink<Detail: View>(title: String, icon: String, firstInfo: String, secondInfo: String, thirdInfo: String, forthInfo: String, navigation: Bool = false, @ViewBuilder content: @escaping () -> Detail) -> some View {
        HStack {
            Label {
                Text(title)
                    .font(.system(size: 17, weight: .semibold, design: .rounded))
            } icon: {
                Image(icon)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color("Green"))
                    .frame(width: 25, height: 25)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 5)
        .padding(.bottom, 10)
        
        VStack {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(firstInfo)
                        .font(.system(size: 17, weight: .regular, design: .rounded))
                    Text(thirdInfo)
                        .font(.system(size: 17, weight: .regular, design: .rounded))
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(secondInfo)
                        .font(.system(size: 17, weight: .semibold, design: .rounded))
                    Text(forthInfo)
                        .font(.system(size: 17, weight: .semibold, design: .rounded))
                }
                
                Spacer()
                
                NavigationLink {
                    content()
                } label: {
                    Image(systemName: "chevron.right")
                }
                .opacity(navigation ? 1: 0)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundColor(.black)
        
        .padding(.horizontal, 5)
        
        Rectangle()
            .frame(height: 1)
            .foregroundColor(Color("Green"))
            .padding(5)
    }
    
}

struct CarDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        TransportDetailsView(animation: Namespace.init().wrappedValue, transport: HomeViewModel().transport[0])
            .environmentObject(SharedDataModel())
    }
}
