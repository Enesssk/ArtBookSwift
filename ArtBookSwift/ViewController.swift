//
//  ViewController.swift
//  ArtBookSwift
//
//  Created by Enes Kala on 28.02.2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
    }
    
    @objc func addButtonClicked(){
        
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
        
    }
}

