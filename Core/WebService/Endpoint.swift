//
//  Endpoint.swift
//  Core
//
//  Created by Alexandre Freire García on 3/11/17.
//  Copyright © 2017 Flypay. All rights reserved.
//

import Foundation

internal enum Endpoint {
    case weather(city: String)
    case weatherCoordinates(lat: Double, long: Double)
    case image(name: String)
}

internal extension Endpoint {
    func request(with baseURL: URL, adding parameters: [String: String]) -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        
        var newParameters = self.parameters
        parameters.forEach { newParameters.updateValue($1, forKey: $0) }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.queryItems = newParameters.map(URLQueryItem.init)
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        
        return request
    }
}

private enum HTTPMethod: String {
    case get = "GET"
}

private extension Endpoint {
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .weather:
            return "data/2.5/weather"
        case .weatherCoordinates:
            return "data/2.5/weather"
        case .image(let name):
            return "img/w/\(name).png"
            
        }
        
    }
    var parameters: [String: String] {
        switch self {
        case .weather(let city):
            return ["q" : city]
        case .weatherCoordinates(let latitude, let longitude):
            return [
                "lat" : String(latitude),
                "lon" : String(longitude)
            ]
        case .image:
            return [:]
        }
    }
}
