//
//  NetworkManager.swift
//  RXPlayground
//
//  Created by Ivan Denezhkin on 10.01.2018.
//  Copyright © 2018 Ivan Denezhkin. All rights reserved.
//

import RxSwift
import Alamofire
import SwiftyJSON

class NetworkManager {
    static let apiURL = "http://api.openweathermap.org/data/2.5/find"
    static let apiKey = "28f1b4ac7abe6965f39838bda855939e"
    
    func getWeaterForCityName(name: String) -> Observable<[City]> {
        return Observable.create { observer in
            let params = ["APPID"   : NetworkManager.apiKey,
                          "q"       : name,
                          "units"   : "metric",
                          "lang"    : "ru",
                          "type"    : "like"]
            let request = Alamofire.request(NetworkManager.apiURL, method: .get, parameters: params).responseJSON(completionHandler: { responseJSON in
                if let error = responseJSON.error {
                    observer.onError(error)
                }
                if let data = responseJSON.data {
                    let cityArray = JSON(data)["list"].arrayValue
                    var cityModelsArray: [City] = []
                    for city in cityArray {
                        let city = city.dictionaryValue
                        let name = city["name"]!.stringValue
                        let country = city["sys"]!["country"].stringValue
                        let temperature = city["main"]!["temp"].intValue
                        cityModelsArray.append(City(name: name, country: country, temperature: temperature))
                    }
                    observer.onNext(cityModelsArray)
                    observer.onCompleted()
                }
            })
            return Disposables.create(with: {
                request.cancel()
            })
        }
    }
}
