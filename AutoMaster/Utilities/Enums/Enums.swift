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
    case manual = "1"
    case automatic  = "2"
    case semi_Automatic = "3"
    var id: String {
        switch self {
        case .manual:
            return "Manual"
        case .automatic:
            return "Automatic"
        case .semi_Automatic:
            return "Semi-automatic"
        }
    }
    
}

enum FuelType: String, CaseIterable, Identifiable {
    case gasoline = "1"
    case diesel = "2"
    case gas = "3"
    case hybrid = "5"
    case electric = "6"
    case other = "7"
    case electricGasoline
    case electricDiesel
    var id: String {
        switch self {
        case .gasoline:
            return "Gasoline"
        case .diesel:
            return "Diesel"
        case .gas:
            return "Gas"
        case .hybrid:
            return "Hybrid"
        case .electric:
            return "Electric"
        case .other:
            return "Other"
        case .electricGasoline:
            return "Electric-gasoline"
        case .electricDiesel:
            return "Electroc-diesel"
        }
    }
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
    case any
    case black = "2"
    case blue = "3"
    case brown = "5"
    case gold = "6"
    case green = "7"
    case gray = "8"
    case orange = "9"
    case purple = "12"
    case pink = "11"
    case red = "13"
    case violet = "10"
    case white = "15"
    case yellow = "16"
    
    var id: String {
        switch self {
        case .any:
            return "Any"
        case .black:
            return "Black"
        case .blue:
            return "Blue"
        case .brown:
            return "Brown"
        case .gold:
            return "Gold"
        case .green:
            return "Green"
        case .gray:
            return "Gray"
        case .orange:
            return "Orange"
        case .purple:
            return "Purple"
        case .pink:
            return "Pink"
        case .red:
            return "Red"
        case .violet:
            return "Violet"
        case .white:
            return "White"
        case .yellow:
            return "Yellow"
        }
    }
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
