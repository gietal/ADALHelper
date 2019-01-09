//
//  AppDelegate.swift
//  ADALHelper
//
//  Created by gietal-dev on 1/8/19.
//  Copyright © 2019 gietal-dev. All rights reserved.
//

import Cocoa
import ADAL

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    @IBOutlet weak var clientTextField: NSTextField!
    @IBOutlet weak var resourceTextField: NSTextField!
    @IBOutlet weak var redirectURITextField: NSTextField!
    @IBOutlet weak var userIdTextField: NSTextField!
    @IBOutlet weak var authorityTextField: NSTextField!
    @IBOutlet weak var tokenTextField: NSTextField!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @IBAction func getToken(_ sender: Any) {
        let authContext = ADAuthenticationContext(authority: self.authorityTextField.stringValue,
                                                  error: nil)

        if authContext == nil {
            self.tokenTextField.stringValue = "auth context is nil"
            return
        }
        // adal completion handler
        let closure: ADAuthenticationCallback = { (result) in
            DispatchQueue.main.async {
                self.tokenTextField.stringValue = result?.accessToken ?? result?.error.debugDescription ?? ""
            }
            
        }

        let userId = userIdTextField.stringValue.isEmpty ? nil : userIdTextField.stringValue
        authContext!.acquireToken(withResource: resourceTextField.stringValue,
                                  clientId: clientTextField.stringValue,
                                  redirectUri: URL(string: redirectURITextField.stringValue),
                                  promptBehavior: AD_PROMPT_AUTO,
                                  userId: userId,
                                  extraQueryParameters: nil,
                                  completionBlock: closure
        )
//
//        if let prompt = prompt {
//            if prompt {
//                // always prompt
//                authContext!.acquireToken(withResource: request.resource,
//                                          clientId: request.client,
//                                          redirectUri: URL(string: request.redirect),
//                                          promptBehavior: AD_PROMPT_ALWAYS,
//                                          userId: userId,
//                                          extraQueryParameters: nil,
//                                          completionBlock: closure
//                )
//            } else {
//                // silent. wont show prompt UI, if need user input then AD_ERROR_USER_INPUT_NEEDED is returned
//                authContext!.acquireTokenSilent(withResource: request.resource,
//                                                clientId: request.client,
//                                                redirectUri: URL(string: request.redirect),
//                                                userId: userId,
//                                                completionBlock: closure
//                )
//            }
//        } else {
//            // auto prompt
//
//        }
    }
    
}

