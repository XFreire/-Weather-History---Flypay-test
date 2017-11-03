//
//  Weather+WeatherResponse.swift
//  Core
//
//  Created by Alexandre Freire García on 3/11/17.
//  Copyright © 2017 Flypay. All rights reserved.
//

import Foundation

extension Weather {
    init(weatherResponse: WeatherResponse) {

        self.identifier = weatherResponse.identifier
        self.name = weatherResponse.description.first!.name
        self.description = weatherResponse.description.first!.description
        self.date = String(weatherResponse.date)
        
        self.city = weatherResponse.city
        self.latitude = weatherResponse.coordinates.latitude
        self.longitude = weatherResponse.coordinates.longitude
        self.icon = weatherResponse.description.first!.icon
    }
}
