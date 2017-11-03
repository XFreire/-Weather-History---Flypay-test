//
//  CurrentWeatherPresenter.swift
//  Core
//
//  Created by Alexandre Freire García on 3/11/17.
//  Copyright © 2017 Flypay. All rights reserved.
//

import Foundation

final class CurrentWeatherPresenter {
    
    func present(weather: Weather, in view: CurrentWeatherView) {
        view.cityLabel.text = weather.city
        
    }
}
