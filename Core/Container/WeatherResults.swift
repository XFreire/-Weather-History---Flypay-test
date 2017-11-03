//
//  WeatherResults.swift
//  Core
//
//  Created by Alexandre Freire García on 3/11/17.
//  Copyright © 2017 Flypay. All rights reserved.
//

import CoreData

protocol WeatherResultsProtocol {
    var didUpdate: () -> Void { get set }
    var numberOfWeathers: Int { get }
    func weather(at index: Int) -> Weather
    var list: [Weather] { get }
}

internal final class WeatherResults: NSObject, WeatherResultsProtocol {
    
    
    // MARK: - WeatherResultsProtocol
    var didUpdate: () -> Void = {}
    
    var numberOfWeathers: Int {
        return resultsController.fetchedObjects?.count ?? 0
    }
    
    func weather(at index: Int) -> Weather {
        let indexPath = IndexPath(indexes: [0, index])
        let entry = resultsController.object(at: indexPath)
        return Weather(managedObject: entry)
    }
    
    var list: [Weather] {
        return resultsController.fetchedObjects
            .flatMap{ $0.forEach{
                Weather(managedObject: $0) }
            }
    }

    
    // MARK: - Properties
    private let resultsController : NSFetchedResultsController<WeatherEntry>

    // MARK: - Initialization
    init(fetchRequest: NSFetchRequest<WeatherEntry>, context: NSManagedObjectContext) {
        
        resultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        super.init()
        resultsController.delegate = self
        try! resultsController.performFetch()
        
    }
}

extension WeatherResults: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        didUpdate()
    }
}

