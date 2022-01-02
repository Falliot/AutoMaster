//
//  NotificationView.swift
//  AutoMaster
//
//  Created by Anton Pustovidko on 22/12/2021.
//

import SwiftUI

struct NotificationView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var savedSearches = false
    @State private var favoriteTransport = false
    
    init() {
        UINavigationBar.appearance().isHidden = true
    }
    
    var body: some View {
        VStack {
            //MARK: - Top Bar
            VStack {
                HStack {
                    Button {
                        withAnimation(.easeInOut) {
                            dismiss()
                        }
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(.white)
                        
                    }
                    Spacer()
                    Text("Notifications")
                        .font(.system(size: 23, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                    .opacity(0)
                }
                .padding(.horizontal, 15)
                .padding(.bottom, 10)
            }
            .background(Color("Green"))
            
            
            Group {
                Toggle(isOn: $savedSearches) {
                    Text("Saved Searches")
                        .font(.system(size: 17, weight: .semibold, design: .rounded))
                }
                .padding()
                
                Toggle(isOn: $favoriteTransport) {
                    Text("Favorite Transports")
                        .font(.system(size: 17, weight: .semibold, design: .rounded))
                }
                .padding()
            }
            .toggleStyle(SwitchToggleStyle(tint: Color("Green")))
            
            
        }
        .navigationBarHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
