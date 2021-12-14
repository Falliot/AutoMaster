//
//  TransportViewModel.swift
//  AutoMaster
//
//  Created by Anton Pustovidko on 14/12/2021.
//

import SwiftUI
import Alamofire

class TransportViewModel: ObservableObject {
    @Published var carPhotos: [String] = []
    
    func autoRiaGetImages(carId: String) {
        AF.request(Constants.Endpoints.autoRiaCarPhotos + "\(carId)?api_key=\(Constants.APIKeys.autoRiaAPI)")
            .validate()
            .responseData { [weak self] response in
                guard let data = response.value else {
                    print(response.debugDescription)
                    return
                }
                
                do {
                    let photoData = try JSONDecoder().decode(AutoRiaCarIdPhotoResponse.self, from: data)
                    
                    self?.carPhotos = []
                    
                    if let responseDictionary = photoData.photos.values.first?.values {
                        for value in responseDictionary {
                            self?.carPhotos.append(value.formats[0])
                        }
                    }
                } catch(let error) {
                    print(error)
                }
                
            }
    }
}
