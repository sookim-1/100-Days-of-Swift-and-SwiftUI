//
//  DetailViewController.swift
//  Challenge1
//
//  Created by sookim on 2021/07/01.
//

import UIKit

class DetailViewController: UIViewController {
    var selectImage: String?
    @IBOutlet var detailImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailImage.image = UIImage(named: selectImage!)
    }
}
