//
//  ThirdIntroVC.swift
//  Soul Tribe
//
//  Created by MAC-28 on 31/07/21.
//

import UIKit

class ThirdIntroVC: UIViewController {

    
    @IBAction func btn_loginAction(_ sender: UIButton) {
        
        Config().AppUserDefaults.setValue("1", forKey: "WalkthroughCompleted")
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                        let navigationController = UINavigationController(rootViewController: newViewController)
                        UIApplication.shared.windows.first?.rootViewController = navigationController
                        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    @IBAction func btn_signupAction(_ sender: UIButton) {
        
        Config().AppUserDefaults.setValue("1", forKey: "WalkthroughCompleted")
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
                        let navigationController = UINavigationController(rootViewController: newViewController)
                        UIApplication.shared.windows.first?.rootViewController = navigationController
                        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    
    @IBOutlet weak var BTN_SIGNUP: UIButton!
    @IBOutlet weak var BTN_LOGIN: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        BTN_LOGIN.layer.cornerRadius = 6
        BTN_LOGIN.layer.borderColor = UIColor.lightGray.cgColor
        BTN_LOGIN.layer.borderWidth = 1
        
        BTN_SIGNUP.layer.cornerRadius = 6
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func btngotonext(_ sender: UIButton) {
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//                        let navigationController = UINavigationController(rootViewController: newViewController)
//                        UIApplication.shared.windows.first?.rootViewController = navigationController
//                        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    }
    

