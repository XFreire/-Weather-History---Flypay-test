//
//  WeatherHistoryTableViewDataSource.swift
//  CandidateAssessment
//
//  Created by Daniel Iglesias on 19/06/2017.
//  Copyright © 2017 Flypay. All rights reserved.
//

import UIKit

struct HistoryTableViewCellContent {
    let cityName: String
    let formattedDate: String
    let image: UIImage? // This should come from the API
}

/// You should re-implement this to use your framework to get the correct data
class WeatherHistoryTableViewDataSource: NSObject, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCellReuseIdentifier") as! WeatherHistoryTableViewCell
        
        let cellContent = dummyData(for: indexPath.row)
        cell.cityLabel.text = cellContent.cityName
        cell.dateLabel.text = cellContent.formattedDate
        cell.iconImageView.image = cellContent.image
        
        return cell
    }
    
    // This is some dummy data to give an example of the result
    func dummyData(for row: Int) -> HistoryTableViewCellContent {
        
        if row == 0 {
            return HistoryTableViewCellContent(cityName: "London", formattedDate: "04/05", image: UIImage(named: "londonWeather"))
        } else if row == 1 {
            return HistoryTableViewCellContent(cityName: "New York", formattedDate: "05/06", image: UIImage(named: "newYorkWeather"))
        } else if row == 2 {
            return HistoryTableViewCellContent(cityName: "Paris", formattedDate: "31/12", image: UIImage(named: "parisWeather"))
        }
        
        fatalError()
    }
}
