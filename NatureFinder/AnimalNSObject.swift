//
//  AnimalNSObject.swift
//  NatureFinder
//
//  Created by Donato Alfonso Tovar De la Herran on 4/1/17.
//  Copyright © 2017 Donato Alfonso Tovar De la Herran. All rights reserved.
//

import UIKit

class AnimalNSObject: NSObject {
    
    var imagen: UIImage? = nil
    var nombre: String = ""
    var dieta: String = ""
    var habitat: String = ""
    
    init(imagen: UIImage, nombre: String, dieta: String, habitat: String){
        self.imagen = imagen
        self.nombre = nombre
        self.dieta = dieta
        self.habitat = habitat
    }
}
