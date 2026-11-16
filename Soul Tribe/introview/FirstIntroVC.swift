//
//  FirstIntroVC.swift
//  Soul Tribe
//
//  Created by MAC-28 on 31/07/21.
//

import UIKit

class FirstIntroVC: UIViewController {

    @IBOutlet weak var btn_getStarted: UIButton!
    
    @IBAction func btn_getStartedAction(_ sender: UIButton) {
        
        let nav1 = UINavigationController()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigate = storyboard.instantiateViewController(withIdentifier: "WalkPageVC") as! WalkPageVC
        navigate.comesFrom = "First"
        nav1.navigationBar.isHidden = true
        nav1.viewControllers = [navigate]
        UIApplication.shared.windows.first?.rootViewController = nav1
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        
//        let vc = self.storyboard?.instantiateViewController(identifier: "SecondIntroVC") as! SecondIntroVC
//        navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        btn_getStarted.layer.cornerRadius = 6
        btn_getStarted.layer.borderColor = UIColor.lightGray.cgColor
        btn_getStarted.layer.borderWidth = 1
        
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
