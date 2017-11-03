//
//  WebServiceConfiguration.swift
//  Core
//
//  Created by Alexandre Freire García on 3/11/17.
//  Copyright © 2017 Flypay. All rights reserved.
//

import Foundation

internal struct WebServiceConfiguration {
    let apiKey: String
    
    private class Dummy {}
    
    static let `default` = WebServiceConfiguration(apiKey: Bundle(for: WebServiceConfiguration.Dummy.self)
                                                    .infoDictionary?["APPID"] as? String ?? "")
    
    var parameters: [String: String] {
        return ["APPID": apiKey]
    }
}
