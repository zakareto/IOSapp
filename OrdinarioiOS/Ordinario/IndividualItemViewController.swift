//
//  IndividualItemViewController.swift
//  Ordinario
//
//  Created by Rafael Raygosa Mena on 01/06/22.
//

import UIKit

class IndividualItemViewController: UIViewController {
    
    @IBOutlet weak var itemImage: UIImageView!
    var itemId:Int = 1
    var userAct:String = ""
    var nameGame: String = ""
    var priceGame: String = ""
    var imageURL: String = ""

    @IBOutlet weak var ItemCant: UITextField!
    @IBOutlet weak var itemStepper: UIStepper!
    override func viewDidLoad() {
        super.viewDidLoad()
        parseData()

        // Do any additional setup after loading the view.
    }
    
    
    
    
    func parseData(){
        
            let url =  "http://143.198.60.206:8000/videogame/get/" + String(itemId)
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = "GET"
            
                
            
            //request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration, delegate: nil,delegateQueue: OperationQueue.main)
            let task = session.dataTask(with: request) { [self] (data, response, error) in
                if(error != nil){
                    print("Error")
                }else {
                    do{
                    
                        let fetchedData = try JSONSerialization.jsonObject(with: data!, options: . mutableLeaves) as! NSObject
                        let item = fetchedData.value(forKey: "data") as! [String:Any]
                        //print (actUser["username"] as! String)
                        
                        nameGame = item["name"] as! String
                        priceGame = String(item["price"] as! Int)
                        imageURL = item["image"] as! String
                        if let url = URL(string: item["image"] as! String ){
                            do{
                                let img = try Data(contentsOf: url)
                                itemImage.image = UIImage(data: img)
                            }
                            catch{
                                print("Error imagen")
                            }
                        }
                        
                        
                        
                        
                    }
                    catch{
                        print("Error")
                    }
                }
            }
            task.resume()
            
        }
    
    
    func cartData(){
        
            let url =  "http://143.198.60.206:8000/cart/insert"
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = "POST"
            let body: [String: AnyHashable] = [
                "cart_user_id": "\(userAct)",
                "cart_videogame_id": "\(String(itemId))",
                "cart_quantity": "\(ItemCant.text ?? "")",
                "cart_videogame_name": "\(nameGame)",
                "cart_videogame_image": "\(imageURL)",
                "cart_videogame_price": "\(priceGame)"
                
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
    
                        let status = fetchedData.value(forKey: "success") as! String
                        print (status)
                    }
                    catch{
                        print("Error")
                    }
                }
            }
            task.resume()
            
        }
    
    
    
    
    @IBAction func regresarClick(_ sender: Any) {
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func AddToCart(_ sender: Any) {
        
        cartData()
    }
    
    
    
    
    
    

    @IBAction func StepperClick(_ sender: Any) {
        ItemCant.text = String(Int(itemStepper.value))
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
