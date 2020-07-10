//
//  ViewController.swift
//  Swifterviewing
//
//  Created by Tyler Thompson on 7/9/20.
//  Copyright © 2020 World Wide Technology Application Services. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var albums:[Album] = []
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "6c570076-9d57-40f1-94d1-d6cd67ed23c6", for: indexPath)
        cell.textLabel?.text = <#Album Title#>
        cell.imageView?.image = <#Album Image#>
        return cell
    }
}

extension ViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
}
