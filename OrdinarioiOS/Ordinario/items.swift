//
//  items.swift
//  Ordinario
//
//  Created by Rafael Raygosa Mena on 31/05/22.
//

import Foundation

class Item {
    var id: Int
    var nombre: String
    var imagen: String
    var genero: String
    var precio: Int

    
    init(id:Int, nombre: String, imagen: String, genero: String, precio: Int){
        self.id = id
        self.nombre = nombre
        self.imagen = imagen
        self.genero = genero
        self.precio = precio
    }
}
