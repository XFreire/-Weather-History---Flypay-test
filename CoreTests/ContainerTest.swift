//
//  ContainerTest.swift
//  CoreTests
//
//  Created by Alexandre Freire García on 4/11/17.
//  Copyright © 2017 Flypay. All rights reserved.
//
@testable import Core
import RxSwift
import XCTest

class ContainerTest: XCTestCase {
    // Sut
    var container: WeatherContainerProtocol!
    
    // Collaborators
    let disposeBag = DisposeBag()
    override func setUp() {
        super.setUp()
        container = WeatherContainer.temporary()
        container.load().subscribe().disposed(by: disposeBag)
    }
    
    func testWeatherContainer_noContent_shouldHaveZeroItems() {
        XCTAssertEqual(0, container.all().numberOfWeathers)
    }
    
    func testWeatherContainer_addingItems_shouldHaveCorrectItemsCount() {
        XCTAssertEqual(0, container.all().numberOfWeathers)
        
        let weather1 = Weather(identifier: 1, name: "Test", description: "Test", date: "2017", city: "Test", latitude: 12, longitude: 8, icon: "Test")
        container.save(weather: weather1).subscribe(onNext: { [weak self] in
            XCTAssertEqual(1, self?.container.all().numberOfWeathers)
        }).disposed(by: disposeBag)
        
        let weather2 = Weather(identifier: 2, name: "Test", description: "Test", date: "2017", city: "Test", latitude: 12, longitude: 8, icon: "Test")
        container.save(weather: weather2).subscribe(onNext: { [weak self] in
            XCTAssertEqual(2, self?.container.all().numberOfWeathers)

        }).disposed(by: disposeBag)

    }
    
    func testWeatherContainer_itemAtIndex_shouldReturnTheCorrectItem() {
        let weather1 = Weather(identifier: 1, name: "Test", description: "Test", date: "2017", city: "Test", latitude: 12, longitude: 8, icon: "Test")
        container.save(weather: weather1).subscribe(onNext: { [weak self] in
            let retrieved = (self?.container.all().weather(at: 0))!
            XCTAssertEqual(retrieved.identifier, weather1.identifier)
        }).disposed(by: disposeBag)
        
        let weather2 = Weather(identifier: 2, name: "Test", description: "Test", date: "2017", city: "Test", latitude: 12, longitude: 8, icon: "Test")
        container.save(weather: weather2).subscribe(onNext: { [weak self] in
            let retrieved = (self?.container.all().weather(at: 1))!
            XCTAssertEqual(retrieved.identifier, weather2.identifier)
            
        }).disposed(by: disposeBag)
    }
}
