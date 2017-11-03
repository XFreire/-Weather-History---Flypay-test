//
//  WeatherResponse.swift
//  Core
//
//  Created by Alexandre Freire García on 3/11/17.
//  Copyright © 2017 Flypay. All rights reserved.
//

import Foundation

struct WeatherResponse: Decodable {
    
    struct Coordinates: Decodable {
        let latitude: Double
        let longitude: Double
        
        private enum CodingKeys: String, CodingKey {
            case latitude = "lat"
            case longitude = "lon"
        }
    }
    
    struct Description: Decodable {
        let name: String
        let description: String
        let icon: String
        
        private enum CodingKeys: String, CodingKey {
            case name = "main"
            case description
            case icon
        }
    }
    
    let identifier: Int
    let coordinates: Coordinates
    let description: [Description]
    let date: Double
    let city: String
    
    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case coordinates = "coord"
        case description = "weather"
        case date = "dt"
        case city = "name"
    }
    
    
    
}
