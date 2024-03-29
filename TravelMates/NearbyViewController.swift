//
//  NearbyViewController.swift
//  TravelDiary
//
//  Created by SIM1718 on 21/12/2019.
//  Copyright © 2019 Siddhant Mishra. All rights reserved.
//

import UIKit
import Alamofire

class NearbyViewController: UIViewController {
    var tvShows:NSArray = []

    let tableView:UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        return tb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
    }
    
    fileprivate func setupTableView() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        tableView.register(MCDropCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self as! UITableViewDelegate
        tableView.dataSource = self as! UITableViewDataSource
    }
    
    let data = [
        MCDropData(title: "Pro Animations", url: "maxcodes.io/courses"),
        MCDropData(title: "Core Data", url: "maxcodes.io/courses"),
        MCDropData(title: "StoreKit", url: "maxcodes.io/courses storekit will teach you in app purchases")
    ]
    
    var selectedIndex: IndexPath = IndexPath(row: 0, section: 0)
    
}

struct MCDropData {
    var title: String
    var url: String
}

extension NearbyViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedIndex == indexPath { return 200 }
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvShows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MCDropCell
        cell.data = data[indexPath.row]
        cell.data?.title
        cell.selectionStyle = .none
        cell.animate()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath
        
        tableView.beginUpdates()
        tableView.reloadRows(at: [selectedIndex], with: .none)
        tableView.endUpdates()
    }
    
    //fetch data from db
    func fetchTvShows(){
        
        Alamofire.request("http://localhost:3000/showtrips?depart=tunis").responseJSON{ response in
            
            
            self.tvShows = response.result.value as! NSArray
            
            self.tableView.reloadData()
            
        }
        
        
    }
    //fetch data from db
    
    

}
