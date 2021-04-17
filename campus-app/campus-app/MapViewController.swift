//
//  MapViewController.swift
//  campus-app
//
//  Created by Yuka Okada on 2021/04/17.
//

import UIKit
import AWSMobileClient

class MapViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Do any additional setup after loading the view.
        AWSMobileClient.sharedInstance().initialize { (UserState, error) in
            
            if let userState = UserState {
                switch (UserState) {
                case .signedIn:
                    DispatchQueue.main.async {
                        self.appDelegate.username = AWSMobileClient.default().username
                        print(AWSMobileClient.default().username)
                        print(self.appDelegate.username)
                        print("Logged In")
                        self.usernameLabel.text = self.appDelegate.username + "さん"
                    }
                    
                case .signedOut:
                    AWSMobileClient.sharedInstance().showSignIn(navigationController: self.navigationController!, { (UserState, error) in
                        if (error == nil){ //サインイン成功時
                            DispatchQueue.main.async {
                                self.appDelegate.username = AWSMobileClient.default().username
                                print(AWSMobileClient.default().username)
                                print("Sign In")
                                self.usernameLabel.text = self.appDelegate.username + "さん"
                            }

                        }

                    })
                default:
                    AWSMobileClient.sharedInstance().signOut()
                    self.appDelegate.username = AWSMobileClient.default().username
                }
                
 
            } else if let error = error {
                print(error.localizedDescription)
            }
            
            print("username")
            print(AWSMobileClient.default().username)
            print("username")
        }
        
        
    }
    

}

