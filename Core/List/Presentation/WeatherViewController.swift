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
            tableView.rowHeight = 74
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
        
        presenter.didUpdate = tableView.reloadData
        
        presenter.didUpdateCurrentWeather = { [weak self] weather in
            self?.update(withCurrentWeather: weather)
        }
        presenter.didLoad()
    }
}

extension WeatherViewController {
    
    func update(withCurrentWeather weather: Weather) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        let currentWeatherView = CurrentWeatherView.instantiate()
        currentWeatherPresenter.present(weather: weather, in: currentWeatherView)
        
        currentWeatherView.saveButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.presenter.didTapSaveWeather(weather)
            })
            .disposed(by: disposeBag)
        stackView.addArrangedSubview(currentWeatherView)
    }
}

extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfWeathers
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(WeatherCellTableViewCell.self)
        let weather = presenter.item(at: indexPath.item)
        cellPresenter.present(weather: weather, in: cell)
        
        return cell
    }
    
    
}
