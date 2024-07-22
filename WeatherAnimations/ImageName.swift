//
//  ImageName.swift
//  WeatherAnimations
//
//  Created by Байсангур on 21.07.2024.
//

import Foundation
import UIKit

enum ImageName: String, CaseIterable {
    case sunny
    case showers
    case snow
    case hail
    case snowFlurries
    case foggy
    case thunderstroms
    case tornado
    case windy
    case sleet
    case clearCloudy
    case cloudy
    case cold
    case hot
    case drizzle
    case isolatedThunderstroms
    case mostlyCloudy
    case partlyCloudy
    
    
    var image: UIImage? {
        return UIImage(named: self.rawValue)
    }
}
