//
//  WeatherContainerAssembly.swift
//  Core
//
//  Created by Alexandre Freire García on 3/11/17.
//  Copyright © 2017 Flypay. All rights reserved.
//

import Foundation

final class WeatherContainerAssembly {
    private(set) lazy var container: WeatherContainerProtocol = WeatherContainer.instance

    func temporaryContainer() -> WeatherContainerProtocol {
        return WeatherContainer.temporary()
    }
    
    init() {
        let _ = container.load().subscribe()
    }
    
}
