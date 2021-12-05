//
//  ViewExtensions.swift
//  AutoMaster
//
//  Created by Anton Pustovidko on 01/12/2021.
//

import SwiftUI

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
    func hidden(hide: Bool) -> some View {
        opacity(hide ? 0 : 1)
    }
    
    func print(_ value: Any) -> Self {
        Swift.print(value)
        return self
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

