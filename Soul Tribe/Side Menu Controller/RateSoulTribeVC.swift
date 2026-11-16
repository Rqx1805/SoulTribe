//
//  RateSoulTribeVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 11/06/21.
//

import UIKit
import StoreKit

class RateSoulTribeVC: UIViewController {
    var leftDrawerTransition:DrawerTransition!
    var left = LeftMenuViewController()
    
    @IBOutlet weak var ratingView: FloatRatingView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true

        // Do any additional setup after loading the view.
    }
    
    func ratingAPI(){
        let parameterDictionary = NSMutableDictionary()
        let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
       parameterDictionary.setValue("tribe123", forKey: "api_key")
       parameterDictionary.setValue(userID, forKey: "user_id")
        parameterDictionary.setValue(self.ratingView.rating, forKey: "rating")

       print(parameterDictionary)
        let methodName = "user_app_rating"

        DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""

            if status == "1" {
                self.view.makeToast(message)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.slideMenuController()?.toggleLeft()
                }
            }
            else {
                self.view.makeToast(message)
            }
        }
    }
    
    @IBAction func backbtnaction(_ sender:UIButton) {
//        self.slideMenuController()?.toggleLeft()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigate = storyboard.instantiateViewController(withIdentifier: "TTabBarViewController") as! TTabBarViewController
        let leftController = storyboard.instantiateViewController(withIdentifier: "LeftMenuViewController") as! LeftMenuViewController
        let slideMenuController = SlideMenuController(mainViewController: UINavigationController(rootViewController:navigate), leftMenuViewController: leftController)
        slideMenuController.delegate = leftController as? SlideMenuControllerDelegate
        UIApplication.shared.windows.first?.rootViewController = slideMenuController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    @IBAction func ratingNowBtnAction(_ sender:UIButton) {
        if #available(iOS 10.3, *) {
            if let url = URL(string: "https://apps.apple.com/in/app/soul-tribe/id1572268299") {
                UIApplication.shared.open(url)
            }
           // SKStoreReviewController.requestReview()
            } else if let url = URL(string: "https://apps.apple.com/in/app/soul-tribe/id1572268299") {
                    if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                           
            } else {
                UIApplication.shared.openURL(url)
                }
            }
    }

}
