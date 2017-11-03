//
//  ListAssembly.swift
//  Core
//
//  Created by Alexandre Freire García on 3/11/17.
//  Copyright © 2017 Flypay. All rights reserved.
//

import Foundation

final class ListAssembly {
    private(set) lazy var webServiceAssembly: WebServiceAssembly = WebServiceAssembly()
    private(set) lazy var geolocationAssembly = GeolocationServiceAssembly()
    private(set) lazy var containerAssembly = WeatherContainerAssembly()
    
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
    
    func viewController() -> UIViewController {
        return WeatherViewController(presenter: presenter(), cellPresenter: cellPresenter(), currentWeatherPresenter: currentWeatherViewPresenter())
    }
    
}
