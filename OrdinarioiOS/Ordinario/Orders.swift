//
//  Orders.swift
//  Ordinario
//
//  Created by Rafael Raygosa Mena on 08/06/22.
//

import Foundation



class order {
    var id: Int
    var user: Int
    var products: String
    var total: Int
    var status: String

    
    init(id:Int, user: Int, products: String, total: Int, status:String){
        self.id = id
        self.user = user
        self.products = products
        self.total = total
        self.status = status
       
    }
}

