//
//  DetailsViewController.swift
//  ArtBookSwift
//
//  Created by Enes Kala on 28.02.2024.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var yearText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var artistText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()


        //Recognizers
        var gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        
        view.addGestureRecognizer(gestureRecognizer)
        
        imageView.isUserInteractionEnabled = true
        var imageViewRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageViewRecognizer)
        
    
        
    }
    
    @objc func selectImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
        imageView.image = info[.originalImage] as? UIImage
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    

    @IBAction func saveButtonClicked(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        //coredataya ulaştık kaydedeceğimiz yer context
        
        let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)
        
        newPainting.setValue(nameText.text!, forKey: "name")
        newPainting.setValue(artistText.text, forKey: "artist")
        
        if let year = Int(yearText.text!) {
            newPainting.setValue(year, forKey: "year")
        }
        
        newPainting.setValue(UUID(), forKey: "id")
        
        let data = imageView.image!.jpegData(compressionQuality: 0.5)
        newPainting.setValue(data, forKey: "image")
        
        do{
            try context.save()
            print("Success")
        }catch{
            print("Error!")
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
        self.navigationController?.popViewController(animated: true)
    }
}
