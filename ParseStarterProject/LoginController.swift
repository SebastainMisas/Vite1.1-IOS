//
//  LoginController.swift
//  vite1.0
//
//  Created by Sebastian Misas on 1/11/16.
//  Copyright © 2016 Sebastian Misas. All rights reserved.
//
import UIKit
import Parse
import FBSDKCoreKit
import FBSDKLoginKit
import ParseFacebookUtilsV4

class LoginController: UIViewController, FBSDKLoginButtonDelegate {
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        
        if ((error) != nil)
        {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                self.performSegueWithIdentifier("ShowMainController", sender: self)
                print("User Logged In")
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    
    @IBOutlet weak var webViewBG: UIWebView!
    
    override func viewDidLoad() {
        
    // The code below is to use the gif as a motion background for login page.
        let filePath = NSBundle.mainBundle().pathForResource("giphy", ofType: "gif")
        let gif = NSData(contentsOfFile: filePath!)
        webViewBG.loadData(gif!, MIMEType: "image/gif", textEncodingName: String(), baseURL: NSURL())
        webViewBG.userInteractionEnabled = false;

    // if user is logged in already go to main page else show FB login button
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            // User is already logged in, do work such as go to next view controller.
            dispatch_async(dispatch_get_main_queue()){
                self.performSegueWithIdentifier("ShowMainController", sender: self)
            }
            print("user logged in already")
        }
        else
        {
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            self.view.addSubview(loginView)
            loginView.center = self.view.center
            loginView.readPermissions = ["public_profile", "email", "user_friends"]
            loginView.delegate = self
        }
    
    // saving the user to Parse when he logs in faceboook with access to his public info.
        let permissions = ["public_profile", "email"]
        
        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions) {
            
            (user: PFUser?, error: NSError?) -> Void in
            
            if let error = error {
                print(error)
            }
            else {
                if let user = user {
                    self.performSegueWithIdentifier("ShowMainController", sender: self)
                    print(user)
                }
            }
            
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


