//
//  TemporaryPersistentContainer.swift
//  Core
//
//  Created by Alexandre Freire García on 3/11/17.
//  Copyright © 2017 Flypay. All rights reserved.
//

import Foundation
import CoreData

internal final class TemporaryPersistentContainer: NSPersistentContainer {
    override class func defaultDirectoryURL() -> URL {
        return URL(fileURLWithPath: NSTemporaryDirectory())
    }
    
    init(managedObjectModel model: NSManagedObjectModel) {
        super.init(name: UUID().uuidString, managedObjectModel: model)
    }
}
