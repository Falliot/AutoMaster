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
                                .font(.title2)
                                .foregroundColor(.white)
                            
                        }
                        Spacer()
                        //                    Text(transport.manufacturer + " " + transport.model)
                        Text("Details")
                            .font(.system(size: 23, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                                .font(.title2)
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
                                        .font(.system(size: 22, weight: .medium, design: .rounded))
                                    
                                    Spacer()
                                    Text(transport.price)
                                        .font(.system(size: 18, weight: .semibold, design: .rounded))
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
                                
                                SingkeNavigationLink(title: "Technical data", icon: "wrench", popOverType: .technical)
                                
                                DetailsNavigationLink(title: "Basic data", icon: "carSearch", firstInfo: "Body type", secondInfo: "Coupe", thirdInfo: "Condition", forthInfo: "Used", navigation: true, popOverType: .basic)
                                
                                DetailsNavigationLink(title: "Vehicle history", icon: "history", firstInfo: "Mileage", secondInfo: transport.mileage, thirdInfo: "First registration", forthInfo: transport.year)
                                
                                SingkeNavigationLink(title: "Color", icon: "colorFill", popOverType: .color)
                                
                                SingkeNavigationLink(title: "Equipment", icon: "carSeat", popOverType: .equipment)
                                
                                DescriptionNavigationLink(title: "Vehicle description", icon: "clipboard", text: "Used car. Very good condition. All the documents are in place. Clean and nice. Not damadged, not painted", popOverType: .description)
                                
                                PopOverInfo()
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
                PopOverInfo(popOverType: popOver)
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
                    .font(.system(size: 15, weight: .regular, design: .rounded))
            } icon: {
                Image(icon)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(Color("Green"))
                    .frame(width: 25, height: 25)
            }
            Spacer()
            Text(rightDetail)
                .font(.system(size: 15, weight: .semibold, design: .rounded))
        }
    }
    
    
    @ViewBuilder
    func SingkeNavigationLink(title: String, icon: String, popOverType: PopOver = .none) -> some View {
        HStack {
            Label {
                Text(title)
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
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
        .padding(.horizontal, 5)
        Rectangle()
            .frame(height: 1)
            .foregroundColor(Color("Green"))
            .padding(5)
    }
    
    @ViewBuilder
    func DescriptionNavigationLink(title: String, icon: String, text: String, popOverType: PopOver = .none) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Label {
                    Text(title)
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
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
                    .font(.system(size: 15, weight: .regular, design: .rounded))
                    .lineLimit(1)
                Spacer()
                Image(systemName: "chevron.right")
                    .onTapGesture {
                        self.popOver = popOverType
                        showingPopover = true
                    }
            }
        }
        .foregroundColor(.black)
        .padding(.horizontal, 5)
        Rectangle()
            .frame(height: 1)
            .foregroundColor(Color("Green"))
            .padding(5)
    }
    
    @ViewBuilder
    func DetailsNavigationLink(title: String, icon: String, firstInfo: String, secondInfo: String, thirdInfo: String, forthInfo: String, navigation: Bool = false, popOverType: PopOver = .none) -> some View {
        HStack {
            Label {
                Text(title)
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
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
        
        VStack(spacing: 10) {
            SingleInfo(infoTitle: firstInfo, infoDescription: secondInfo, navigation: navigation, popOverType: .basic)
            SingleInfo(infoTitle: thirdInfo, infoDescription: forthInfo)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundColor(.black)
        
        .padding(.horizontal, 5)
        
        Rectangle()
            .frame(height: 1)
            .foregroundColor(Color("Green"))
            .padding(5)
    }
    
    @ViewBuilder
    func PopOverHeader(title: String) -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 20) {
                Button { } label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(.white)
                }
                .opacity(0)
                
                Spacer()
                
                Text(title)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Spacer()
                
                Button {
                    showingPopover = false
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.white)
                        .frame(width: 25, height: 25)
                }
            }
            .padding([.horizontal, .top], 15)
            .padding(.bottom, 10)
            .background(Color("Green"))
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.black.opacity(0.3))
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 5)
    }
    
    @ViewBuilder
    func DetailPopOver<Detail: View>(title: String, @ViewBuilder content: @escaping () -> Detail) -> some View {
        VStack(spacing: 10) {
            PopOverHeader(title: title)
            content()
                .padding(.horizontal, 25)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color("HomeBG"))
    }
    
    
    @ViewBuilder
    func PopOverInfo(popOverType: PopOver = .none) -> some View {
        switch popOver {
        case .technical:
            DetailPopOver(title: "Technical data", content: {
                SinglePopOverInfo(infoTitle: "Power", infoDescription: "40 kW (54 hp)")
                SinglePopOverInfo(infoTitle: "Transmission", infoDescription: transport.transmission)
                SinglePopOverInfo(infoTitle: "Engine size", infoDescription: "973 cc")
                SinglePopOverInfo(infoTitle: "Gears", infoDescription: "5")
            })
            
        case .basic:
            DetailPopOver(title: "Basic data", content: {
                SinglePopOverInfo(infoTitle: "Body tyoe", infoDescription: "Compact")
                SinglePopOverInfo(infoTitle: "Condition", infoDescription: "Used")
                SinglePopOverInfo(infoTitle: "Door count", infoDescription: "3")
                SinglePopOverInfo(infoTitle: "Country version", infoDescription: "Germany")
            })
            
        case .equipment:
            DetailPopOver(title: "Equipment", content: {
                VStack {
                    Label {
                        Text("Comfort & Convenience")
                    } icon: {
                        Image("carSeat")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .foregroundColor(Color("Green"))
                    }
                    Text("Sunroof")
                }
            })
        case .color:
            DetailPopOver(title: "Color", content: {
                SinglePopOverInfo(infoTitle: "Body colot", infoDescription: "Blue")
                SinglePopOverInfo(infoTitle: "Manufacturer color", infoDescription: "blau")
                SinglePopOverInfo(infoTitle: "Interior color", infoDescription: "Other")
                SinglePopOverInfo(infoTitle: "Interior fittings", infoDescription: "Cloth")
            })
        case .description:
            DetailPopOver(title: "Vehicle description", content: {
                Text("Used car. Very good condition. All the documents are in place. Clean and nice. Not damadged, not painted")
                    .font(.system(size: 17, weight: .regular, design: .rounded))
            })
        case .none:
            Text("")
        }
    }
    
    @ViewBuilder
    func SingleInfo(infoTitle: String, infoDescription: String, navigation: Bool = false, popOverType: PopOver = .none) -> some View {
        HStack {
            Text(infoTitle)
                .font(.system(size: 15, weight: .regular, design: .rounded))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(infoDescription)
                .font(.system(size: 15, weight: .semibold, design: .rounded))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: "chevron.right")
                .opacity(navigation ? 1: 0)
                .onTapGesture {
                    if navigation {
                        self.popOver = popOverType
                        showingPopover = true
                    }
                }
        }
    }
    
    @ViewBuilder
    func SinglePopOverInfo(infoTitle: String, infoDescription: String) -> some View {
        HStack {
            Text(infoTitle)
                .font(.system(size: 15, weight: .regular, design: .rounded))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(infoDescription)
                .font(.system(size: 15, weight: .semibold, design: .rounded))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        
        Rectangle()
            .frame(height: 1)
            .foregroundColor(Color("Green"))
            .padding(.vertical, 5)
            .padding(.horizontal, 0)
    }
}

struct CarDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        TransportDetailsView(animation: Namespace.init().wrappedValue, transport: HomeViewModel().transport[0])
            .environmentObject(SharedDataModel())
    }
}
