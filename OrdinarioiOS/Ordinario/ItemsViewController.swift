//
//  ItemsViewController.swift
//  Ordinario
//
//  Created by Rafael Raygosa Mena on 23/05/22.
//

import UIKit

class ItemsViewController: UIViewController {

    
    @IBOutlet weak var itemsCollection: UICollectionView!
    var categoriePassed : String = "1"
    var userLoged:String = "1";
    var items = [Item]()
    override func viewDidLoad() {
        super.viewDidLoad()
        parseData()
        itemsCollection.dataSource = self
        itemsCollection.delegate = self
        itemsCollection.collectionViewLayout = UICollectionViewFlowLayout()
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func regresarClick(_ sender: Any) {
    
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func parseData(){
            let url =  "http://143.198.60.206:8000/videogames"
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
                        let itemstemp = fetchedData.value(forKey: "data")  as! NSArray
                        
                        for element in itemstemp{
                            
                            
                            let item = element as! [String:Any]
                            let nombre = item["name"]
                            
                            let id = item["id"]
                            let imagen = item["image"]
                            let genre = item["genre"]
                            let price = item["price"]
                            let categorie = String(item["rating_id"] as! Int)
                            
                            if categorie == categoriePassed{
                                self.items.append(Item(id: id as! Int, nombre: nombre as! String, imagen: imagen as! String, genero: genre as! String, precio: price as! Int))
                            }
                            
                        }
                        self.itemsCollection.reloadData()
                    }
                    catch{
                        
                    }
                }
            }
            task.resume()
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




extension ItemsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "IndividualItem_VC") as! IndividualItemViewController
        vc.itemId = (items[indexPath.row].id)
        vc.userAct = userLoged
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = itemsCollection.dequeueReusableCell(withReuseIdentifier: "itemCollectionViewCell", for: indexPath) as! itemCollectionViewCell
        cell.gameName.text = items[indexPath.row].nombre
        cell.gameGenre.text = items[indexPath.row].genero
        cell.gamePrice.text = "$" + String(items[indexPath.row].precio)
        if let url = URL(string: items[indexPath.row].imagen ){
            do{
                let data = try Data(contentsOf: url)
                cell.itemImage.image = UIImage(data: data)
            }
            catch{
                print("Error imagen")
            }
        }
        return cell
    }
}




extension ItemsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:180, height: 300)
    }
    
}
