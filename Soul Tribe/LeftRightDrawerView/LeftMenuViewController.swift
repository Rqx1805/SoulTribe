//
//  LeftMenuViewController.swift
//  AssanUser
//
//  Created by Sensu Soft on 31/07/17.
//  Copyright © 2017 Sensussoft. All rights reserved.
//

import UIKit
import StoreKit

let KEY_SIDEMENU_IMAGE = "SIDEMENU_IMAGE"
let KEY_SIDEMENU_ITEM = "SIDEMENU_ITEM"
let KEY_SIDEMENU_SELECTED = "KEY_SIDEMENU_SELECTED"
var premiumPlaStatus = Int()
var premiumFreePlanStatus = Int()
var USER_VIBE = String()
var NotificationUSERvibe = String()
class LeftMenuViewController: UIViewController {
    
    @IBOutlet weak var optionView1: UIView!
    @IBOutlet weak var optionView1CornerRadius: UIView!
    @IBOutlet weak var popUpView_upgradeBtn: UIButton!
    @IBOutlet weak var popUpView_CancelBtn: UIButton!
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
   
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblMiles: UILabel!
    @IBOutlet weak var milesSlider: UISlider!

   // @IBOutlet weak var viewRatting: HCSStarRatingView!
    @IBOutlet weak var lblRatting: UILabel!
    
    @IBOutlet weak var stepperControl: UIStepper!
    
    @IBOutlet weak var viewTopHeader: UIView!
   // @IBOutlet weak var viewTopround: UIView!

    
    var arrListMenu = [[String: AnyObject]]()
    typealias CompletionBlock = (IndexPath) -> Void
    var menuClickBlock : CompletionBlock!
    var leftDrawerTransition:DrawerTransition!
    
    var dicAchivementTotal : [String : AnyObject]!
    
    var defaults:UserDefaults!
    var userid: Int!
    var usrImg = String()
    var usrName = String()
    var langugeDefault = String()
    
    var storyboard1: UIStoryboard!
    var navController : UINavigationController!
    var window: UIWindow?
    
    var data = false
    var nameArray = ["Home","Who Liked Me","Block List","Membership Plans","Advertise on Soul Tribe!","Settings","Invite Friends","Rate Soul Tribe!","Terms & Privacy","FAQ’s","Logout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.imgProfile?.layer.cornerRadius = self.imgProfile.frame.size.width/2
       // doSetupUI()
       // viewTopHeader.roundCorners([.topLeft, .bottomRight], radius: 10)
        //viewTopround.layer.cornerRadius = 8
    }
    func LogoutAPI(){
            
            let paraDict = NSMutableDictionary()
            paraDict.setValue(Config().api_key, forKey: "api_key")
            paraDict.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
                
            print(paraDict)
            
            let methodName = "logout"
            DataManager.getAPIResponse(paraDict , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
                let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
                let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
                print(message)
                if status == "3" {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                    let navigationController = UINavigationController(rootViewController: newViewController)
                    UIApplication.shared.windows.first?.rootViewController = navigationController
                    UIApplication.shared.windows.first?.makeKeyAndVisible()
                    Config().AppUserDefaults.setValue("no", forKey: "Login")
                    Config().AppUserDefaults.setValue("", forKey: "userVibe")
                }
                else {
                    print(message)
                }
            }
        }
    func doSetupUI() {
        
       let parameterDictionary = NSMutableDictionary()
       let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
       let userVibe = UserDefaults.standard.string(forKey: "userVibe")
       parameterDictionary.setValue("tribe123", forKey: "api_key")
       parameterDictionary.setValue(userID, forKey: "user_id")
       parameterDictionary.setValue(SELECT_VIBE, forKey: "vibe")
        let lati = UserDefaults.standard.string(forKey: "lati")
        let longi = UserDefaults.standard.string(forKey: "longi")
        let city = UserDefaults.standard.string(forKey: "city")
        let state = UserDefaults.standard.string(forKey: "state")
        
        parameterDictionary.setValue(lati, forKey: "latitude")
        parameterDictionary.setValue(longi, forKey: "longitude")
        parameterDictionary.setValue(state, forKey: "state")
        parameterDictionary.setValue(city, forKey: "city")
       parameterDictionary.setValue(userVibe, forKey: "vibe")
       let methodName = "get_users_list"
        DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let user_logout_status  = DataManager.getVal(responseData?["user_logout_status"]) as? String ?? ""
            if status == "1" {
                SoulLoveSwipeLimitCount = Int(DataManager.getVal(responseData?["userSoulLoveSwipeCount"]) as? String ?? "")!
                tribeSwipeLimitCount = Int(DataManager.getVal(responseData?["userTribeSwipeCount"]) as? String ?? "")!
                likedNotificationCount = DataManager.getVal(responseData?["liked_count"]) as? String ?? ""
                self.tblView.reloadData()
                if user_logout_status == "0" {
                    self.LogoutAPI()
                                }else{
                                    
                                }
            }
            else {
                if user_logout_status == "0" {
                    self.LogoutAPI()
                                }else{
                                    
                                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        doSetupUI()
        let userVibe = UserDefaults.standard.string(forKey: "userVibe")
        if userVibe == "Mini Tribes" {
            nameArray = ["Home","Block List","Membership Plans","Advertise on Soul Tribe!","Settings","Invite Friends","Rate Soul Tribe!","Terms & Privacy","FAQ’s","Logout"]
        }else{
            nameArray = ["Home","Who Liked Me","Block List","Membership Plans","Advertise on Soul Tribe!","Settings","Invite Friends","Rate Soul Tribe!","Terms & Privacy","FAQ’s","Logout"]
        }
        self.lblName?.text = Config().AppUserDefaults.value(forKey:"user_name") as? String ?? ""
        self.lblEmail?.text = Config().AppUserDefaults.value(forKey:"user_email") as? String ?? ""
        let profileImg = Config().AppUserDefaults.value(forKey:"user_image") as? String ?? ""
        self.imgProfile?.sd_setImage(with: URL(string: Config().baseImageUrl + profileImg), completed: nil)
        self.imgProfile?.layer.cornerRadius = self.imgProfile.frame.size.width/2
        self.imgProfile?.clipsToBounds = true
        tblView.reloadData()
//        imgProfile.layer.cornerRadius = imgProfile.frame.width/2
//        imgProfile.layer.masksToBounds = true
//        let window = self.view.superview
//        self.view.removeFromSuperview()
//        window?.addSubview(self.view)
//
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
      //  doSetupUI()
        
    }
    @IBAction func profileBtnAction(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("profile"), object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnclose(_ sender: UIButton) {
        self.slideMenuController()?.toggleLeft()

    }
    
    func clickCellEvent(completion : @escaping CompletionBlock)  {
        menuClickBlock = completion
    }
    
    
}

extension LeftMenuViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SideMenuCell
        cell.lblItem.text = nameArray[indexPath.item]
        cell.likedCount.layer.cornerRadius = cell.likedCount.frame.width/2
        cell.likedCount.clipsToBounds = true
        if likedNotificationCount == "0" {
            cell.likedCount.text = ""
            cell.likedCount.isHidden = true
            cell.likedCount.backgroundColor = UIColor.white
        }else{
            cell.likedCount.isHidden = false
            cell.likedCount.backgroundColor = UIColor(red: 0.09, green: 0.78, blue: 0.61, alpha: 1.00)
         cell.likedCount.text = likedNotificationCount
        }
        let userVibe = UserDefaults.standard.string(forKey: "userVibe")
        if  indexPath.row == 1{
            if userVibe == "Mini Tribes" {
                cell.crown_icon.isHidden = true
                cell.likedCount.isHidden = true
            }else{
                cell.crown_icon.isHidden = false
                cell.likedCount.isHidden = false
            }
            
        }
        else
        {
            cell.crown_icon.isHidden = true
            cell.likedCount.isHidden = true
        }
        
//        if userVibe == "Mini Tribes" {
//        if indexPath.row == 10 {
//            cell.lblItem.textColor = UIColor.red
//        }else{
//            cell.lblItem.textColor = UIColor.gray
//        }
//        }else{
//            if indexPath.row == 11 {
//                cell.lblItem.textColor = UIColor.red
//            }else{
//                cell.lblItem.textColor = UIColor.gray
//            }
//        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userVibe = UserDefaults.standard.string(forKey: "userVibe")
        if userVibe == "Mini Tribes" {
            if indexPath.row == 0 {
                
                if USER_VIBE.contains("Mini Tribes") {
                    let ra = "Mini Tribes"
                    let newVibe = USER_VIBE.replacingOccurrences(of: ra, with: "Mini")

                    if newVibe.contains("Mini") &&  !newVibe.contains("Soul Love") && !newVibe.contains("Tribe"){
    //                        if let tabBarController = self.tabBarController {
    //                            let indexToRemove = 2
    //                            if indexToRemove < tabBarController.viewControllers!.count {
    //                                var viewControllers = tabBarController.viewControllers
    //                                viewControllers?.remove(at: indexToRemove)
    //                                tabBarController.viewControllers = viewControllers
    //                            }
    //                        }
                        
                        let navigate = storyboard?.instantiateViewController(withIdentifier: "SecondTabBarVC") as! SecondTabBarVC
                        self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
                        self.tabBarController?.tabBar.isUserInteractionEnabled = true
                      
                    }else{
                        //5
                        let navigate = storyboard?.instantiateViewController(withIdentifier: "TTabBarViewController") as! TTabBarViewController
                        self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
                        self.tabBarController?.tabBar.isUserInteractionEnabled = true
                    }
                }else{
                    let navigate = storyboard?.instantiateViewController(withIdentifier: "thirdTabBarVC") as! thirdTabBarVC
                    self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
                    self.tabBarController?.tabBar.isUserInteractionEnabled = true
                }
                
            }
//            else if indexPath.row == 1 {
//
//                if premiumPlaStatus == 0 {
//
//                    if USER_VIBE.contains("Mini Tribes") {
//                        let ra = "Mini Tribes"
//                        let newVibe = USER_VIBE.replacingOccurrences(of: ra, with: "Mini")
//
//                        if newVibe.contains("Mini") &&  !newVibe.contains("Soul Love") && !newVibe.contains("Tribe"){
//        //                        if let tabBarController = self.tabBarController {
//        //                            let indexToRemove = 2
//        //                            if indexToRemove < tabBarController.viewControllers!.count {
//        //                                var viewControllers = tabBarController.viewControllers
//        //                                viewControllers?.remove(at: indexToRemove)
//        //                                tabBarController.viewControllers = viewControllers
//        //                            }
//        //                        }
//
//                            let navigate = storyboard?.instantiateViewController(withIdentifier: "SecondTabBarVC") as! SecondTabBarVC
//                            navigate.comeFromPremiumPlan = "y"
//                            self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
//                            self.tabBarController?.tabBar.isUserInteractionEnabled = true
//
//                        }else{
//                            //5
//                            let navigate = storyboard?.instantiateViewController(withIdentifier: "TTabBarViewController") as! TTabBarViewController
//                            navigate.comeFromPremiumPlan = "y"
//                            self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
//                            self.tabBarController?.tabBar.isUserInteractionEnabled = true
//                        }
//                    }else{
//                        let navigate = storyboard?.instantiateViewController(withIdentifier: "thirdTabBarVC") as! thirdTabBarVC
//                        navigate.comeFromPremiumPlan = "y"
//                        self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
//                        self.tabBarController?.tabBar.isUserInteractionEnabled = true
//                    }
//                }else{
//                    let navigate = storyboard?.instantiateViewController(withIdentifier: "WhoLikedMeVC") as! WhoLikedMeVC
//                    self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
//                }
//            }
            else if indexPath.row == 1 {
                let navigate = storyboard?.instantiateViewController(withIdentifier: "BlockListVC") as! BlockListVC
                self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
            }
            else if indexPath.row == 2 {
                let navigate = storyboard?.instantiateViewController(withIdentifier: "MemberShipPlanVC") as! MemberShipPlanVC
                self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
            }
            else if indexPath.row == 3 {
                let navigate = storyboard?.instantiateViewController(withIdentifier: "AdvertiseOnSoulTribeVC") as! AdvertiseOnSoulTribeVC
                self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
            }
            else if indexPath.row == 4 {
                let navigate = storyboard?.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
                self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
            }
            
            else if indexPath.row == 5 {
                let navigate = storyboard?.instantiateViewController(withIdentifier: "InviteFriendVC") as! InviteFriendVC
                self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
            }
            else if indexPath.row == 6 {
                let navigate = storyboard?.instantiateViewController(withIdentifier: "RateSoulTribeVC") as! RateSoulTribeVC
                self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
            }
            else if indexPath.row == 7 {
                let navigate = storyboard?.instantiateViewController(withIdentifier: "T_CVC") as! T_CVC
                self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
            }
            else if indexPath.row == 8 {
                let navigate = storyboard?.instantiateViewController(withIdentifier: "FAQ_sVC") as! FAQ_sVC
                self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
            }
    //        else if indexPath.row == 10 {
    //            let navigate = storyboard?.instantiateViewController(withIdentifier: "FAQ_sVC") as! FAQ_sVC
    //            self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
    //        }
            else if indexPath.row == 9 {
                //let navigate = storyboard?.instantiateViewController(withIdentifier: "LogoutVC") as! LogoutVC
                
                let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
                
                let imgView = UIImageView(frame: CGRect(x: alert.view.frame.size.width/3.5, y: 25, width: 70, height: 50))
                imgView.setImage(UIImage(named: "Ratelogo")!)
                let labl = UILabel()
                labl.text = "Are you sure you want to logout?"
                labl.textColor = UIColor.black
                labl.frame = CGRect(x: alert.view.frame.size.width/7.5, y: imgView.frame.width + 15, width: alert.view.frame.width - 190, height: 50)
                labl.numberOfLines = 2
                labl.textAlignment = .center
                alert.view.addSubview(imgView)
                alert.view.addSubview(labl)
                let OKAction = UIAlertAction(title: "Yes", style: .default) { (action:UIAlertAction!) in
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                                    let navigationController = UINavigationController(rootViewController: newViewController)
                                    UIApplication.shared.windows.first?.rootViewController = navigationController
                                    UIApplication.shared.windows.first?.makeKeyAndVisible()

                   // self.navigationController?.popToRootViewController(animated: true)
                    // Code in this block will trigger when OK button tapped.
                            print("Ok button tapped");
                    Config().AppUserDefaults.setValue("no", forKey: "Login")
                    Config().AppUserDefaults.setValue("", forKey: "userVibe")
                        }
                alert.addAction(OKAction)
                        
                        // Create Cancel button
                        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
                            print("Cancel button tapped");
                        }
                alert.addAction(cancelAction)
                // height constraint
                let constraintHeight = NSLayoutConstraint(
                   item: alert.view!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute:
                   NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 190)
                alert.view.addConstraint(constraintHeight)

                // width constraint
                let constraintWidth = NSLayoutConstraint(
                   item: alert.view!, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute:
                   NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 300)
                alert.view.addConstraint(constraintWidth)
                
                        self.present(alert, animated: true, completion:nil)
                //self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
            }
        }else{
            if indexPath.row == 0 {
                
                if USER_VIBE.contains("Mini Tribes") {
                    let ra = "Mini Tribes"
                    let newVibe = USER_VIBE.replacingOccurrences(of: ra, with: "Mini")

                    if newVibe.contains("Mini") &&  !newVibe.contains("Soul Love") && !newVibe.contains("Tribe"){
    //                        if let tabBarController = self.tabBarController {
    //                            let indexToRemove = 2
    //                            if indexToRemove < tabBarController.viewControllers!.count {
    //                                var viewControllers = tabBarController.viewControllers
    //                                viewControllers?.remove(at: indexToRemove)
    //                                tabBarController.viewControllers = viewControllers
    //                            }
    //                        }
                        
                        let navigate = storyboard?.instantiateViewController(withIdentifier: "SecondTabBarVC") as! SecondTabBarVC
                        self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
                        self.tabBarController?.tabBar.isUserInteractionEnabled = true
                      
                    }else{
                        //5
                        let navigate = storyboard?.instantiateViewController(withIdentifier: "TTabBarViewController") as! TTabBarViewController
                        self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
                        self.tabBarController?.tabBar.isUserInteractionEnabled = true
                    }
                }else{
                    let navigate = storyboard?.instantiateViewController(withIdentifier: "thirdTabBarVC") as! thirdTabBarVC
                    self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
                    self.tabBarController?.tabBar.isUserInteractionEnabled = true
                }
                
            }
            else if indexPath.row == 1 {
                
                if premiumPlaStatus == 0 {
                    
                    if USER_VIBE.contains("Mini Tribes") {
                        let ra = "Mini Tribes"
                        let newVibe = USER_VIBE.replacingOccurrences(of: ra, with: "Mini")

                        if newVibe.contains("Mini") &&  !newVibe.contains("Soul Love") && !newVibe.contains("Tribe"){
        //                        if let tabBarController = self.tabBarController {
        //                            let indexToRemove = 2
        //                            if indexToRemove < tabBarController.viewControllers!.count {
        //                                var viewControllers = tabBarController.viewControllers
        //                                viewControllers?.remove(at: indexToRemove)
        //                                tabBarController.viewControllers = viewControllers
        //                            }
        //                        }
                            
                            let navigate = storyboard?.instantiateViewController(withIdentifier: "SecondTabBarVC") as! SecondTabBarVC
                            navigate.comeFromPremiumPlan = "y"
                            self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
                            self.tabBarController?.tabBar.isUserInteractionEnabled = true
                          
                        }else{
                            //5
                            let navigate = storyboard?.instantiateViewController(withIdentifier: "TTabBarViewController") as! TTabBarViewController
                            navigate.comeFromPremiumPlan = "y"
                            self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
                            self.tabBarController?.tabBar.isUserInteractionEnabled = true
                        }
                    }else{
                        let navigate = storyboard?.instantiateViewController(withIdentifier: "thirdTabBarVC") as! thirdTabBarVC
                        navigate.comeFromPremiumPlan = "y"
                        self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
                        self.tabBarController?.tabBar.isUserInteractionEnabled = true
                    }
                }else{
                    let navigate = storyboard?.instantiateViewController(withIdentifier: "WhoLikedMeVC") as! WhoLikedMeVC
                    self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
                }
            }
            else if indexPath.row == 2 {
                let navigate = storyboard?.instantiateViewController(withIdentifier: "BlockListVC") as! BlockListVC
                self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
            }
            else if indexPath.row == 3 {
                let navigate = storyboard?.instantiateViewController(withIdentifier: "MemberShipPlanVC") as! MemberShipPlanVC
                self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
            }
            else if indexPath.row == 4 {
                let navigate = storyboard?.instantiateViewController(withIdentifier: "AdvertiseOnSoulTribeVC") as! AdvertiseOnSoulTribeVC
                self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
            }
            else if indexPath.row == 5 {
                let navigate = storyboard?.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
                self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
            }
            
            else if indexPath.row == 6 {
                let navigate = storyboard?.instantiateViewController(withIdentifier: "InviteFriendVC") as! InviteFriendVC
                self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
            }
            else if indexPath.row == 7 {
                let navigate = storyboard?.instantiateViewController(withIdentifier: "RateSoulTribeVC") as! RateSoulTribeVC
                self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
            }
            else if indexPath.row == 8 {
                let navigate = storyboard?.instantiateViewController(withIdentifier: "T_CVC") as! T_CVC
                self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
            }
            else if indexPath.row == 9 {
                let navigate = storyboard?.instantiateViewController(withIdentifier: "FAQ_sVC") as! FAQ_sVC
                self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
            }
    //        else if indexPath.row == 10 {
    //            let navigate = storyboard?.instantiateViewController(withIdentifier: "FAQ_sVC") as! FAQ_sVC
    //            self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
    //        }
            else if indexPath.row == 10 {
                //let navigate = storyboard?.instantiateViewController(withIdentifier: "LogoutVC") as! LogoutVC
                
                let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
                
                let imgView = UIImageView(frame: CGRect(x: alert.view.frame.size.width/3.5, y: 25, width: 70, height: 50))
                imgView.setImage(UIImage(named: "Ratelogo")!)
                let labl = UILabel()
                labl.text = "Are you sure you want to logout?"
                labl.textColor = UIColor.black
                labl.frame = CGRect(x: alert.view.frame.size.width/7.5, y: imgView.frame.width + 15, width: alert.view.frame.width - 190, height: 50)
                labl.numberOfLines = 2
                labl.textAlignment = .center
                alert.view.addSubview(imgView)
                alert.view.addSubview(labl)
                let OKAction = UIAlertAction(title: "Yes", style: .default) { (action:UIAlertAction!) in
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                                    let navigationController = UINavigationController(rootViewController: newViewController)
                                    UIApplication.shared.windows.first?.rootViewController = navigationController
                                    UIApplication.shared.windows.first?.makeKeyAndVisible()

                   // self.navigationController?.popToRootViewController(animated: true)
                    // Code in this block will trigger when OK button tapped.
                            print("Ok button tapped");
                    Config().AppUserDefaults.setValue("no", forKey: "Login")
                    Config().AppUserDefaults.setValue("", forKey: "userVibe")
                        }
                alert.addAction(OKAction)
                        
                        // Create Cancel button
                        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
                            print("Cancel button tapped");
                        }
                alert.addAction(cancelAction)
                // height constraint
                let constraintHeight = NSLayoutConstraint(
                   item: alert.view!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute:
                   NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 190)
                alert.view.addConstraint(constraintHeight)

                // width constraint
                let constraintWidth = NSLayoutConstraint(
                   item: alert.view!, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute:
                   NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 300)
                alert.view.addConstraint(constraintWidth)
                
                        self.present(alert, animated: true, completion:nil)
                //self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
            } 
        }
        
        
        
        
//        for i in 0 ..< self.arrListMenu.count
//        {
//            if(i==indexPath.row)
//            {
//                self.arrListMenu[i]["is_selected"] = "true" as AnyObject
//            }
//            else
//            {
//                self.arrListMenu[i]["is_selected"] = "false" as AnyObject
//            }
//            self.tblView.reloadData()
//        }
//
//        menuClickBlock(indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60

    }
}
