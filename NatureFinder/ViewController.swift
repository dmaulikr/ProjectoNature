//
//  ViewController.swift
//  NatureFinder
//
//  Created by Donato Alfonso Tovar De la Herran on 2/28/17.
//  Copyright © 2017 Donato Alfonso Tovar De la Herran. All rights reserved.
//
//
import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
   
    var imagen: UIImage!
    
    @IBOutlet weak var camara: UIButton!
    @IBOutlet weak var imagenEscondida: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagenEscondida.isHidden = true
        //UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tomarFoto(_ sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let imagenAux = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imagenEscondida.image = imagenAux
            imagenEscondida.contentMode = .scaleAspectFit
            self.dismiss(animated: true, completion: nil)
            performSegue(withIdentifier: "pasaFoto", sender: nil)
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if(identifier == "pasaFoto"){
            return false
        }else{
            return true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "pasaFoto"){
            let vistaInfo = segue.destination as! CameraViewController
            vistaInfo.imagen = imagenEscondida.image! as UIImage
        }
    }
    
    //Se sale de las demas Interfacez
    @IBAction func unwindTrofeos(unwindSegue: UIStoryboardSegue) {
        // Vacío intencionalmente al No regresar Info
    }
    @IBAction func unwindConfig(unwindSegue: UIStoryboardSegue) {
        //Vacio Intencionalmente al No regresar Info
    }
    @IBAction func unwindX(unwindSegue: UIStoryboardSegue) {
        //Vacio Intencionalmente al No regresar Info
    }
    @IBAction func unwindCamera(unwindSegue: UIStoryboardSegue) {
        //Vacio Intencionalmente al No regresar Info
    }
    @IBAction func unwindDatosA(unwindSegue: UIStoryboardSegue) {
        //Vacio Intencionalmente al No regresar Info
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
        //<==================== OJO QUE TE AUTOCOMPLETE PARA QUE SELECCIONES PORTRAIT
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
}

