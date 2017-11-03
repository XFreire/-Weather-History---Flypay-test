//: Playground - noun: a place where people can play

@testable import Core
import RxSwift
import RxCocoa
import CoreLocation
import PlaygroundSupport

let geolocationService = GeolocationService.instance
let db = DisposeBag()

geolocationService.authorized
    .subscribe(onNext: { print($0) })
    .disposed(by: db)

geolocationService.location
    .subscribe(onNext: { coord in
        print(coord)
    })
    .disposed(by: db)

