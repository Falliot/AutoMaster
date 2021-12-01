//
//  HomeView.swift
//  AutoMaster
//
//  Created by Anton on 07.11.2021.
//

import SDWebImageSwiftUI
import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    
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
                
                // Search Bar
                HStack(spacing: 15) {
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                    TextField("Search", text: .constant(""))
                        .disabled(true)
                }
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(
                    Capsule()
                        .strokeBorder(Color.gray, lineWidth: 0.8)
                )
                .frame(width: getRect().width / 1.6)
                .padding(.horizontal, 25)
                
                Text("Search for vehicles")
                    .font(.system(size: 28, weight: .semibold, design: .rounded))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                    .padding(.horizontal, 25)
                
                ForEach(viewModel.product) { product in
                    ProductCardView(product: product)
                        .frame(maxWidth: getRect().width, alignment: .leading)
                        .padding(.leading, 25)
                }
            }
            .padding(.vertical)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("HomeBG"))
    }
    
    
    @ViewBuilder
    func ProductCardView(product: Product) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top, spacing: 5) {
                Image(product.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(25, corners: [.topLeft])
                    .clipped() // ?
                    .offset(x: -7, y: -9.8)
                    .frame(width: getRect().width / 1.9)
                    .shadow(color: Color.black.opacity(0.5), radius: 1, x: 1, y: 1)
                    
                
                VStack(alignment: .leading, spacing: 5) {
                    Group {
                        DetailsInformation(icon: "speed", info: product.mileage)
                        DetailsInformation(icon: "calendar", info: product.year)
                        DetailsInformation(icon: product.fuel == .gasoline ? "gas" : "battery", info: product.fuel.rawValue)
                        DetailsInformation(icon: "gearbox", info: product.transmission)
                        DetailsInformation(icon: "location", info: product.location)
                    }
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                }
                .frame(width: getRect().width / 3.5)
            }
            .padding(5)
            
            VStack(alignment: .leading) {
                Text(product.manufacturer + " " + product.model)
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                Text(product.price)
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundColor(Color("Green"))
            }
            .offset(y: -7)
            .padding(5)
        }
        .frame(width: getRect().width / 1.2)
        .padding(5)
        .background(
            Color.white.cornerRadius(25)
                .shadow(color: Color.black.opacity(0.2), radius: 1, x: 0, y: 1)
        )
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
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
