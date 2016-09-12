//
//  AuthService.swift
//  GoogleSampleApp
//
//  Created by Brian D Keane on 9/11/16.
//  Copyright © 2016 Brian D Keane. All rights reserved.
//


import Foundation
import CoreData
import UIKit
import Alamofire
import PromiseKit
import GoogleSignIn


// -----------------------------------------------------------------------------
//                       class AuthServiceClass
// -----------------------------------------------------------------------------
/// handles all communication with outside APIs -- initialized as a Singleton
/// with the name `AuthServiceInstance`
///
/// ----------------------------------------------------------------------------
class AuthServiceClass
{
    func getChunkOfGoogleEmails(numberOfContacts:Int!, startIndex:Int!=1) -> Promise<Array<String>>
    {
        return Promise
            {
                (fulfill, reject) -> Void in
                if let googleUser = GIDSignIn.sharedInstance().currentUser
                {
                    let accessToken = googleUser.authentication.accessToken
                    let urlString = "https://www.google.com/m8/feeds/contacts/default/full?alt=json&max-results=\(numberOfContacts)&access_token=" + accessToken + "&start-index=\(startIndex)"
                    print(urlString)
                    Alamofire.request(.GET, urlString)
                        .responseJSON
                        {
                            (response) -> Void in
                            print("response")
                            switch response.result
                            {
                            case .Success(let JSON):
                                print("JSON")
                                if let responseDict = JSON.objectForKey("feed") as? NSDictionary
                                {
                                    if let entries = responseDict["entry"] as? Array<Dictionary<String,AnyObject>>
                                    {
                                        var emails:Array<String> = Array()
                                        for entry in entries
                                        {
                                            if let userContacts = entry as? Dictionary<String,AnyObject>
                                            {
                                                if let userEmails = userContacts["gd$email"] as? Array<Dictionary<String,AnyObject>>
                                                {
                                                    for userEmail in userEmails
                                                    {
                                                        if let address = userEmail["address"] as? String
                                                        {
                                                            emails.append(address)
                                                        }
                                                    }
                                                }
                                                
                                            }
                                        }
                                        print("got \(emails.count) emails!")
                                        if let links = responseDict.objectForKey("link") as? Array<Dictionary<String,AnyObject>>
                                        {
                                            for link in links
                                            {
                                                if ((link["rel"] as? String) == "next")
                                                {
                                                    self.getChunkOfGoogleEmails(numberOfContacts, startIndex: startIndex+numberOfContacts)
                                                    .then
                                                    {
                                                        (newEmails) -> Void in
                                                        fulfill(emails + newEmails)
                                                    }
                                                    return
                                                }
                                            }
                                        }
                                        fulfill(emails)
                                    }

                                }
                                
                                
                                
                                
                            default: break
                            }
                    }
                }
                else
                {
                    print("no google user")
                }
        }
    }
}

let AuthServiceInstance = AuthServiceClass()
