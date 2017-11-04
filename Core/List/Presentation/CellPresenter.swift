//
//  CellPresenter.swift
//  Core
//
//  Created by Alexandre Freire García on 3/11/17.
//  Copyright © 2017 Flypay. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

final class CellPresenter {
    private let dateFormatter: DateFormatter
    private let imageRepository: ImageRepositoryProtocol
    
    init(dateFormatter: DateFormatter, imageRepository: ImageRepositoryProtocol) {
        self.dateFormatter = dateFormatter
        self.imageRepository = imageRepository
    }
    
    func present(weather: Weather, in cell: WeatherCellTableViewCell) {
        bindIcon(at: weather.icon, to: cell)
        cell.cityLabel.text = weather.city.uppercased()
        let s = Date(timeIntervalSince1970: TimeInterval(exactly: Double(weather.date)!)!)
        
        cell.dateLabel.text = dateFormatter.string(from: s)
        cell.descriptionLabel.text = weather.description.capitalized
        
    }
}

private extension CellPresenter {
    func bindIcon(at path: String?, to cell: WeatherCellTableViewCell) {
        guard let path = path else {
            return
        }
        
        imageRepository.image(at: path)
            .observeOn(MainScheduler.instance)
            .bind(to: cell.iconView.rx.image)
            .disposed(by: cell.disposeBag)
    }
}
