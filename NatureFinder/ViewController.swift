//
//  ViewController.swift
//  NatureFinder
//
//  Created by Donato Alfonso Tovar De la Herran on 2/28/17.
//  Copyright © 2017 Donato Alfonso Tovar De la Herran. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{

    @IBAction func OpenCamera(_ sender: UIButton) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func PhotoLibrary(_ sender: UIButton) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindTrofeos(unwindSegue: UIStoryboardSegue) {
        // Vacío intencionalmente al No regresar Info
    }
    
    @IBAction func unwindConfig(unwindSegue: UIStoryboardSegue) {
        //Vacio Intencionalmente al No regresar Info
    }
    @IBAction func unwindX(unwindSegue: UIStoryboardSegue) {
        //Vacio Intencionalmente al No regresar Info
    }
}

