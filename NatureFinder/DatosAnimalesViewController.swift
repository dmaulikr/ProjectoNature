//
//  DatosAnimalesViewController.swift
//  NatureFinder
//
//  Created by Donato Alfonso Tovar De la Herran on 3/31/17.
//  Copyright © 2017 Donato Alfonso Tovar De la Herran. All rights reserved.
//
//

import UIKit
import Realm
import RealmSwift

class DatosAnimalesViewController: UIViewController {
    
    var imagen: UIImage!
    var pliAnimal: String!
    var pliDieta: String!
    var pliHabitat: String!

    
    @IBOutlet weak var imagenFinal: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbDiet: UILabel!
    @IBOutlet weak var lbHabitat: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagenFinal.image = imagen
        lbName.text = pliAnimal
        lbDiet.text = pliDieta
        lbHabitat.text = pliHabitat
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var botonGuardar: UIButton!
    @IBAction func regresarGuardar(_ sender: UIButton) {
        addAnimal()
    }
    
    func addAnimal(){
        let animal = AnimalRealm()
        
        let dataAnimal = NSData(data: UIImageJPEGRepresentation(imagenFinal.image!,0.9)!)
        animal.imagen = dataAnimal
        animal.nombre = lbName.text!
        animal.dieta = lbDiet.text!
        animal.habitat = lbHabitat.text!
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        
        let realmPath = documentsPath.strings(byAppendingPaths: ["AnimalRealm.Realm"])
        let pathToFile = realmPath[0]
        
        let realm = try! Realm(fileURL: NSURL(fileURLWithPath: pathToFile) as URL)
        
        try! realm.write{
            realm.add(animal)
            print("Se agrego el Animal")
        }
        
        let pups = realm.objects(AnimalRealm.self)
        print("\(pups[pups.count-1])")
    }
    
    func queryAnimal(){
        let realm = try! Realm()
        
        let allAnimal = realm.objects(AnimalRealm.self)
        
        let byName = allAnimal.sorted(byKeyPath: "nombre", ascending: false)
        
        for animal in byName {
            print("\(animal.nombre)")
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
