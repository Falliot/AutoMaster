//
//  MenuView.swift
//  AutoMaster
//
//  Created by Anton on 07.11.2021.
//

import SwiftUI

struct MenuView: View {
    @ObservedObject var viewModel = MenuViewModel()

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Text("Settings")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(spacing: 15) {
                        Text("A")
                            .font(.system(size: 25, weight: .semibold, design: .rounded))
                            .foregroundColor(.white)
                            .frame(width: 60, height: 60)
                            .background(Color("Green"))
                            .clipShape(Circle())
                            .offset(y: -30)
                            .padding(.bottom, -30 )
                        
                        Text("Anton Pustovidko")
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                    }
                    .frame(maxWidth: .infinity)
                    .padding([.horizontal, .bottom])
                    .background(
                        Color.white.cornerRadius(12)
                    )
                    .padding()
                    .padding(.top, 40)
                    
                    CustomNavigationLink(title: "Edit Profile") {
                        Text("")
                            .navigationTitle("Edit Profile")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("HomeBG").ignoresSafeArea())
                    }
                    
                    CustomNavigationLink(title: "Notifications") {
                        Text("")
                            .navigationTitle("Notifications")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("HomeBG").ignoresSafeArea())
                    }
                    
                    CustomNavigationLink(title: "Feedback") {
                        Text("")
                            .navigationTitle("Feedback")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("HomeBG").ignoresSafeArea())
                    }
                    
                    CustomNavigationLink(title: "Rate us") {
                        Text("")
                            .navigationTitle("Rate us")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("HomeBG").ignoresSafeArea())
                    }
                    
                    CustomNavigationLink(title: "Language") {
                        Text("")
                            .navigationTitle("Language")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("HomeBG").ignoresSafeArea())
                    }
                    
                    CustomNavigationLink(title: "Privacy Policy") {
                        Text("")
                            .navigationTitle("Privacy Policy")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("HomeBG").ignoresSafeArea())
                    }
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 22)
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
            Color("HomeBG")
                .ignoresSafeArea()
                )
        }
    }
    
    @ViewBuilder
    func CustomNavigationLink<Detail: View>(title: String, @ViewBuilder content: @escaping () -> Detail) -> some View {
        
        NavigationLink {
            content()
        } label: {
            
            HStack {
                Text(title)
                    .font(.system(size: 17, weight: .semibold, design: .rounded))
                Spacer()
                Image(systemName: "chevron.right")
            }
            .foregroundColor(.black)
            .padding()
            .background(
                Color.white.cornerRadius(12)
            )
            .padding(.horizontal)
            .padding(.top, 10)
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
