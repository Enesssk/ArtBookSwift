//
//  DetailsViewController.swift
//  ArtBookSwift
//
//  Created by Enes Kala on 28.02.2024.
//

import UIKit

class DetailsViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var yearText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var artistText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()


        var gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        
        view.addGestureRecognizer(gestureRecognizer)
        
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    

    @IBAction func saveButtonClicked(_ sender: Any) {
    }
}
