//: Playground - noun: a place where people can play

@testable import Core
import RxSwift

let container = WeatherContainer.temporary()
let disposeBag = DisposeBag()

container.load()
    .subscribe()
    .disposed(by: disposeBag)

let weather = Weather(identifier: 1, name: "Rain", description: "Rain", date: "123124124124", city: "London", latitude: 40, longitude: 8, icon: "08")

container.save(weather: weather)
    .subscribe(onNext: {
        print("saved")
    }, onError: {
        print("error \($0)")
    })
    .disposed(by: disposeBag)




