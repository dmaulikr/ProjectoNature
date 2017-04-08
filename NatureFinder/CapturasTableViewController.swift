//
//  CapturasTableViewController.swift
//  NatureFinder
//
//  Created by Donato Alfonso Tovar De la Herran on 3/31/17.
//  Copyright © 2017 Donato Alfonso Tovar De la Herran. All rights reserved.
//
//
import UIKit
import RealmSwift

class CapturasTableViewController: UITableViewController{

    var nombreAnimal = [String]()
    var dietaAnimal = [String]()
    var habitatAnimal = [String]()
    var allAnimals = [AnimalRealm]()
    var selectedAnimal: AnimalRealm!
    
    let realm:Realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        queryAnimal()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        //Protocolo es con ListaAnimal.count
        return allAnimals.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "mostrar"){
            let vistaInfo = segue.destination as! CapturasViewController
            vistaInfo.animal = selectedAnimal!
        }
    }
    
    func queryAnimal(){
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        
        let realmPath = documentsPath.strings(byAppendingPaths: ["AnimalRealm.Realm"])
        let pathToFile = realmPath[0]
        
        let realm = try! Realm(fileURL: NSURL(fileURLWithPath: pathToFile) as URL)
        
        let pups = realm.objects(AnimalRealm.self)
        print("\(pups[pups.count-1])")
        
        for animal in pups {
            nombreAnimal.append(animal.nombre)
            dietaAnimal.append(animal.dieta)
            habitatAnimal.append(animal.habitat)
            allAnimals.append(animal)
            
            tableView.reloadData()
        }
        
        print("\(allAnimals[0].getNombre())")

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Celda", for: indexPath) as! CapturaTableViewCell
        
        cell.lbAnimal.text = allAnimals[indexPath.row].getNombre()
        cell.imagenAnimal.image = UIImage(data:(allAnimals[indexPath.row].imagen)! as Data,scale:1.0)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedAnimal = allAnimals[indexPath.row]
        self.performSegue(withIdentifier: "mostrar", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            try! realm.write {
                realm.delete(allAnimals[(indexPath.row)])
            }
            allAnimals.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
}
