//
//  CellPresenter.swift
//  Core
//
//  Created by Alexandre Freire García on 3/11/17.
//  Copyright © 2017 Flypay. All rights reserved.
//

import Foundation

final class CellPresenter {
    private let dateFormatter: DateFormatter
    
    init(dateFormatter: DateFormatter) {
        self.dateFormatter = dateFormatter
    }
    
    func present(weather: Weather, in cell: WeatherCellTableViewCell) {
        cell.cityLabel.text = weather.city.uppercased()
        cell.dateLabel.text = weather.date
        
    }
}
