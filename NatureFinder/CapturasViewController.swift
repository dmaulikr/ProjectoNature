//
//  CapturasViewController.swift
//  NatureFinder
//
//  Created by Donato Alfonso Tovar De la Herran on 3/31/17.
//  Copyright © 2017 Donato Alfonso Tovar De la Herran. All rights reserved.
//
//
import UIKit

class CapturasViewController: UIViewController {
    
    var animal: AnimalRealm!
    
    @IBOutlet weak var imagenAni: UIImageView!
    @IBOutlet weak var lbNombre: UILabel!
    @IBOutlet weak var lbDieta: UILabel!
    @IBOutlet weak var lbHabitat: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagenAni.image = UIImage(data:(animal.imagen)! as Data,scale:1.0)
        lbNombre.text = animal.getNombre()
        lbDieta.text = animal.dieta
        lbHabitat.text = animal.habitat
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
        //<==================== OJO QUE TE AUTOCOMPLETE PARA QUE SELECCIONES PORTRAIT
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
}
