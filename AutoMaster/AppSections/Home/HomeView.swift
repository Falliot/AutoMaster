//
//  HomeView.swift
//  AutoMaster
//
//  Created by Anton on 07.11.2021.
//

import SDWebImageSwiftUI
import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()

    var body: some View {
        List {
            ForEach(viewModel.manufacturerModel) { car in
                Text(car.name)
                WebImage(url: URL(string: car.image.optimized))
                    // Supports options and context, like `.delayPlaceholder` to show placeholder only when error
                    .onSuccess { _, _, _ in
                        // Success
                        // Note: Data exist only when queried from disk cache or network. Use `.queryMemoryData` if you really need data
                    }
                    .resizable() // Resizable like SwiftUI.Image, you must use this modifier or the view will use the image bitmap size
                    .placeholder(Image(systemName: "photo")) // Placeholder Image
                    // Supports ViewBuilder as well
                    .placeholder {
                        Rectangle().foregroundColor(.gray)
                    }
                    .indicator(.activity) // Activity Indicator
                    .transition(.fade(duration: 0.5)) // Fade Transition with duration
                    .scaledToFit()
                    .frame(width: 50, height: 50, alignment: .center)
            }
        }

        .onAppear {
            if let localData = FileManager.shared.readLocalFile(forName: "CarData") {
                viewModel.manufacturerModel = Utilities.shared.parse(jsonData: localData)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
