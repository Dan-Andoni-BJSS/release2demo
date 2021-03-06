//
//  ViewController.swift
//  DemoSwift
//
//  Created by jenkins on 26/06/2016.
//  Copyright © 2016 GSMA. All rights reserved.
//

import UIKit
import MobileConnectSDK
import Alamofire

private let kPlistExtension : String = "plist"

class ViewController: UIViewController, MobileConnectManagerDelegate {
    
    //MARK: Events
    @IBAction func getAction(sender: AnyObject) {
        
      let manager : MobileConnectManager = MobileConnectManager()
      
      manager.getAttributeServiceResponse(self, context: "the context", scopes: [ProductType.IdentityPhoneNumber, ProductType.Phone], bindingMessage: "binding message") { (response, error) in
     
      }
      
    }
}

