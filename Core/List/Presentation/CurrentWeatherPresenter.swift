//
//  CurrentWeatherPresenter.swift
//  Core
//
//  Created by Alexandre Freire García on 3/11/17.
//  Copyright © 2017 Flypay. All rights reserved.
//

import RxCocoa
import RxSwift


final class CurrentWeatherPresenter {
    
    private let imageRepository: ImageRepositoryProtocol
    
    init(imageRepository: ImageRepositoryProtocol) {
        self.imageRepository = imageRepository
    }
    
    func present(weather: Weather, in view: CurrentWeatherView) {
        bindIcon(at: weather.icon, to: view)
        view.cityLabel.text = weather.city
        
        
    }
}

private extension CurrentWeatherPresenter {
    func bindIcon(at path: String?, to weatherView: CurrentWeatherView) {
        guard let path = path else {
            return
        }
        
        imageRepository.image(at: path)
            .observeOn(MainScheduler.instance)
            .bind(to: weatherView.iconView.rx.image)
            .disposed(by: weatherView.disposeBag)
    }
}
