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
    
    func testWeatherResponse_mapping_weatherModel() {
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
    
    func testWeatherResponse_mapping_fromJSON() {
        let bundle = Bundle(for: type(of: self))
        if let file = bundle.url(forResource: "weather", withExtension: "json") {
            do {
                let data = try! Data(contentsOf: file)
                let decoder = JSONDecoder()
                let weatherResponse = try! decoder.decode(WeatherResponse.self, from: data)
                XCTAssertEqual(weatherResponse.identifier, 2643743)
                XCTAssertEqual(weatherResponse.coordinates.latitude, 51.51)
                XCTAssertEqual(weatherResponse.coordinates.longitude, -0.13)
                XCTAssertEqual(weatherResponse.description.first!.name, "Drizzle")
                XCTAssertEqual(weatherResponse.description.first!.description, "light intensity drizzle")
                XCTAssertEqual(weatherResponse.description.first!.icon, "09d")
                XCTAssertEqual(weatherResponse.date, 1485789600)
                XCTAssertEqual(weatherResponse.city, "London")
            }
        }
    }
    
    
    
}
