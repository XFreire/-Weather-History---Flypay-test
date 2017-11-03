//
//  CurrentWeatherView.swift
//  Core
//
//  Created by Alexandre Freire García on 3/11/17.
//  Copyright © 2017 Flypay. All rights reserved.
//

import UIKit

final class CurrentWeatherView: UIView, NibLoadableView {
    private enum Constants {
        static let height: CGFloat = 116
    }
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton! {
        didSet {
            saveButton.layer.borderWidth = 1
            saveButton.layer.borderColor = saveButton.tintColor.cgColor
            saveButton.layer.cornerRadius = 5
            saveButton.titleLabel?.text = NSLocalizedString("Save", comment: "").uppercased()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIViewNoIntrinsicMetric, height: Constants.height)
    }
    
}
