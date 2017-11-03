//: Playground - noun: a place where people can play

@testable import Core
import RxSwift
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let webService = WebService(configuration: WebServiceConfiguration.default)

let disposeBag = DisposeBag()

let request = Endpoint.weatherCoordinates(lat: 40, long: 3).request(with: URL(string: "https://api.openweathermap.org/data/2.5")!, adding: WebServiceConfiguration.default.parameters)

print(request)

//webService.load(WeatherResponse.self, from: .weather(city: "London"))
//    .map{ Weather(weatherResponse: $0) }
//    .subscribe(onNext: { response in
//        print(response ?? "")
//    }, onError: { error in
//
//        print("error: \(error)")
//    })
//    .disposed(by: disposeBag)

webService.load(WeatherResponse.self, from: .weatherCoordinates(lat: 40, long: 3))
    .map{ Weather(weatherResponse: $0) }
    .subscribe(onNext: { response in
        print(response ?? "")
    }, onError: { error in
        
        print("error: \(error)")
    })
    .disposed(by: disposeBag)


