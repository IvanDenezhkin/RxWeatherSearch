//
//  DetailedWeatherViewController.swift
//  ArchitecturesWeather
//
//  Created by Ivan Denezhkin on 17.01.2018.
//  Copyright © 2018 Ivan Denezhkin. All rights reserved.
//

import UIKit

class DetailedWeatherViewController: UIViewController {
    var city: City? {
        didSet {
            decorateWithCity(city: city)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func decorateWithCity(city: City?) {
        guard let unwrappedCity = city else { return }
        // TODO: Make some cool stuff here
        print(unwrappedCity)
    }
}
