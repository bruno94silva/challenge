//
//  HomeViewController.swift
//  Challenge
//
//  Created by Bruno dos Santos Silva on 05/08/21.
//

import UIKit

class HomeViewController: UIViewController {

    var mobileSession: MobileSession?
    
    @IBOutlet weak var lblUser: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if mobileSession != nil && mobileSession!.user != nil && !mobileSession!.user!.name!.isEmpty {
            lblUser.text = mobileSession!.user!.name
        }
    }
}
