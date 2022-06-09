//
//  Cart.swift
//  Ordinario
//
//  Created by Rafael Raygosa Mena on 07/06/22.
//

import Foundation

class cart {
    var id: Int
    var user: Int
    var game: Int
    var quantity: Int
    var name: String
    var image: String
    var price: Int

    
    init(id:Int, user: Int, game:Int,Quantity:Int, name: String,image: String,  price: Int){
        self.id = id
        self.user = user
        self.game = game
        self.quantity = Quantity
        self.name = name
        self.image = image
        self.price = price
    }
}

