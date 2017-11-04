//
//  WeatherCellTableViewCell.swift
//  Core
//
//  Created by Alexandre Freire García on 3/11/17.
//  Copyright © 2017 Flypay. All rights reserved.
//

import UIKit
import RxSwift

final class WeatherCellTableViewCell: UITableViewCell, NibLoadableView, ReusableView {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    
    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}
