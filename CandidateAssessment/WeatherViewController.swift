//
//  ViewController.swift
//  CandidateAssessment
//
//  Created by Daniel Iglesias on 19/06/2017.
//  Copyright © 2017 Flypay. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
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
    
    var dataSource: UITableViewDataSource? = WeatherHistoryTableViewDataSource() {
        didSet {
            guard tableView != nil else { return }
            tableView.dataSource = dataSource
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let historyCellNib = UINib(nibName: "WeatherHistoryTableViewCell", bundle: Bundle.main)
        tableView.register(historyCellNib, forCellReuseIdentifier: "WeatherCellReuseIdentifier")
        tableView.rowHeight = 74
        tableView.dataSource = dataSource
    }
    
    override var prefersStatusBarHidden: Bool { return true }

    @IBAction func userPressedSave(_ sender: UIButton) {
        // TODO: Implement this to add the current weather to the users history and update the table view.
    }
}
