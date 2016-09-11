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


let kLoggedOut = "loggedOut"


// -----------------------------------------------------------------------------
//                       class AuthServiceClass
// -----------------------------------------------------------------------------
/// handles all communication with outside APIs -- initialized as a Singleton
/// with the name `AuthServiceInstance`
///
/// ----------------------------------------------------------------------------
class AuthServiceClass
{

