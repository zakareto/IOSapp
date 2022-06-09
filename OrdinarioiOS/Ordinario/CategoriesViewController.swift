//
//  CategoriesViewController.swift
//  Ordinario
//
//  Created by Rafael Raygosa Mena on 23/05/22.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    var userLoged:String = "1";
    var categorias = [Categorie]()

    @IBOutlet weak var categoriesCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        parseData()
        categoriesCollection.dataSource = self
        categoriesCollection.delegate = self
        categoriesCollection.collectionViewLayout = UICollectionViewFlowLayout()
        categoriesCollection.contentInset = UIEdgeInsets(top: 30, left: 20, bottom: 10, right: 20)
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickSalir(_ sender: Any) {
    
        self.dismiss(animated: true, completion: nil)
    
    }
    @IBAction func clickOrdenes(_ sender: Any) {
    
        let vc = storyboard?.instantiateViewController(withIdentifier: "orders_VC") as! OrdersViewController
        vc.userLoged = userLoged
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    
    }
    
    @IBAction func clickCarrito(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "cart_VC") as! CartViewController
        vc.userLoged = userLoged
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        
    }
    
    func parseData(){
            let url =  "http://143.198.60.206:8000/rating"
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
                        let categoriastemp = fetchedData.value(forKey: "data")  as! NSArray
                        //print(categoriastemp)
                        for element in categoriastemp{
                            
                            
                            let categoria = element as! [String:Any]
                            let nombre = categoria["name"]
                            
                            let id = categoria["id"]
                            let imagen = categoria["image"]
                            self.categorias.append(Categorie(id: id as! Int, nombre: nombre as! String, imagen: imagen as! String))
                        }
                        self.categoriesCollection.reloadData()
                    }
                    catch{
                        
                    }
                }
            }
            task.resume()
        }

}


//extension CategoriesViewController: UICollectionViewDataSource{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return categories.count
//    }
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RoundCollectionViewCell", for: indexPath) as! RoundCollectionViewCell
        //cell.setup(with: categories[indexPath.row])
        
//        return cell
//    }

//}



extension CategoriesViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "items_VC") as! ItemsViewController
        vc.categoriePassed = String(categorias[indexPath.row].id)
        vc.userLoged = userLoged
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categorias.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoriesCollection.dequeueReusableCell(withReuseIdentifier: "RoundCollectionViewCell", for: indexPath) as! RoundCollectionViewCell
        cell.titleLbl.text = categorias[indexPath.row].nombre
        if let url = URL(string: categorias[indexPath.row].imagen ){
            do{
                let data = try Data(contentsOf: url)
                cell.categorieImage.image = UIImage(data: data)
            }
            catch{
                print("Error imagen")
            }
        }
        return cell
    }
}




extension CategoriesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:150, height: 270)
    }
    
}
