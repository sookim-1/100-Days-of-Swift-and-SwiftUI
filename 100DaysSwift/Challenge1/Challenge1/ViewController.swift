//
//  ViewController.swift
//  Challenge1
//
//  Created by sookim on 2021/06/30.
//

import UIKit

class ViewController: UITableViewController {

    var flagArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        flagArray = ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "detail") as? DetailViewController {
            vc.selectImage = flagArray[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flagArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        
        cell.textLabel?.text = flagArray[indexPath.row]
        
        return cell
    }
}

