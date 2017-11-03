//
//  CurrentWeatherView.swift
//  Core
//
//  Created by Alexandre Freire García on 3/11/17.
//  Copyright © 2017 Flypay. All rights reserved.
//

import UIKit

final class CurrentWeatherView: UIView, NibLoadableView {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var currentWeatherImageView: UIImageView!
    @IBOutlet weak var saveButton: UIButton! {
        didSet {
            saveButton.layer.borderWidth = 1
            saveButton.layer.borderColor = saveButton.tintColor.cgColor
            saveButton.layer.cornerRadius = 5
            saveButton.clipsToBounds = true
        }
    }

}
