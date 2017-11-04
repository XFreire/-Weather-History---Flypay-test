//
//  File.swift
//  Core
//
//  Created by Alexandre Freire García on 3/11/17.
//  Copyright © 2017 Flypay. All rights reserved.
//

import RxSwift

protocol WeatherRepositoryProtocol {
    func weather(for city: String) -> Observable<Weather>
    func weather(for latitude: Double, longitude: Double) -> Observable<Weather>
    func weatherForCurrentPosition() -> Observable<Weather>
}

final class WeatherRepository: WeatherRepositoryProtocol {
    private let geolocationService: GeolocationService
    private let webService: WebService
    
    init(webService: WebService, geolocationService: GeolocationService) {
        self.geolocationService = geolocationService
        self.webService = webService
        
    }
    
    func weather(for city: String) -> Observable<Weather> {
        return webService.load(WeatherResponse.self, from: .weather(city: city))
            .map{ Weather(weatherResponse: $0)  }
    }
    
    func weather(for latitude: Double, longitude: Double) -> Observable<Weather> {
        return webService.load(WeatherResponse.self, from: .weatherCoordinates(lat: latitude, long: longitude)).map{ Weather(weatherResponse: $0) }
    }
    
    func weatherForCurrentPosition() -> Observable<Weather> {
        return geolocationService.location
            .flatMapLatest{ [weak self] coords in
                self?.weather(for: coords.latitude, longitude: coords.longitude) ?? Observable.empty()
            }
            .do(onNext: { [weak self] _ in
                self?.geolocationService.stopLocationUpdates()
            })
        
    }
}

