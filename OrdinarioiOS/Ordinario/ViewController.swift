//
//  ViewController.swift
//  Ordinario
//
//  Created by Rafael Raygosa Mena on 22/05/22.
//

import UIKit

class ViewController: UIViewController {

    var usertemp : String = "";
    @IBOutlet weak var passwordtext: UITextField!
    @IBOutlet weak var usertext: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func clickButtonRegister(_ sender: Any) {
    
        if usertext.text=="" || passwordtext.text=="" {
            let uialert = UIAlertController(title: "", message: "Llene correctamente todos los campos", preferredStyle: UIAlertController.Style.alert)
                  uialert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
               self.present(uialert, animated: true, completion: nil)
        }else{
        parseData()
        }
        
        
        
        
    }
    
    
    
    func parseData(){
        
            let url =  "http://143.198.60.206:8000/user/get"
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = "POST"
            let body: [String: AnyHashable] = [
                "user_username": "\(usertext.text ?? "")",
                "user_password": "\(passwordtext.text ?? "")"
            ]
        print(body)
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration, delegate: nil,delegateQueue: OperationQueue.main)
            let task = session.dataTask(with: request) { [self] (data, response, error) in
                if(error != nil){
                    print("Error")
                }else {
                    do{
                    
                        let fetchedData = try JSONSerialization.jsonObject(with: data!, options: . mutableLeaves) as! NSObject
                        usertemp = fetchedData.value(forKey: "status") as! String
                       
                        //print (actUser["username"] as! String)
                        
                        if usertemp == "conectado" {
                            let actUser = fetchedData.value(forKey: "data") as! [String:Any]
                            let vc = storyboard?.instantiateViewController(withIdentifier: "categories_VC") as! CategoriesViewController
                            vc.userLoged = String(actUser["id"] as! Int)
                            vc.modalPresentationStyle = .fullScreen
                            present(vc, animated: true)
                            
                        }else {
                            print(usertemp)
                            let uialert = UIAlertController(title: "", message: "Credenciales incorrectas, verifique su usuario y contraseña", preferredStyle: UIAlertController.Style.alert)
                                  uialert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
                               self.present(uialert, animated: true, completion: nil)
                            print("credenciales incorrectas")
                            
                        }
                        
                        
                        
                    }
                    catch{
                        print("Error")
                    }
                }
            }
            task.resume()
            
        }
    @IBAction func clickButtonAcceder(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "register_VC") as! RegisterViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}

