//
//  CartViewController.swift
//  Ordinario
//
//  Created by Rafael Raygosa Mena on 01/06/22.
//

import UIKit

class CartViewController: UIViewController {
    
    var userLoged:String = "1";
    @IBOutlet weak var cartTable: UITableView!
    var cartitems = [cart]()

    override func viewDidLoad() {
        super.viewDidLoad()
        parseData()
        cartTable.delegate = self
        cartTable.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func clickRegresar(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clickOrden(_ sender: Any) {
        self.cartTable.reloadData()
        if cartitems.count == 0
        {
            let uialert = UIAlertController(title: "", message: "No hay objetos agregados al carrito", preferredStyle: UIAlertController.Style.alert)
                  uialert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
               self.present(uialert, animated: true, completion: nil)
            print("No data")
        }else{
            insertData()
            deletedata()
            
            
            self.dismiss(animated: true, completion: nil)
            
            
            
            
            
        }
        
        
        
     }
    
    
    func parseData(){
        
            
            let url =  "http://143.198.60.206:8000/cart/items/" + userLoged
            print(url)
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = "GET"
            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration, delegate: nil,delegateQueue: OperationQueue.main)
            let task = session.dataTask(with: request) { [self] (data, response, error) in
                if(error != nil){
                    print("Error")
                }else {
                    do{
                    
                        let fetchedData = try JSONSerialization.jsonObject(with: data!, options: . mutableLeaves) as! NSObject
                        let itemscarttemp = fetchedData.value(forKey: "data")  as! NSArray
                        //print(categoriastemp)
                        for element in itemscarttemp{
                            
                            
                            let item = element as! [String:Any]
                            let nombre = item["videogame_name"]
                            let id = item["id"]
                            let imagen = item["videogame_image"]
                            let user = item["user_id"]
                            let quantity = item["quantity"]
                            let game = item["videogame_id"]
                            let precio = item["videogame_price"]
                            
                            
                            
                            self.cartitems.append(cart(id: id as! Int,user: user as! Int, game: game as! Int, Quantity: quantity as! Int, name: nombre as! String, image: imagen as! String, price: precio as! Int))
                        }
                        self.cartTable.reloadData()
                    }
                    catch{
                        
                    }
                }
            }
            task.resume()
        }
    
    
    
    
    
    
    
    func deletedata(){
        let url =  "http://143.198.60.206:8000/cart/delete/all"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "DELETE"
        let body: [String: AnyHashable] = [
            "cart_user_id": "\(userLoged)",
           
            
        ]
        
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: nil,delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { [self] (data, response, error) in
            if(error != nil){
                print("Error")
            }else {
                
            }
        }
        task.resume()
        }

    func reloadTheTable(){
        let url =  "http://143.198.60.206:8000/cart/items/" + userLoged
        print(url)
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: nil,delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { [self] (data, response, error) in
            if(error != nil){
                print("Error")
            }else {
                do{
                
                    let fetchedData = try JSONSerialization.jsonObject(with: data!, options: . mutableLeaves) as! NSObject
                    let itemscarttemp = fetchedData.value(forKey: "data")  as! NSArray
                    //print(categoriastemp)
                    for element in itemscarttemp{
                        
                        
                        let item = element as! [String:Any]
                        let nombre = item["videogame_name"]
                        let id = item["id"]
                        let imagen = item["videogame_image"]
                        let user = item["user_id"]
                        let quantity = item["quantity"]
                        let game = item["videogame_id"]
                        let precio = item["videogame_price"]
                        
                        
                        
                        self.cartitems.append(cart(id: id as! Int,user: user as! Int, game: game as! Int, Quantity: quantity as! Int, name: nombre as! String, image: imagen as! String, price: precio as! Int))
                    }
                    self.cartTable.reloadData()
                }
                catch{
                    
                }
            }
        }
        task.resume()
    }
    
    
    func insertData(){
        
        let url =  "http://143.198.60.206:8000/order/add"
        print(url)
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        var total = 0
        var itemList = ""
        
        for cartitem in cartitems {
            
            if total == 0
            {
                itemList = itemList + cartitem.name
            }
            else
            {
                itemList = itemList + ", " + cartitem.name
            }
            let T = cartitem.quantity * cartitem.price
            total = total + T
            
        }
        
        let body: [String: AnyHashable] = [
            "order_user_id": "\(userLoged)",
            "order_total": "\(String(total))",
            "order_items": "\(itemList)",
            "order_status": "enviado",
           
            
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

                    let status = fetchedData.value(forKey: "message") as! String
                    print (status)
                    let uialert = UIAlertController(title: "", message: "pedido creado con exito", preferredStyle: UIAlertController.Style.alert)
                          uialert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
                       self.present(uialert, animated: true, completion: nil)
                    print("pedido creado")
                }
                catch{
                    print("Error")
                }
                
            }
        }
        task.resume()
        }
         

    @IBAction func clickCellBorrar(_ sender: Any) {
        cartitems.removeAll()
        reloadTheTable()
        
    
    
    
    }
    
    

}


extension CartViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let myVC = storyboard?.instantiateViewController(withIdentifier: "productosViewController") as! productosViewController
        //myVC.stringPassed = String(categorias[indexPath.row].id)
        //navigationController?.pushViewController(myVC, animated: true)
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartitems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cartTable.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as! CartTableViewCell
        cell.nameLbl.text = cartitems[indexPath.row].name
        cell.cantLbl.text = String(cartitems[indexPath.row].quantity)
        cell.precioLbl.text = String(cartitems[indexPath.row].price)
        cell.idcar = cartitems[indexPath.row].id
        if let url = URL(string: cartitems[indexPath.row].image ){
            do{
                let data = try Data(contentsOf: url)
                cell.cartImage.image = UIImage(data: data)
            }
            catch{
                print("Error imagen")
            }
        }
        return cell
    }
}
