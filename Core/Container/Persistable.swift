//
//  Persistable.swift
//  Core
//
//  Created by Alexandre Freire García on 3/11/17.
//  Copyright © 2017 Flypay. All rights reserved.
//

import CoreData

public protocol Persistable {
    associatedtype ManagedObject: NSManagedObject
    associatedtype Context: NSManagedObjectContext
    init(managedObject: ManagedObject)
    func managedObject(moc: Context) -> ManagedObject
}
