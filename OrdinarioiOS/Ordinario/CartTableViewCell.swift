//
//  CartTableViewCell.swift
//  Ordinario
//
//  Created by Rafael Raygosa Mena on 07/06/22.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var precioLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var cartImage: UIImageView!
    @IBOutlet weak var cantLbl: UILabel!
    @IBOutlet weak var clickDelete: UIButton!
    var idcar: Int = 1
    
    override func awakeFromNib() {
        
        
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func clickOnDelete(_ sender: Any) {
    
        print(idcar)
        parseData()
        
        
    
    }
    func parseData(){
        
            let url =  "http://143.198.60.206:8000/cart/delete"
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = "DELETE"
            let body: [String: AnyHashable] = [
                "cart_id": "\(idcar)",
               
                
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
    
}
