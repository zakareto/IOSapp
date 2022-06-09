//
//  OrdersViewController.swift
//  Ordinario
//
//  Created by Rafael Raygosa Mena on 08/06/22.
//

import UIKit

class OrdersViewController: UIViewController {

    var userLoged:String = "1";
    @IBOutlet weak var OrdersTable: UITableView!
    var orders = [order]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseData()
        OrdersTable.delegate = self
        OrdersTable.dataSource = self
        // Do any additional setup after loading the view.
    }
    

    @IBAction func clickRegresar(_ sender: Any) {
    
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

    func parseData(){
            let url =  "http://143.198.60.206:8000/order/get/" + userLoged
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
                        let orderstemp = fetchedData.value(forKey: "data")  as! NSArray
                        //print(categoriastemp)
                        for element in orderstemp{
                            
                            
                            let item = element as! [String:Any]
                            let id = item["id"]
                            let user = item["user_id"]
                            let total = item["total"]
                            let items = item["items"]
                            let status = item["status"]
                            
                            
                            
                            
                            self.orders.append(order(id: id as! Int,user: user as! Int, products: items as! String, total: total as! Int, status: status as! String))
                        }
                        self.OrdersTable.reloadData()
                    }
                    catch{
                        
                    }
                }
            }
            task.resume()
        }

}


extension OrdersViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let myVC = storyboard?.instantiateViewController(withIdentifier: "productosViewController") as! productosViewController
        //myVC.stringPassed = String(categorias[indexPath.row].id)
        //navigationController?.pushViewController(myVC, animated: true)
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = OrdersTable.dequeueReusableCell(withIdentifier: "OrdersTableViewCell", for: indexPath) as! OrdersTableViewCell
        cell.StatusLbl.text = orders[indexPath.row].status
        cell.productsLbl.text = orders[indexPath.row].products
        cell.totalLbl.text = "$" + String(orders[indexPath.row].total)
        
        
        return cell
    }
}
