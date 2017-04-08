//
//  AIRealObject.swift
//  NatureFinder
//
//  Created by Donato Alfonso Tovar De la Herran on 4/1/17.
//  Copyright © 2017 Donato Alfonso Tovar De la Herran. All rights reserved.
//

import Foundation
import RealmSwift
import Realm
import Realm.Private

class AnimalRealm : Object {
    
    dynamic var imagen: NSData? = nil
    dynamic var nombre: String = ""
    dynamic var dieta: String = ""
    dynamic var habitat: String = ""

    func
        getNombre() -> String {
        return nombre
    }
}
