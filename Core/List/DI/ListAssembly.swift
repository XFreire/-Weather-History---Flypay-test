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
    private let imageLoadingAssembly: ImageLoadingAssembly
    
    init(webServiceAssembly: WebServiceAssembly, geolocationAssembly: GeolocationServiceAssembly, containerAssembly: WeatherContainerAssembly, imageLoadingAssembly: ImageLoadingAssembly) {
        self.webServiceAssembly = webServiceAssembly
        self.geolocationAssembly = geolocationAssembly
        self.containerAssembly = containerAssembly
        self.imageLoadingAssembly = imageLoadingAssembly
    }
    
    func presenter() -> WeatherPresenter {
        return WeatherPresenter(container: containerAssembly.container, repository: repository())
    }
    
    func cellPresenter() -> CellPresenter {
        return CellPresenter(dateFormatter: webServiceAssembly.dateFormatter, imageRepository: imageLoadingAssembly.imageRepository)
    }
    
    func currentWeatherViewPresenter() -> CurrentWeatherPresenter {
        return CurrentWeatherPresenter(imageRepository: imageLoadingAssembly.imageRepository)
    }
    
    func repository() -> WeatherRepositoryProtocol {
        return WeatherRepository(webService: webServiceAssembly.webService, geolocationService: geolocationAssembly.geolocationService)
    }
    
    public func viewController() -> UIViewController {
        return WeatherViewController(presenter: presenter(), cellPresenter: cellPresenter(), currentWeatherPresenter: currentWeatherViewPresenter())
    }
    
}
