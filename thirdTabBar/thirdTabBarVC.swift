//
//  TTabBarViewController.swift
//  TTabBarViewController
//
//  Created by Mohamed Salah on 1/30/18.
//  Copyright © 2018 Mohamed Salah. All rights reserved.
//

import UIKit

extension UIImage{
    //Draws the top indicator by making image with filling color
    class func drawTabBarIndicator2(color: UIColor, size: CGSize, onTop: Bool) -> UIImage {
        let indicatorHeight = size.height / 30
        let yPosition = onTop ? 0 : (size.height - indicatorHeight)

        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: yPosition, width: size.width, height: indicatorHeight))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image ?? UIImage(named: "default_image")!
    }
}

/**
    Custom UITabBarController class which draw line indicator
    with custom color above or below the selected tab bar item using
    selectionIndicatorImage property on the UITabBar class
 **/
@IBDesignable class thirdTabBarVC: UITabBarController{
    
    @IBOutlet weak var optionView1: UIView!
    @IBOutlet weak var optionView1CornerRadius: UIView!
    @IBOutlet weak var popUpView_upgradeBtn: UIButton!
    @IBOutlet weak var popUpView_CancelBtn: UIButton!
    /*
        color of the indicator
     */
    @IBInspectable var indicatorColor: UIColor = UIColor()
    /*
        determine if the indicator
        will be drawn on top of bar items or not
     */
    @IBInspectable var onTopIndicator: Bool = true
    var comeFromPremiumPlan = String()
    
    //MARK:- View Controller Life Cycle
   
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        get_profileAPI()
//    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if premiumPlaStatus == 1 {
            if premiumFreePlanStatus == 0 {
                self.popUpView_upgradeBtn.setTitle("Start Your FREE 7-Day Trial Today!", for: .normal)
            }
        }else{
            self.popUpView_upgradeBtn.setTitle("Start Your FREE 7-Day Trial Today!", for: .normal)
        }
        
        self.optionView1.removeFromSuperview()
        self.optionView1CornerRadius.layer.cornerRadius = 6
        self.popUpView_upgradeBtn.layer.cornerRadius = 6
        
        Config().AppUserDefaults.setValue("yes", forKey: "Login")
        
        if self.comeFromPremiumPlan == "y" {
            self.optionView1.frame = self.view.frame
            self.optionView1.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            self.view.addSubview(self.optionView1)
        }
        
        // Draw Indicator above the tab bar items
        guard let numberOfTabs = tabBar.items?.count else {
            return
        }
        
//        let numberOfTabsFloat = CGFloat(numberOfTabs)
//        let imageSize = CGSize(width: tabBar.frame.width / numberOfTabsFloat,
//                               height: tabBar.frame.height)
//
//
//        let indicatorImage = UIImage.drawTabBarIndicator(color: indicatorColor,
//                                                         size: imageSize,
//                                                         onTop: onTopIndicator)
//        self.tabBar.selectionIndicatorImage = indicatorImage
    }
//    func get_profileAPI()  {
//
//        let parameterDictionary = NSMutableDictionary()
//        let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
//        parameterDictionary.setValue("tribe123", forKey: "api_key")
//        parameterDictionary.setValue(userID, forKey: "user_id")
//
//        print(parameterDictionary)
//        let methodName = "get_profile"
//
//        DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){ [](responseData,error)-> Void in
//            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
//
//            if status == "1" {
//                let data = DataManager.getVal(responseData?["data"]) as? NSDictionary
//                premiumPlaStatus = data?.value(forKey: "premium_plan_status") as? Int ?? 0
//                USER_VIBE = data?.value(forKey: "vibe") as? String ?? ""
//
//                if USER_VIBE.contains("Mini Tribes") {
//                    let ra = "Mini Tribes"
//                    let newVibe = USER_VIBE.replacingOccurrences(of: ra, with: "Mini")
//
//                    if newVibe.contains("Mini") &&  !newVibe.contains("Soul Love") && !newVibe.contains("Tribe"){
////                        if let tabBarController = self.tabBarController {
////                            let indexToRemove = 2
////                            if indexToRemove < tabBarController.viewControllers!.count {
////                                var viewControllers = tabBarController.viewControllers
////                                viewControllers?.remove(at: indexToRemove)
////                                tabBarController.viewControllers = viewControllers
////                            }
////                        }
//
//                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                            let navigate = storyboard.instantiateViewController(withIdentifier: "SecondTabBarVC") as! SecondTabBarVC
//                            let leftController = storyboard.instantiateViewController(withIdentifier: "LeftMenuViewController") as! LeftMenuViewController
//                            let slideMenuController = SlideMenuController(mainViewController: UINavigationController(rootViewController:navigate), leftMenuViewController: leftController)
//                            slideMenuController.delegate = leftController as? SlideMenuControllerDelegate
//                            UIApplication.shared.windows.first?.rootViewController = slideMenuController
//                            UIApplication.shared.windows.first?.makeKeyAndVisible()
//                            self.tabBar.isUserInteractionEnabled = true
//
//                    }else{
//                        //5
//                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                        let navigate = storyboard.instantiateViewController(withIdentifier: "TTabBarViewController") as! TTabBarViewController
//                        let leftController = storyboard.instantiateViewController(withIdentifier: "LeftMenuViewController") as! LeftMenuViewController
//                        let slideMenuController = SlideMenuController(mainViewController: UINavigationController(rootViewController:navigate), leftMenuViewController: leftController)
//                        slideMenuController.delegate = leftController as? SlideMenuControllerDelegate
//                        UIApplication.shared.windows.first?.rootViewController = slideMenuController
//                        UIApplication.shared.windows.first?.makeKeyAndVisible()
//                        self.tabBar.isUserInteractionEnabled = true
//                    }
//                }
//            } else {
////                 self.view.makeToast(message)
//            }
//        }
//    }
    @IBAction func popUp_CancelAction(_ sender: Any) {
        self.comeFromPremiumPlan = "n"
        self.optionView1.removeFromSuperview()
    }
    @IBAction func popUp_upgradeAction(_ sender: Any) {
        self.comeFromPremiumPlan = "n"
        self.optionView1.removeFromSuperview()
        let navigate = storyboard?.instantiateViewController(withIdentifier: "MemberShipPlanVC") as! MemberShipPlanVC
        navigate.comeFromProfile = "fromLikedVC"
        self.navigationController?.pushViewController(navigate, animated: true)
    }
}

