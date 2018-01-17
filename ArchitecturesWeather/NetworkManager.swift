//
//  NetworkManager.swift
//  RXPlayground
//
//  Created by Ivan Denezhkin on 10.01.2018.
//  Copyright © 2018 Ivan Denezhkin. All rights reserved.
//

import RxSwift
import Alamofire

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
                    if let responce = try? JSONDecoder().decode(WeatherResponce.self, from: data) {
                        observer.onNext(responce.list)
                        observer.onCompleted()
                    }
                }
            })
            return Disposables.create(with: {
                request.cancel()
            })
        }
    }
}
