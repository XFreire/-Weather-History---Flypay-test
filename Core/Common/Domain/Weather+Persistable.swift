//
//  Weather+Persistable.swift
//  Core
//
//  Created by Alexandre Freire García on 3/11/17.
//  Copyright © 2017 Flypay. All rights reserved.
//

import CoreData

extension Weather: Persistable {

    init(managedObject: WeatherEntry) {
        self.identifier = managedObject.identifier
        self.name = managedObject.name
        self.description = managedObject.summary
        self.date = String(managedObject.date)
        self.city = managedObject.city
        self.latitude = managedObject.latitude
        self.longitude = managedObject.longitude
        self.icon = managedObject.icon
    }
    
    func managedObject(moc: NSManagedObjectContext) -> WeatherEntry {
        let entry = WeatherEntry(context: moc)
        entry.identifier = identifier
        entry.name = name
        entry.summary = description
        entry.date = Double(date)!
        entry.city = city
        entry.latitude = latitude
        entry.longitude = longitude
        entry.icon = icon
        
        return entry
    }
    
}
