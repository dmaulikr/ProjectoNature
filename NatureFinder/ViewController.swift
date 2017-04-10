//
//  ViewController.swift
//  NatureFinder
//
//  Created by Donato Alfonso Tovar De la Herran on 2/28/17.
//  Copyright © 2017 Donato Alfonso Tovar De la Herran. All rights reserved.
//
//
import UIKit
import SwiftyJSON

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var labelResults: String!
    var imagen: UIImage!
    var pAnimal: String!
    var pDieta: String!
    var pHabitat: String!
    var pUrlImagen: UIImage!
    
    @IBOutlet weak var spiner: UIActivityIndicatorView!
    @IBOutlet weak var imagenInstr: UIImageView!
    @IBOutlet weak var camara: UIButton!
    @IBOutlet weak var imagenEscondida: UIImageView!
    
    let session = URLSession.shared
    
    var arrDiccionaios: NSArray!
    var googleAPIKey = "AIzaSyDfVCm-bVojM0SkBhLjjoIX2Bi1EMNYIhk"
    var googleURL: URL {
        return URL(string: "https://vision.googleapis.com/v1/images:annotate?key=\(googleAPIKey)")!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagenEscondida.isHidden = true
        let filepath = Bundle.main.path(forResource: "Property-List", ofType: "plist")
        let items = NSArray(contentsOfFile: filepath!) as! [[String:AnyObject]]
        spiner.hidesWhenStopped = true
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
            vistaInfo.plAnimal = pAnimal
            vistaInfo.plDieta = pDieta
            vistaInfo.plHabitat = pHabitat
            vistaInfo.plUrlImagen = pUrlImagen
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
    }
    override var shouldAutorotate: Bool {
        return false
    }
}

/// Image processing
extension ViewController {
    
    func analyzeResults(_ dataToParse: Data) {
        
        // Update UI on the main thread
        DispatchQueue.main.async(execute: {
            
            //
            let filepath = Bundle.main.path(forResource: "Property-List", ofType: "plist")
            let items = NSArray(contentsOfFile: filepath!) as! [[String:AnyObject]]
            //
            // Use SwiftyJSON to parse results
            let json = JSON(data: dataToParse)
            let errorObj: JSON = json["error"]
            
            self.spiner.stopAnimating()
            
            // Check for errors
            if (errorObj.dictionaryValue != [:]) {
                self.labelResults = "Error code \(errorObj["code"]): \(errorObj["message"])"
            } else {
                // Parse the response
                print(json)
                let responses: JSON = json["responses"][0]
                
                // Get label annotations
                let labelAnnotations: JSON = responses["labelAnnotations"]
                let numLabels: Int = labelAnnotations.count
                //let animals: Array<String> = ["dog","cat","bear","frog","lion"]
                
                var labels: Array<String> = []
                var foundAnimals: String? = nil
                var foundAnimalD: String? = nil
                var foundAnimalH: String? = nil
                var foundAnimalN: String? = nil
                var foundAnimalU: String? = nil
                self.pAnimal = nil
                self.pDieta = nil
                self.pHabitat = nil
                self.pUrlImagen = nil
                var encontrar = false
                if numLabels > 0 {
                    for index in 0..<numLabels {
                        let label = labelAnnotations[index]["description"].stringValue
                        labels.append(label)
                    }
                    for label in labels {
                        for item in items{
                            if label.range(of:item["animal"]!.lowercased) != nil {
                                foundAnimals = item["animal"] as? String
                                foundAnimalN = item["animal"] as? String
                                foundAnimalD = item["dieta"] as? String
                                foundAnimalH = item["habitat"] as? String
                                foundAnimalU = item["url"] as? String
                                encontrar = true
                                break
                            }
                        }
                        if encontrar == true {
                            break
                        }
                    }
                    if(foundAnimals != nil){
                        
                        let sUrl = foundAnimalU
                        let url = URL(string: sUrl!)
                        let imagenData = NSData(contentsOf: url!)
                        self.pUrlImagen = UIImage(data: imagenData! as Data)
                        
                        self.labelResults = foundAnimals
                        self.pAnimal = foundAnimalN
                        self.pDieta = foundAnimalD
                        self.pHabitat = foundAnimalH
                    }else{
                        self.labelResults = nil
                        self.pAnimal = nil
                        self.pDieta = nil
                        self.pHabitat = nil
                        self.pUrlImagen = nil
                    }
                } else {
                    self.labelResults = nil
                }
            }
            print(self.pAnimal)
            print("Analyzing")
            if(self.pAnimal != nil){
                self.performSegue(withIdentifier: "pasaFoto", sender: nil)
            }else{
                let alerta = UIAlertController(title: "No Animals Found", message: "Please Take Another Picture", preferredStyle: .alert)
                alerta.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alerta, animated: true, completion: nil)
            }
        })
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let imagenAux = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagenEscondida.image = imagenAux
            imagenEscondida.contentMode = .scaleAspectFit
            
            // Base64 encode the image and create the request
            let binaryImageData = base64EncodeImage(imagenAux)
            createRequest(with: binaryImageData)
        }
        dismiss(animated: true, completion: nil)
        spiner.startAnimating()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func resizeImage(_ imageSize: CGSize, image: UIImage) -> Data {
        UIGraphicsBeginImageContext(imageSize)
        image.draw(in: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        let resizedImage = UIImagePNGRepresentation(newImage!)
        UIGraphicsEndImageContext()
        return resizedImage!
    }
}


/// Networking

extension ViewController {
    func base64EncodeImage(_ image: UIImage) -> String {
        var imagedata = UIImagePNGRepresentation(image)
        
        // Resize the image if it exceeds the 2MB API limit
        if (imagedata?.count > 2097152) {
            let oldSize: CGSize = image.size
            let newSize: CGSize = CGSize(width: 800, height: oldSize.height / oldSize.width * 800)
            imagedata = resizeImage(newSize, image: image)
        }
        
        return imagedata!.base64EncodedString(options: .endLineWithCarriageReturn)
    }
    
    func createRequest(with imageBase64: String) {
        // Create our request URL
        
        var request = URLRequest(url: googleURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(Bundle.main.bundleIdentifier ?? "", forHTTPHeaderField: "X-Ios-Bundle-Identifier")
        
        // Build our API request
        let jsonRequest = [
            "requests": [
                "image": [
                    "content": imageBase64
                ],
                "features": [
                    [
                        "type": "LABEL_DETECTION",
                        "maxResults": 10
                    ]
                ]
            ]
        ]
        let jsonObject = JSON(jsonDictionary: jsonRequest)
        
        // Serialize the JSON
        guard let data = try? jsonObject.rawData() else {
            return
        }
        
        request.httpBody = data
        
        // Run the request on a background thread
        DispatchQueue.global().async { self.runRequestOnBackgroundThread(request) }
    }
    
    func runRequestOnBackgroundThread(_ request: URLRequest) {
        // run the request
        let task: URLSessionDataTask = session.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            
            self.analyzeResults(data)
        }
        
        task.resume()
    }
}


// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}


