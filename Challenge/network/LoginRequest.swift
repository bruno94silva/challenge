//
//  LoginRequest.swift
//  Challenge
//
//  Created by Bruno dos Santos Silva on 04/08/21.
//

import Foundation
import Alamofire

class LoginRequest {
    
    let jsonEncoder = JSONEncoder()
    let mobileSessionDAO = MobileSessionDAOImpl()
    
    func login(parameters: [String : String], completion: @escaping (String) -> Void) {
        
        Alamofire.request("https://us-central1-rh-challenges.cloudfunctions.net/api/users/token", method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { requisition in
            
            var retorno: String = "999|"
            
            if requisition.response != nil {
                let statusCode = requisition.response!.statusCode
                
                if statusCode == 200 {

                    if let jsonData = requisition.data {
                        
                        do {
                            let mobileSession: MobileSession = try JSONDecoder().decode(MobileSession.self, from: jsonData)
                        
                            try self.mobileSessionDAO.save(realmObject: mobileSession)
                            
                            retorno = "\(statusCode)|\(mobileSession.token!)"
                            
                            completion(retorno)
                        } catch {
                            print(error)
                            completion(retorno)
                        }
                    } else {
                        completion(retorno)
                    }
                } else {
                    completion(retorno)
                }
            } else {
                completion(retorno)
            }
        }
    }
}
