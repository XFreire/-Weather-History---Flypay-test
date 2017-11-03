//
//  WeatherPresenter.swift
//  Core
//
//  Created by Alexandre Freire García on 3/11/17.
//  Copyright © 2017 Flypay. All rights reserved.
//

import RxSwift



final class WeatherPresenter {
    
    private let repository: WeatherRepositoryProtocol
    private let container: WeatherContainerProtocol
    private lazy var results = container.all()
    private let disposeBag = DisposeBag()
    
    var didUpdate: () -> Void = {}

    var didUpdateCurrentWeather: (Weather) -> Void = { _ in }
    
    var numberOfWeathers: Int {
        return results.numberOfWeathers
    }
    
    func item(at position: Int) -> Weather {
        return results.weather(at: position)
    }
    
    init(container: WeatherContainerProtocol, repository: WeatherRepositoryProtocol) {
        self.repository = repository
        self.container = container
        
        self.results.didUpdate = { [weak self] in
            self?.didUpdate()
        }
        
        
        
    }
    
    func didLoad() {
        repository.weatherForCurrentPosition()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { weather in
                self.didUpdateCurrentWeather(weather)
            })
            .disposed(by: disposeBag)
    }
    
    func didTapSaveWeather(_ weather: Weather) {
        container.save(weather: weather)
            .subscribe(onNext: { [weak self] in
                guard let `self` = self else { return }
                self.didUpdate()
            })
            .disposed(by: disposeBag)
    }
}
