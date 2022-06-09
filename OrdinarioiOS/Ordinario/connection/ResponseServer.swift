//
//  ResponseServer.swift
//  Ordinario
//
//  Created by Rafael Raygosa Mena on 29/05/22.
//
import Foundation


struct ResponseServer:Decodable {
    let Status:String
    let Mensaje:String
    let Datos:[Alumno]
}
struct Alumno:Decodable {
    let Nombre:String
    let Cal1:String
    let Cal2:String
    let Cal3:String
    let Promedio:String
}

