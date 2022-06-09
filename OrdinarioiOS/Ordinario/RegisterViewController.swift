//
//  RegisterViewController.swift
//  Ordinario
//
//  Created by Rafael Raygosa Mena on 22/05/22.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var PasswordText: UITextField!
    @IBOutlet weak var UserText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func parseData(){
        
            let url =  "http://143.198.60.206:8000/user/register"
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = "POST"
            let body: [String: AnyHashable] = [
                "user_username": "\(UserText.text ?? "")",
                "user_password": "\(PasswordText.text ?? "")",
                "user_email": "\(emailText.text ?? "")"
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration, delegate: nil,delegateQueue: OperationQueue.main)
            let task = session.dataTask(with: request) { [self] (data, response, error) in
                if(error != nil){
                    print("Error")
                }else {
                    do{
                    
                        let fetchedData = try JSONSerialization.jsonObject(with: data!, options: . mutableLeaves) as! NSObject
                        
                        
                        let uialert = UIAlertController(title: "", message: (fetchedData.value(forKey: "message") as! String), preferredStyle: UIAlertController.Style.alert)
                              uialert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
                           self.present(uialert, animated: true, completion: nil)
                        
                        
                        
                        
                        
                    }
                    catch{
                        print("Error")
                    }
                }
            }
            task.resume()
            
        }
    

    @IBAction func registroClick(_ sender: Any) {
        
        if UserText.text=="" || PasswordText.text=="" || emailText.text=="" {
            let uialert = UIAlertController(title: "", message: "Llene correctamente todos los campos", preferredStyle: UIAlertController.Style.alert)
                  uialert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
               self.present(uialert, animated: true, completion: nil)
        }else{
        parseData()
        }
    }
    
    @IBAction func RegresarClick(_ sender: Any) {
        //let vc = storyboard?.instantiateViewController(withIdentifier: "login_VC") as! ViewController
        //vc.modalPresentationStyle = .fullScreen
        //present(vc, animated: true)
        self.dismiss(animated: true, completion: nil)
            
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
