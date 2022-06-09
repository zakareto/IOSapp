//
//  ConnectionWS.swift
//  Ordinario
//
//  Created by Rafael Raygosa Mena on 29/05/22.
//

import Foundation
import Alamofire

final class ConnectionWS{
    
 static let cmd = ConnectionWS()
 private let urlBase = "http://proyectofinalct.000webhostapp.com/"
    private let code = 200...299
    
    func getUsers(user: String, pass: String, success: @escaping(_ user: [Alumno]) -> (),failure: @escaping(_ error: Error?) -> ()){
        let parameters = ["lista":"{\"user\":\"\(user)\",\"password\":\"\(pass)\"}"]
        AF.request(urlBase,method: .get,parameters: parameters).validate(statusCode: code).responseDecodable(of: ResponseServer.self) {
            response in
            if let respuesta = response.value?.Datos {
                print(respuesta[0].Nombre)
                success(respuesta)
            }else {
                failure(response.error)
            }
        }
        
    }
    
}
