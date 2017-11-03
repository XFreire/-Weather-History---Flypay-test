//
//  WeatherViewController.swift
//  Core
//
//  Created by Alexandre Freire García on 3/11/17.
//  Copyright © 2017 Flypay. All rights reserved.
//

import UIKit
import RxSwift

final class WeatherViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView! {
        didSet{
            tableView.register(WeatherCellTableViewCell.self)
        }
    }
    
    @IBOutlet weak var stackView: UIStackView!
    
    // MARK: - Properties
    private let presenter: WeatherPresenter
    private let cellPresenter: CellPresenter
    private let currentWeatherPresenter: CurrentWeatherPresenter
    private let disposeBag = DisposeBag()
    
    // MARK: - Initialization
    init(presenter: WeatherPresenter, cellPresenter: CellPresenter, currentWeatherPresenter: CurrentWeatherPresenter) {
        self.presenter = presenter
        self.cellPresenter = cellPresenter
        self.currentWeatherPresenter = currentWeatherPresenter
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        presenter.didLoad()
    }
}

extension WeatherViewController: WeatherListView {
    func update(withCurrentWeather weather: Weather) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        let currentWeatherView = CurrentWeatherView.instantiate()
        currentWeatherPresenter.present(weather: weather, in: currentWeatherView)
        stackView.addArrangedSubview(currentWeatherView)
    }
    
    func update(with weathers: [Weather]) {
        Observable.from(optional: weathers)
            .bind(to: tableView.rx.items) { [weak self] tableView, _, weather in
                let cell = tableView.dequeueReusableCell(WeatherCellTableViewCell.self)
                self?.cellPresenter.present(weather: weather, in: cell)
                
                return cell
            }
            .disposed(by: disposeBag)

    }
    
    
}
