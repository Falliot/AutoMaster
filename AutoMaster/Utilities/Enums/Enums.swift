//
//  Enums.swift
//  AutoMaster
//
//  Created by Anton on 17.11.2021.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case home = "home"
    case search = "search"
    case favorites = "favorites"
    case menu = "menu"
}

enum PopOver {
    case technical, basic, equipment, color, description, none
    
}

enum BodyType {
    case compact, sedan, stationWagon, convertible, coupe, pickUp, van, transporter
}

enum AutoCondition {
    case any, new, used
}

enum Transmission: String, CaseIterable, Identifiable {
    case manual, automatic, semi_Automatic
    var id: String { self.rawValue.capitalized }
    
}

enum FuelType: String, CaseIterable, Identifiable {
    case gasoline, electric, diesel, electricGasoline, electricDiesel, cng, ethanol, hydroge, lpg, others
    var id: String { self.rawValue.capitalized }
}

enum Equipment {
    enum Comfort {
        case airConditioning, powerWindows, splitRearSeats, tintedWindows
    }
    
    enum Entertainment {
        case cdPlayer, radio
    }
    
    enum Safety {
        case abs, centralDoorLock, driverSideAirbag, fogLights, immobilizer, isofix, passengerSideAirbag, powerSteering, sideAirbag
    }
    
    enum Extras {
        case catalyticConverter, steelWheels, winterTyres
    }
}

enum ColorAndUpholstery {
    enum InteriorFitting { //Upholstery
        case any, alcantara, cloth, fullLeather, partLeather, velour, other
    }
    
    enum PaintWork {
        
    }
    
    enum BodyColor {
        case any, beige, black, blue, bronze, brown, gold, green, grey, orange, red, silver, violet, white, yellow
        case metalic
        // metallic ?
        // alloy wheels ? (In Paint, RIMS)
    }
}
enum InteriorColor: String, CaseIterable, Identifiable {
    case any, black, blue, brown, gold, green, gray, orange, purple, pink, red, violet, white, yellow
    var id: String { self.rawValue.capitalized }
    var color: Color {
        switch self {
        case .any:
            return Color.clear
        case .black:
            return .black
        case .blue:
            return .blue
        case .brown:
            return .brown
        case .gold:
            return Color(red: 255, green: 215, blue: 0)
        case .green:
            return .green
        case .gray:
            return .gray
        case .orange:
            return .orange
        case .purple:
            return .purple
        case .pink:
            return .pink
        case .red:
            return .red
        case .violet:
            return Color(red: 143, green: 0, blue: 255)
        case .white:
            return .white
        case .yellow:
            return .yellow
        }
    }
}
