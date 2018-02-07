//
//  ViewController.swift
//  LoginAppTest
//
//  Created by Sachin on 2/5/18.
//  Copyright © 2018 SK. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController {

    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var fbLoginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if(FBSDKAccessToken.current() != nil){
            self.performSegue(withIdentifier: "friendListIdentifier",
                              sender: self)
        }
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.activityIndicator.stopAnimating()
        self.fbLoginBtn.isHidden = false;
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnFBLoginPressed(_ sender: AnyObject) {
        
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email","user_friends"], from: self) { (result, error) in
            if (error == nil){
                self.activityIndicator.startAnimating()
                
                self.fbLoginBtn.isHidden = true;
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if fbloginresult.grantedPermissions != nil {
                    if(fbloginresult.grantedPermissions.contains("email"))
                    {
                    // after sucessfully login, page will redirect to friendList
                    self.performSegue(withIdentifier: "friendListIdentifier",
                                     sender: self)
                    }
                }
            }
            else{
                self.activityIndicator.stopAnimating()
                self.fbLoginBtn.isHidden = false;
            }
        }
    }
}

