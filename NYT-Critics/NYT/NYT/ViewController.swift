//
//  ViewController.swift
//  NYT
//
//  Created by Amber Spadafora on 11/2/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var criticsTable: UITableView!
    
    var critics = [Critic]()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        self.criticsTable.delegate = self
        self.criticsTable.dataSource = self
        loadData()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return critics.count // your number of cell here
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "criticCell", for: indexPath)
        cell.textLabel?.text = critics[indexPath.row].name
        cell.detailTextLabel?.text = critics[indexPath.row].image
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        
//    }
    
    
    
    
    func loadData() {
        APIRequestManager.manager.getData { (data) in
            
            guard let unwrappedData = data else {
                print("errorOccurred")
                return
            }
            
            self.critics = Critic.createCriticList(from: unwrappedData)!
            
            DispatchQueue.main.async {
                self.criticsTable.reloadData()
            }
        }
    }

}

