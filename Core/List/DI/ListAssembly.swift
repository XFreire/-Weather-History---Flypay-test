//
//  ListAssembly.swift
//  Core
//
//  Created by Alexandre Freire García on 3/11/17.
//  Copyright © 2017 Flypay. All rights reserved.
//

import Foundation

final public class ListAssembly {
    private let webServiceAssembly: WebServiceAssembly
    private let geolocationAssembly: GeolocationServiceAssembly
    private let containerAssembly: WeatherContainerAssembly
    
    init(webServiceAssembly: WebServiceAssembly, geolocationAssembly: GeolocationServiceAssembly, containerAssembly: WeatherContainerAssembly) {
        self.webServiceAssembly = webServiceAssembly
        self.geolocationAssembly = geolocationAssembly
        self.containerAssembly = containerAssembly
    }
    
    func presenter() -> WeatherPresenter {
        return WeatherPresenter(container: containerAssembly.container, repository: repository())
    }
    
    func cellPresenter() -> CellPresenter {
        return CellPresenter(dateFormatter: webServiceAssembly.dateFormatter)
    }
    
    func currentWeatherViewPresenter() -> CurrentWeatherPresenter {
        return CurrentWeatherPresenter()
    }
    
    func repository() -> WeatherRepositoryProtocol {
        return WeatherRepository(webService: webServiceAssembly.webService, geolocationService: geolocationAssembly.geolocationService)
    }
    
    public func viewController() -> UIViewController {
        return WeatherViewController(presenter: presenter(), cellPresenter: cellPresenter(), currentWeatherPresenter: currentWeatherViewPresenter())
    }
    
}
