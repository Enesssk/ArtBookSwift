//
//  ViewController.swift
//  ArtBookSwift
//
//  Created by Enes Kala on 28.02.2024.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    var nameArray = [String] ()
    var idArray = [UUID] ()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        getData()
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name(rawValue: "newData"), object: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = nameArray[indexPath.row]
        return cell
    }
    
    @objc func getData(){
        
        nameArray.removeAll(keepingCapacity: false)
        idArray.removeAll(keepingCapacity: false)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchReguest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
        fetchReguest.returnsObjectsAsFaults = false
        
        do{
           let results = try context.fetch(fetchReguest)
            
            for result in results as! [NSManagedObject] {
                
                if let name = result.value(forKey: "name") as? String {
                    nameArray.append(name)
                }
                
                if let id = result.value(forKey: "id") as? UUID{
                    idArray.append(id)
                }
                
                self.tableView.reloadData()
                
            }
            
        }catch{
            print ("Error viewContoller")
        }
        
    }
    
    
    
    @objc func addButtonClicked(){
        
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
        
    }
}

