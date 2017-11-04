//
//  WeatherTest.swift
//  CoreTests
//
//  Created by Alexandre Freire García on 4/11/17.
//  Copyright © 2017 Flypay. All rights reserved.
//

import XCTest
@testable import Core

class WeatherTest: XCTestCase {
    
    // Sut
    var response: WeatherResponse!
    
    override func setUp() {
        super.setUp()
        response = WeatherResponse(identifier: 1, coordinates: WeatherResponse.Coordinates(latitude: 10, longitude: 10), description: [WeatherResponse.Description(name: "Test", description: "Test", icon: "001")], date: 1234, city: "TestCity")
        
    }
    
    func testWeatherResponseMapping() {
        let weather = Weather(weatherResponse: response)
        XCTAssertEqual(response.identifier, weather.identifier)
        XCTAssertEqual(response.coordinates.latitude, weather.latitude)
        XCTAssertEqual(response.coordinates.longitude, weather.longitude)
        XCTAssertEqual(response.description.first!.name, weather.name)
        XCTAssertEqual(response.description.first!.description, weather.description)
        XCTAssertEqual(response.description.first!.icon, weather.icon)
        XCTAssertEqual(String(response.date), weather.date)
        XCTAssertEqual(response.city, weather.city)
        
    }
    
    
    
}
