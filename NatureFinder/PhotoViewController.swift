//
//  PhotoViewController.swift
//  NatureFinder
//
//  Created by Donato Alfonso Tovar De la Herran on 3/26/17.
//  Copyright © 2017 Donato Alfonso Tovar De la Herran. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    var takePhoto: UIImage?
    
    @IBOutlet weak var imagen: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let availableImage = takePhoto{
            imagen.image = availableImage
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func regresar(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
