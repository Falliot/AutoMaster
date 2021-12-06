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
    
    @ObservedObject var priceSlider = CustomSlider(start: 0, end: 100000)
    @ObservedObject var yearSlider = CustomSlider(start: 1950, end: 2021)
    @ObservedObject var milleageSlider = CustomSlider(start: 5000, end: 200000)
    
    @State private var selectedTransmission = Transmission.manual
    @State private var selectedFuel = FuelType.gasoline
    
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
        //        UISegmentedControl.appearance().backgroundColor = .purple
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
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(
            Color("HomeBG")
                .ignoresSafeArea(.all)
        )
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


import SwiftUI
import Combine

//SliderValue to restrict double range: 0.0 to 1.0
@propertyWrapper
struct SliderValue {
    var value: Double
    
    init(wrappedValue: Double) {
        self.value = wrappedValue
    }
    
    var wrappedValue: Double {
        get { value }
        set { value = min(max(0.0, newValue), 1.0) }
    }
}

class SliderHandle: ObservableObject {
    
    //Slider Size
    let sliderWidth: CGFloat
    let sliderHeight: CGFloat
    
    //Slider Range
    let sliderValueStart: Double
    let sliderValueRange: Double
    
    //Slider Handle
    var diameter: CGFloat = 25
    var startLocation: CGPoint
    
    //Current Value
    @Published var currentPercentage: SliderValue
    
    //Slider Button Location
    @Published var onDrag: Bool
    @Published var currentLocation: CGPoint
    
    init(sliderWidth: CGFloat, sliderHeight: CGFloat, sliderValueStart: Double, sliderValueEnd: Double, startPercentage: SliderValue) {
        self.sliderWidth = sliderWidth
        self.sliderHeight = sliderHeight
        
        self.sliderValueStart = sliderValueStart
        self.sliderValueRange = sliderValueEnd - sliderValueStart
        
        let startLocation = CGPoint(x: (CGFloat(startPercentage.wrappedValue)/1.0)*sliderWidth, y: sliderHeight/2)
        
        self.startLocation = startLocation
        self.currentLocation = startLocation
        self.currentPercentage = startPercentage
        
        self.onDrag = false
    }
    
    lazy var sliderDragGesture: _EndedGesture<_ChangedGesture<DragGesture>>  = DragGesture()
        .onChanged { value in
            self.onDrag = true
            
            let dragLocation = value.location
            
            //Restrict possible drag area
            self.restrictSliderBtnLocation(dragLocation)
            
            //Get current value
            self.currentPercentage.wrappedValue = Double(self.currentLocation.x / self.sliderWidth)
            //            print("Current percentage: \(self.currentPercentage.wrappedValue)")
        }.onEnded { _ in
            self.onDrag = false
        }
    
    private func restrictSliderBtnLocation(_ dragLocation: CGPoint) {
        //On Slider Widthq
        let xOffset = min(max(0, dragLocation.x), sliderWidth)
        calcSliderBtnLocation(CGPoint(x: xOffset, y: dragLocation.y))
    }
    
    private func calcSliderBtnLocation(_ dragLocation: CGPoint) {
        if dragLocation.y != sliderHeight/2 {
            currentLocation = CGPoint(x: dragLocation.x, y: sliderHeight/2)
        } else {
            currentLocation = dragLocation
        }
    }
    
    //Current Value
    var currentValue: Int {
        //        print("Current percentage: \(currentPercentage.wrappedValue)")
        //        print("Slider value range \(sliderValueRange )")
        //        print("Value   \(Int(sliderValueStart + currentPercentage.wrappedValue * sliderValueRange))")
        return Int(sliderValueStart + currentPercentage.wrappedValue * sliderValueRange)
    }
}

class CustomSlider: ObservableObject {
    
    //Slider Size
    final let width: CGFloat = UIScreen.main.bounds.width - 90
    final let lineWidth: CGFloat = 5
    
    //Slider value range from valueStart to valueEnd
    final let valueStart: Double
    final let valueEnd: Double
    
    //Slider Handle
    @Published var highHandle: SliderHandle
    @Published var lowHandle: SliderHandle
    
    //Handle start percentage (also for starting point)
    @SliderValue var highHandleStartPercentage = 1.0
    @SliderValue var lowHandleStartPercentage = 0.0
    
    final var anyCancellableHigh: AnyCancellable?
    final var anyCancellableLow: AnyCancellable?
    
    init(start: Double, end: Double) {
        valueStart = start
        valueEnd = end
        
        highHandle = SliderHandle(sliderWidth: width,
                                  sliderHeight: lineWidth,
                                  sliderValueStart: valueStart,
                                  sliderValueEnd: valueEnd,
                                  startPercentage: _highHandleStartPercentage
        )
        
        lowHandle = SliderHandle(sliderWidth: width,
                                 sliderHeight: lineWidth,
                                 sliderValueStart: valueStart,
                                 sliderValueEnd: valueEnd,
                                 startPercentage: _lowHandleStartPercentage
        )
        
        anyCancellableHigh = highHandle.objectWillChange.sink { _ in
            self.objectWillChange.send()
        }
        anyCancellableLow = lowHandle.objectWillChange.sink { _ in
            self.objectWillChange.send()
        }
    }
    
    //Percentages between high and low handle
    var percentagesBetween: String {
        return String(format: "%.2f", highHandle.currentPercentage.wrappedValue - lowHandle.currentPercentage.wrappedValue)
    }
    
    //Value between high and low handle
    var valueBetween: String {
        return String(format: "%.2f", highHandle.currentValue - lowHandle.currentValue)
    }
}


struct SliderView: View {
    @ObservedObject var slider: CustomSlider
    
    var body: some View {
        RoundedRectangle(cornerRadius: slider.lineWidth)
            .fill(Color.gray.opacity(0.2))
            .frame(width: slider.width, height: slider.lineWidth)
            .overlay(
                ZStack {
                    //Path between both handles
                    SliderPathBetweenView(slider: slider)
                    
                    //Low Handle
                    SliderHandleView(handle: slider.lowHandle)
                        .highPriorityGesture(slider.lowHandle.sliderDragGesture)
                    
                    //High Handle
                    SliderHandleView(handle: slider.highHandle)
                        .highPriorityGesture(slider.highHandle.sliderDragGesture)
                }
            )
    }
}

struct SliderHandleView: View {
    @ObservedObject var handle: SliderHandle
    
    var body: some View {
        Circle()
            .frame(width: handle.diameter, height: handle.diameter)
            .foregroundColor(.white)
            .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 0)
            .scaleEffect(handle.onDrag ? 1.3 : 1)
            .contentShape(Rectangle())
            .position(x: handle.currentLocation.x, y: handle.currentLocation.y)
    }
}

struct SliderPathBetweenView: View {
    @ObservedObject var slider: CustomSlider
    
    var body: some View {
        Path { path in
            path.move(to: slider.lowHandle.currentLocation)
            path.addLine(to: slider.highHandle.currentLocation)
        }
        .stroke(Color("Green"), lineWidth: slider.lineWidth)
    }
}

