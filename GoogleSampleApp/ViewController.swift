//
//  ViewController.swift
//  GoogleSampleApp
//
//  Created by Brian D Keane on 9/11/16.
//  Copyright © 2016 Brian D Keane. All rights reserved.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController, GIDSignInUIDelegate {

    @IBOutlet weak var googleSignInButton: GIDSignInButton!
    @IBOutlet weak var startingIndexTextField: UITextField!
    @IBOutlet weak var numberToFetchTextField: UITextField!
    
    var AuthService:AuthServiceClass! = AuthServiceInstance
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setupGoogleSignIn()
    }
    
    func setupGoogleSignIn()
    {
        GIDSignIn.sharedInstance().uiDelegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getChunkOfEmailsButtonPressed(sender: AnyObject)
    {
        self.AuthService.getChunkOfGoogleEmails(Int(self.numberToFetchTextField.text!), startIndex: Int(self.startingIndexTextField.text!))
        .then
        {
            (emails) -> Void in
            print("ALL DONE -- WITH \(emails.count) emails")
        }
        
    }
    
}

