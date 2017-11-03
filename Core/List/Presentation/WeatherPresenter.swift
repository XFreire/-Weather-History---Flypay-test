//
//  WeatherPresenter.swift
//  Core
//
//  Created by Alexandre Freire García on 3/11/17.
//  Copyright © 2017 Flypay. All rights reserved.
//

import RxSwift

protocol WeatherListView: class {
    func update(withCurrentWeather: Weather)
    func update(with weathers: [Weather])
}

final class WeatherPresenter {
    weak var view: WeatherListView?
    
    private let repository: WeatherRepositoryProtocol
    private let container: WeatherContainerProtocol
    
    private let disposeBag = DisposeBag()
    
    init(container: WeatherContainerProtocol, repository: WeatherRepositoryProtocol) {
        self.repository = repository
        self.container = container
    }
    
    func didLoad() {
        repository.weatherForCurrentPosition()
            .subscribe(onNext: { [weak self] weather in
                guard let `self` = self else { return }
                self.view?.update(withCurrentWeather: weather)
            })
            .disposed(by: disposeBag)
        
        self.view?.update(with: container.all().list)
        
        
    }
}
