//
//  WeatherEntry.swift
//  Core
//
//  Created by Alexandre Freire García on 3/11/17.
//  Copyright © 2017 Flypay. All rights reserved.
//

import CoreData

internal class WeatherEntry: NSManagedObject {
    @NSManaged var identifier: Int
    @NSManaged var name: String
    @NSManaged var summary: String
    @NSManaged var icon: String
    @NSManaged var date: Double
    @NSManaged var city: String
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
    
}

extension WeatherEntry {
    static func defaultFetchRequest() -> NSFetchRequest<WeatherEntry> {
        let fetchRequest = NSFetchRequest<WeatherEntry>(entityName: "WeatherEntry")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)] 
        return fetchRequest
    }
}
