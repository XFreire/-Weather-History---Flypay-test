//
//  Weather+WeatherResponse.swift
//  Core
//
//  Created by Alexandre Freire García on 3/11/17.
//  Copyright © 2017 Flypay. All rights reserved.
//

import Foundation

extension Weather {
    init?(weatherResponse: WeatherResponse) {
        guard let name = weatherResponse.description.first?.name,
        let description = weatherResponse.description.first?.description,
        let icon = weatherResponse.description.first?.icon else {
            return nil
        }
        
        self.identifier = weatherResponse.identifier
        self.name = name
        self.description = description
        self.date = String(weatherResponse.date)
        self.city = weatherResponse.city
        self.latitude = weatherResponse.coordinates.latitude
        self.longitude = weatherResponse.coordinates.longitude
        self.icon = icon
    }
}
