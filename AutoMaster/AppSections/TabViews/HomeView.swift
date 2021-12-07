//
//  HomeView.swift
//  AutoMaster
//
//  Created by Anton on 07.11.2021.
//

import SDWebImageSwiftUI
import SwiftUI

struct HomeView: View {
    
    var animation: Namespace.ID
    
    @StateObject var viewModel = HomeViewModel()
    @EnvironmentObject var sharedData: SharedDataModel
    
    
    @State private var searchText: String = ""
    
    let alphabet = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    var searchResults: [ManufacturerModel] {
        if searchText.isEmpty {
            return viewModel.manufacturerModel
        } else {
            return viewModel.manufacturerModel.filter { $0.name.contains(searchText) }
        }
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15) {
                
                //MARK: - Search Bar
                
                ZStack {
                    SearchBar()
                }
                .frame(width: getRect().width   / 1.6)
                .padding(.horizontal, 25)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeOut) {
                        viewModel.searchActivated = true
                        sharedData.isHidden = true
                    }
                }
                
                Text("Search for vehicles")
                    .font(.system(size: 28, weight: .semibold, design: .rounded))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                    .padding(.horizontal, 25)
                
                ForEach(viewModel.transport) { transport in
                    TransportCardView(transport: transport)
                        .frame(maxWidth: getRect().width, alignment: .leading)
                        .padding(.leading, 25)
                }
            }
            .padding(.vertical)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("HomeBG"))
        .overlay(
            ZStack {
                if viewModel.searchActivated {
                    SearchView()
                        .environmentObject(viewModel)
                        .environmentObject(sharedData)
                }
            }
        )
    }
    
    @ViewBuilder
    func SearchBar() -> some View {
        HStack(spacing: 15) {
            Image(systemName: "magnifyingglass")
                .font(.title2)
                .foregroundColor(Color("Green"))
            
            TextField("", text: .constant(""))
                .placeholder(when: true) {
                    Text("Search").foregroundColor(Color("Green"))
                }
                .disabled(true)
        }
        .padding(.vertical, 12)
        .padding(.horizontal)
        .background(
            Capsule()
                .strokeBorder(Color("Green"), lineWidth: 0.8)
        )
    }
    
    @ViewBuilder
    func TransportCardView(transport: Transport) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top, spacing: 10) {
                ZStack {
                    if sharedData.showDetailTransport {
                        Image(transport.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .border(.pink)
                            .opacity(0)
                    } else {
                        Image(transport.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .matchedGeometryEffect(id: "\(transport.id)IMAGE", in: animation)
                    }
                }
                .frame(width: getRect().width * 0.53, height: 130)
                .cornerRadius(25, corners: [.topLeft])
                .offset(y: -9.7)
                .frame(width: getRect().width / 1.9)
                .shadow(color: Color.black.opacity(0.5), radius: 1, x: 1, y: 1)
                
                
                VStack(alignment: .leading, spacing: 5) {
                    Group {
                        DetailsInformation(icon: "speed", info: transport.mileage)
                        DetailsInformation(icon: "calendar", info: transport.year)
                        DetailsInformation(icon: transport.fuel == .gasoline ? "gas" : "battery", info: transport.fuel.rawValue)
                        DetailsInformation(icon: "gearbox", info: transport.transmission)
                        DetailsInformation(icon: "location", info: transport.location)
                    }
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                }
                .frame(width: getRect().width / 3.3)
            }
            .padding(5)
            
            
            VStack(alignment: .leading) {
                Text(transport.manufacturer + " " + transport.model)
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                Text(transport.price)
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

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
 
//        MainPage()
//            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
//        
        MainPage()
            .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
//
//        MainPage()
//            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
//
//        MainPage()
//            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
    }
}


//
////        NavigationView {
////            List {
////                ForEach(searchResults) { car in
////                    HStack {
////                        Text(car.name)
////                        WebImage(url: URL(string: car.image.optimized))
////                        // Supports options and context, like `.delayPlaceholder` to show placeholder only when error
////                            .onSuccess { _, _, _ in
////                                // Success
////                                // Note: Data exist only when queried from disk cache or network. Use `.queryMemoryData` if you really need data
////                            }
////                            .resizable() // Resizable like SwiftUI.Image, you must use this modifier or the view will use the image bitmap size
////                            .placeholder(Image(systemName: "photo")) // Placeholder Image
////                        // Supports ViewBuilder as well
////                            .placeholder {
////                                Rectangle().foregroundColor(.gray)
////                            }
////                            .indicator(.activity) // Activity Indicator
////                            .transition(.fade(duration: 0.5)) // Fade Transition with duration
////                            .scaledToFit()
////                            .frame(width: 50, height: 50, alignment: .center)
////                    }
////                }
////            }
////        }
////        .searchable(text: $searchText )
//NavigationView {
//    VStack {
//        ScrollViewReader { scrollProxy in
//            ZStack {
//                List {
//                    ForEach(alphabet, id: \.self) { letter in
//                        Section(header: Text(letter).id(letter)) {
//                            ForEach(searchResults.filter({ (contact) -> Bool in
//                                contact.name.prefix(1) == letter
//                            })) { contact in
//                                HStack {
//                                    WebImage(url: URL(string: contact.image.optimized))
//                                    // Supports options and context, like `.delayPlaceholder` to show placeholder only when error
//                                        .onSuccess { _, _, _ in
//                                            // Success
//                                            // Note: Data exist only when queried from disk cache or network. Use `.queryMemoryData` if you really need data
//                                        }
//                                        .resizable() // Resizable like SwiftUI.Image, you must use this modifier or the view will use the image bitmap size
//                                        .placeholder(Image(systemName: "photo")) // Placeholder Image
//                                    // Supports ViewBuilder as well
//                                        .placeholder {
//                                            Rectangle().foregroundColor(.gray)
//                                        }
//                                        .indicator(.activity) // Activity Indicator
//                                        .transition(.fade(duration: 0.5)) // Fade Transition with duration
//                                        .scaledToFit()
//                                        .frame(width: 50, height: 50, alignment: .center)
//                                    Text(contact.name)
//
//                                }
//                            }
//                        }
//                    }
//                }
//                .listStyle(PlainListStyle())
//                //                           .resignKeyboardOnDragGesture()
//
//                VStack {
//                    ForEach(alphabet, id: \.self) { letter in
//                        HStack {
//                            Spacer()
//                            Button(action: {
//                                print("letter = \(letter)")
//                                //need to figure out if there is a name in this section before I allow scrollto or it will crash
//                                if searchResults.first(where: { $0.name.prefix(1) == letter }) != nil {
//                                    withAnimation {
//                                        scrollProxy.scrollTo(letter)
//                                    }
//                                }
//                            }, label: {
//                                Text(letter)
//                                    .font(.system(size: 12))
//                                    .padding(.trailing, 7)
//                            })
//                        }
//                    }
//                }
//            }
//        }
//    }
//}
//.searchable(text: $searchText )
//.navigationTitle("HomeView")
//.onAppear {
//    if let localData = FileManager.shared.readLocalFile(forName: "CarData") {
//        viewModel.manufacturerModel = FileManager.shared.parse(jsonData: localData)
//    }
//}
