//
//  ViewController.swift
//  Twitter
//
//  Created by Jonah Tjandra on 3/5/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBAction func onLoginButton(_ sender: Any) {
        let loginPath = "https://api.twitter.com/oauth/request_token"
        TwitterAPICaller.client?.login(url: loginPath, success: {
            UserDefaults.standard.set(true, forKey: "userLoggedIn")
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }, failure: { Error in
            print(Error)
        })
    }
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.masksToBounds = true
        loginButton.layer.cornerRadius = 7
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "userLoggedIn") {
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }
    }


}
