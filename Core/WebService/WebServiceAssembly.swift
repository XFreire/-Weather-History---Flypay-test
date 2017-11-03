//
//  WebServiceAssembly.swift
//  Core
//
//  Created by Alexandre Freire García on 3/11/17.
//  Copyright © 2017 Flypay. All rights reserved.
//
import Foundation

final class WebServiceAssembly {
    private(set) lazy var webService = WebService(configuration: .default)
    
    private(set) lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        return formatter
    }()
}
