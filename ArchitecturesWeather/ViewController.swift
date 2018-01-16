//
//  ViewController.swift
//  ArchitecturesWeather
//
//  Created by Ivan Denezhkin on 15.01.2018.
//  Copyright © 2018 Ivan Denezhkin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    let network = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let searchResults = searchBar.rx.text.orEmpty
            .throttle(0.5, scheduler: MainScheduler.instance)
            .skip(3)
            .distinctUntilChanged()
            .flatMapLatest { query -> Observable<[City]> in
                return self.network.getWeaterForCityName(name: query)
            }
            .observeOn(MainScheduler.instance)
        
        searchResults
            .bind(to: tableView.rx.items(cellIdentifier: "Cell")) {
                (index, city: City, cell) in
                cell.textLabel?.text = "\(city.name), \(city.country)"
                cell.detailTextLabel?.text = "temp: \(city.temperature)"
            }
            .disposed(by: disposeBag)
    }
}

