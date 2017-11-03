//
//  WeatherContainer.swift
//  Core
//
//  Created by Alexandre Freire García on 3/11/17.
//  Copyright © 2017 Flypay. All rights reserved.
//

import CoreData
import RxSwift

protocol WeatherContainerProtocol {
    func load() -> Observable<Void>
    func save(weather: Weather) -> Observable<Void>
    func all() -> WeatherResultsProtocol
}

final class WeatherContainer {
    // MARK: - Properties
    fileprivate let container: NSPersistentContainer
    
    // MARK: - Initialization
    private init(container: NSPersistentContainer) {
        self.container = container
        self.container.viewContext.automaticallyMergesChangesFromParent = true
    }

    public convenience init(name: String){
        let bundle = Bundle(for: type(of: self))
        let model = NSManagedObjectModel.mergedModel(from: [bundle])!
        let container = NSPersistentContainer(name: name, managedObjectModel: model)
        self.init(container: container)
    }
    
    public static func temporary() -> WeatherContainer {
        let bundle = Bundle(for: WeatherContainer.self)
        let model = NSManagedObjectModel.mergedModel(from: [bundle])!
        let container = TemporaryPersistentContainer(managedObjectModel: model)
        
        return WeatherContainer(container: container)
    }
}

extension WeatherContainer {
    private func performBackgroundTask(_ task: @escaping (NSManagedObjectContext) throws ->Void) -> Observable<Void> {
    
        return Observable<Void>.create { observer in
            
            self.container.performBackgroundTask { context in
                do {
                    try task(context)
                    observer.onNext(())
                    observer.onCompleted()
                } catch {
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
}

extension WeatherContainer: WeatherContainerProtocol {
    func load() -> Observable<Void> {
        return Observable.create { observer in
            self.container.loadPersistentStores(completionHandler: { _, error in
                if let error = error {
                    observer.onError(error)
                }
                else{
                    observer.onNext(())
                    observer.onCompleted()
                }
            })
            
            return Disposables.create()
            
        }
    }
    
    func save(weather: Weather) -> Observable<Void> {
        return performBackgroundTask { context in
            let _ = weather.managedObject(moc: context)
            try context.save()
        }
    }
    
    func all() -> WeatherResultsProtocol {
        return WeatherResults(fetchRequest: WeatherEntry.defaultFetchRequest(), context: container.viewContext)
    }
    
    
}
