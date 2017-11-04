//
//  CoreAssembly.swift
//  Core
//
//  Created by Alexandre Freire García on 3/11/17.
//  Copyright © 2017 Flypay. All rights reserved.
//

import Foundation

final public class CoreAssembly {
    private(set) lazy var imageLoadingAssembly = ImageLoadingAssembly()
    private(set) lazy var webServiceAssembly: WebServiceAssembly = WebServiceAssembly()
    private(set) lazy var geolocationAssembly = GeolocationServiceAssembly()
    private(set) lazy var containerAssembly = WeatherContainerAssembly()
    public private(set) lazy var listAssembly = ListAssembly(webServiceAssembly: webServiceAssembly, geolocationAssembly: geolocationAssembly, containerAssembly: containerAssembly, imageLoadingAssembly: imageLoadingAssembly)
    
    private let navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
}
