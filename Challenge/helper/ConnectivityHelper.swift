//
//  ConnectivityHelper.swift
//  Challenge
//
//  Created by Bruno dos Santos Silva on 06/08/21.
//

import Foundation
import Alamofire

class ConnectivityHelper {

    class func isConnectedToInternet() -> Bool {        
        return NetworkReachabilityManager()!.isReachable
    }
}
