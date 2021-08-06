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
    
    func login(parameters: [String : String], completion: @escaping (Int) -> Void) {
        
        Alamofire.request("https://us-central1-rh-challenges.cloudfunctions.net/api/users/token", method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { requisition in
            
            if requisition.response != nil {
                let statusCode = requisition.response!.statusCode
                
                if statusCode == 200 {

                    if let jsonData = requisition.data {
                        
                        do {
                            let mobileSession: MobileSession = try JSONDecoder().decode(MobileSession.self, from: jsonData)
                        
                            try self.mobileSessionDAO.save(realmObject: mobileSession)
                            
                            completion(statusCode)
                        } catch {
                            print(error)
                            completion(996)
                        }
                    } else {
                        completion(997)
                    }
                } else {
                    completion(statusCode)
                }
            } else {
                completion(999)
            }
        }
    }
}
