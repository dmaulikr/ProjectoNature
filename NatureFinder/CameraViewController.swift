//
//  CameraViewController.swift
//  NatureFinder
//
//  Created by Donato Alfonso Tovar De la Herran on 3/26/17.
//  Copyright © 2017 Donato Alfonso Tovar De la Herran. All rights reserved.
//
//
import UIKit
import MobileCoreServices
import AVFoundation

class CameraViewController: UIViewController {
    
    @IBOutlet weak var imagenTomada: UIImageView!
    @IBOutlet weak var labelAnimal: UILabel!
    
    var imagen: UIImage!
    var plAnimal: String!
    var plDieta: String!
    var plHabitat: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagenTomada.image = imagen
        labelAnimal.text = "Are These Animals The Same?"
//        if (plAnimal == ""){
//            labelAnimal.text = "No Animal Found, Try Taking Another Picture"
//        }else{
//            labelAnimal.text = "Are These Animals The Same?"
//        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "datosAnimales" {
            let vistaInfo = segue.destination as! DatosAnimalesViewController
            vistaInfo.imagen = imagenTomada.image! as UIImage
            vistaInfo.pliAnimal = plAnimal
            vistaInfo.pliDieta = plDieta
            vistaInfo.pliHabitat = plHabitat
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
        //<==================== OJO QUE TE AUTOCOMPLETE PARA QUE SELECCIONES PORTRAIT
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
}
