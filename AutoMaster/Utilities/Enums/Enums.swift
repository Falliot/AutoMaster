//
//  Enums.swift
//  AutoMaster
//
//  Created by Anton on 17.11.2021.
//

import Foundation

enum BodyType {
    case compact, sedan, stationWagon, convertible, coupe, pickUp, van, transporter
}

enum AutoCondition {
    case any, new, used
}

enum Transmission {
    case manual, automatic, semiAutomatic
}

enum FuelType: String {
    case gasoline = "Gasoline"
    case electric = "Electric"
//    diesel, electricGasoline, electricDiesel, cng, ethanol, hydroge, lpg, others
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
    
    enum InteriorColor {
        case any, beige, black, blue, brown, green, grey, orange, red, white, yellow, other
    }
}
