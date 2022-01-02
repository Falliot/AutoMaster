//
//  SearchView.swift
//  AutoMaster
//
//  Created by Anton Pustovidko on 01/12/2021.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var searchViewModel = SearchViewModel()
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var sharedData: SharedDataModel
    
    @ObservedObject var priceSlider = CustomSlider(start: 0, end: 100000, step: 1000)
    @ObservedObject var yearSlider = CustomSlider(start: 1950, end: 2021, step: 1)
    @ObservedObject var milleageSlider = CustomSlider(start: 5000, end: 200000, step: 15000)
    
    @State private var selectedTransmission = Transmission.manual
    @State private var selectedFuel = FuelType.gasoline
    @State private var manufacturer: String = ""
    
    @State private var isPresented = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    let colorRows = [
        GridItem(.fixed(70)),
        GridItem(.fixed(70)),
    ]
    
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(named: "Green")
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.black], for: .normal)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            //MARK: - Header
            HStack(spacing: 20) {
                Button {
                    withAnimation(.easeIn) {
                        homeViewModel.searchActivated.toggle()
                        sharedData.isHidden.toggle()
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
                    
                } label: {
                    Image("broom")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(10)
            .padding(.horizontal, 15)
            .background(Color("Green"))
            //            .padding(.bottom, 10)
            
            ZStack(alignment: .bottom) {
                //MARK: - Main ScrollView
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        //MARK: - Manufacturer Grid
                        Title(title: "Make and Model")
                            .padding(.top, 10)
                        VStack(spacing: 0) {
                            LazyVGrid(columns: columns, alignment: .center, spacing: 20) {
                                ForEach(searchViewModel.maker) { maker in
                                    Button {
                                        homeViewModel.manufacturer = "&marka_id[0]=\(maker.index)"
                                        manufacturer = maker.make
                                    } label: {
                                        VStack(spacing: 5) {
                                            Image(maker.image)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 35, height: 35)
                                            Text(maker.make)
                                                .font(.system(size: 15, weight: .regular, design: .rounded))
                                                .foregroundColor(.black)
                                        }
                                    }
                                }
                            }
                            .padding()
                            .frame(maxHeight: 180)
                            
                            Divider()
                            
                            Button { } label: {
                                Text("+ Show all makes")
                                    .font(.system(size: 16, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(10)
                                    .background(Color("Green"))
                                    .cornerRadius(25, corners: [.bottomLeft, .bottomRight])
                            }
                        }
                        .background(
                            Color.white.cornerRadius(25)
                        )
                        .padding([.horizontal, .bottom], 15)
                        
                        //MARK: - Body type
                        Title(title: "Body type")
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(0 ..< searchViewModel.bodyType.count) { index in
                                    let bodyType = searchViewModel.bodyType[index]
                                    Button {
                                        bodyType.isSelected.toggle()
                                        homeViewModel.bodyTypes.append("&bodystyle[\(homeViewModel.bodyTypes.count)]=\(bodyType.index)")
                                        searchViewModel.selectedBodyTypes.append(bodyType)
                                    } label: {
                                        VStack(spacing: 0) {
                                            Image(searchViewModel.bodyType[index].image)
                                                .resizable()
                                                .renderingMode(.template)
                                                .aspectRatio(contentMode: .fit)
                                                .foregroundColor(bodyType.isSelected ? .white : .black)
                                                .frame(width: 75, height: 50)
                                            Text(searchViewModel.bodyType[index].make)
                                                .font(.system(size: 13, weight: .regular, design: .rounded))
                                                .foregroundColor(bodyType.isSelected ? .white : .black)
                                                .padding(.bottom, 5)
                                        }
                                    }
                                    .background(bodyType.isSelected ? Color("Green") : .white)
                                    .cornerRadius(10)
                                    
                                }
                            }
                            .padding(.horizontal)
                        }
                        .frame(height: 100)
                        .background(.white)
                        .cornerRadius(25)
                        .padding([.horizontal, .bottom], 15)
                        
                        
                        
                        //MARK: - Sliders
                        Group {
                            TitleWithSlider(title: "Price ($)", slider: priceSlider)
                            TitleWithSlider(title: "Year", slider: yearSlider)
                            TitleWithSlider(title: "KM", slider: milleageSlider)
                        }
                        
                        //MARK: - Transmission
                        Group {
                            Title(title: "Transmission")
                            Picker("Transmission", selection: $selectedTransmission) {
                                ForEach(Transmission.allCases) { transmission in
                                    Text(transmission.id).tag(transmission)
                                }
                            }
                            .pickerStyle(.segmented)
                            .padding([.horizontal, .bottom], 15)
                        }
                        
                        //MARK: - Fuel
                        Group {
                            Title(title: "Fuel")
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(FuelType.allCases) { fuel in
                                        let isSelected = searchViewModel.selectedFuelTypes.contains(fuel)
                                        Button {
                                            if isSelected {
                                                searchViewModel.selectedFuelTypes.removeAll { object in
                                                    object == fuel
                                                }
                                            } else {
                                                searchViewModel.selectedFuelTypes.append(fuel)
                                                homeViewModel.bodyTypes.append("&type[\(homeViewModel.fuelTypes.count)]=\(selectedFuel.rawValue)")
                                                
                                            }
                                        } label: {
                                            Text(fuel.id)
                                                .font(.system(size: 15, weight: .regular, design: .rounded))
                                                .foregroundColor(isSelected ? .white : .black)
                                                .padding(5)
                                        }
                                        
                                        .background(isSelected ? Color("Green") : .white)
                                        .cornerRadius(10)
                                    }
                                }
                                .padding(.horizontal)
                            }
                            .frame(height: 70)
                            .background(.white)
                            .cornerRadius(25)
                            .padding([.horizontal, .bottom], 15)
                        }
                        //MARK: - Variant Fuel
                        //                ScrollView(.horizontal, showsIndicators: false) {
                        //                    Picker("Fuel", selection: $selectedFuel) {
                        //                        ForEach(FuelType.allCases) { fuel in
                        //                            Text(fuel.id).tag(fuel)
                        //                        }
                        //                    }
                        //                    .pickerStyle(.segmented)
                        //                }
                        //                .padding([.horizontal, .bottom], 15)
                        
                        
                        //MARK: - Color
                        Title(title: "Color")
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(rows: colorRows, alignment: .center, spacing: 15) {
                                ForEach(InteriorColor.allCases) { color in
                                    let isSelected = searchViewModel.selectedColors.contains(color)
                                    Button {
                                        if isSelected {
                                            searchViewModel.selectedColors.removeAll { object in
                                                object == color
                                            }
                                        } else {
                                            searchViewModel.selectedColors.append(color)
                                            homeViewModel.bodyTypes.append("&colors[\(homeViewModel.colors.count)]=\(color.rawValue)")
                                        }
                                    } label: {
                                        VStack(spacing: 5) {
                                            color.color
                                                .frame(width: 25, height: 25)
                                                .clipShape(Circle())
                                            
                                            Text(color.id)
                                                .font(.system(size: 15, weight: .regular, design: .rounded))
                                                .foregroundColor(isSelected ? .white : .black)
                                        }
                                        .frame(width: 75, height: 75)
                                        .background(isSelected ? Color("Green") : .white)
                                        .cornerRadius(10)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        .frame(height: 175)
                        .background(.white)
                        .cornerRadius(25)
                        .padding(.horizontal, 15)
                        
                    }
                }
                
                //MARK: - Search Button
                Button {
                    homeViewModel.bodyTypes.append("&gearbox[\(homeViewModel.gearbox.count)]=\(selectedTransmission.rawValue)")
                    
                    let params = homeViewModel.gearbox.joined(separator:"") + homeViewModel.fuelTypes.joined(separator:"") + homeViewModel.bodyTypes.joined(separator:"") + homeViewModel.colors.joined(separator:"") + homeViewModel.manufacturer
                    
                    homeViewModel.autoRiaSearchRequest(parameters: params)
                    
                    isPresented.toggle()
                    
                } label : {
                    HStack {
                        Text("Search")
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 60)
                    .padding(10)
                }
                .background(Color("Green"))
                .cornerRadius(25)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(
            Color("HomeBG")
                .ignoresSafeArea(.all)
        )
        .onAppear {
            homeViewModel.gearbox.removeAll()
            homeViewModel.fuelTypes.removeAll()
            homeViewModel.bodyTypes.removeAll()
            homeViewModel.colors.removeAll()
        }
        .fullScreenCover(isPresented: $isPresented, content: {
            SearchCarsView(savedSearch: SavedSearch(year: "to 2021", manufacturer: manufacturer, model: "Vectra C", country: "Poland", color: "White"))
        })
    }
    
    @ViewBuilder
    func Title(title: String) -> some View {
        Text(title)
            .font(.system(size: 16, weight: .semibold, design: .rounded))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.bottom, 5)
    }
    
    @ViewBuilder
    func TitleWithSlider(title: String, slider: CustomSlider) -> some View {
        Text(title)
            .font(.system(size: 16, weight: .semibold, design: .rounded))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.bottom, 5)
        
        VStack {
            HStack(alignment: .center) {
                Text("\(slider.lowHandle.currentValue)")
                Text(" to ")
                Text("\(slider.highHandle.currentValue)")
            }
            .padding(.bottom, 10)
            
            SliderView(slider: slider)
                .padding(.bottom, 20)
                .padding(.horizontal, 15)
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .background(.white)
        .cornerRadius(25)
        .padding(.bottom, 15)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(HomeViewModel())
            .environmentObject(SharedDataModel())
    }
}
