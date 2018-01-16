//
//  City.swift
//  ArchitecturesWeather
//
//  Created by Ivan Denezhkin on 16.01.2018.
//  Copyright © 2018 Ivan Denezhkin. All rights reserved.
//

import Foundation

class City {
    let name: String
    let country: String
    let temperature: Int
    
    init(name: String, country: String, temperature: Int) {
        self.name = name
        self.country = country
        self.temperature = temperature
    }
}
