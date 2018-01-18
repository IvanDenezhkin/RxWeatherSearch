//
//  City.swift
//  ArchitecturesWeather
//
//  Created by Ivan Denezhkin on 16.01.2018.
//  Copyright © 2018 Ivan Denezhkin. All rights reserved.
//

import Foundation

struct WeatherResponce: Codable {
    let cod: String
    let count: Int
    let list: [City]
}


struct City: Codable {
    let name: String
    private let sys: [String: String]
    private let main: [String: Double]
    
    var countryName: String? {
        return self.sys["country"]
    }
    
    var temperature: Double? {
        return self.main["temp"]
    }
    
    var maxTemp: Double? {
        return self.main["temp_max"]
    }
    
    var minTemp: Double? {
        return self.main["temp_min"]
    }
    
    var humidity: Double? {
        return self.main["humidity"]
    }
}
