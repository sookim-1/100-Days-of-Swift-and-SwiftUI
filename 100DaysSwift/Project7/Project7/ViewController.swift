//
//  ViewController.swift
//  Project7
//
//  Created by sookim on 2021/07/12.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    var filterPetition = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString: String
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(creditAlert))

        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }

        showError()
    }
    
    @objc func creditAlert() {
        let ac = UIAlertController(title: "Credit", message: "Whitehouse의 We The People API를 이용했습니다.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "확인", style: .default))
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "제출", style: .default, handler: { (action) in
            guard let filter = ac.textFields?[0].text else { return }
            let count = self.petitions.count
            
            for i in 0..<count {
                if self.petitions[i].title.contains(filter) {
                    self.filterPetition.insert(self.petitions[i], at: 0)
                }
            }
            self.petitions = self.filterPetition
            self.tableView.reloadData()
        }))
        
        present(ac, animated: true)
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

