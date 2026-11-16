//
//  overAllIntentions.swift
//  Soul Tribe
//
//  Created by mac-14 on 29/11/21.
//

import UIKit

class monthlyIntentionsVC: UIViewController,UITextViewDelegate {

    @IBOutlet weak var optionView1: UIView!
    @IBOutlet weak var optionView1CornerRadius: UIView!
    @IBOutlet weak var popUp_back: UIButton!
    @IBOutlet weak var popUp_Affirm: UIButton!
    
    @IBOutlet weak var firstDate_lbl: UILabel!
    @IBOutlet weak var firstDate_SubLbl: UILabel!
    @IBOutlet weak var secondDate_lbl: UILabel!
    @IBOutlet weak var secondDate_subLbl: UILabel!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var text_View: UITextView!
    var comesFromSignUp = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        text_View.text = "write your text here"
//        text_View.textColor = UIColor.lightGray
        
        optionView1CornerRadius.layer.cornerRadius = 6
        popUp_back.layer.borderWidth = 0.5
        popUp_back.layer.cornerRadius = 6
        popUp_Affirm.layer.cornerRadius = 6
        popUp_back.layer.borderColor = UIColor.lightGray.cgColor
        text_View.layer.borderWidth = 0.5
        text_View.layer.borderColor = UIColor.lightGray.cgColor
        text_View.layer.cornerRadius = 6
        saveButton.layer.cornerRadius = 6
        skipButton.layer.borderColor = UIColor.lightGray.cgColor
        skipButton.layer.borderWidth = 0.5
        skipButton.layer.cornerRadius = 6
        
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy"
        let dateString = formatter.string(from: now)
        
        let formatter1 = DateFormatter()
        formatter1.timeZone = TimeZone.current
        formatter1.dateFormat = "MM"
        let dateString1 = formatter1.string(from: now)
        let monthName1 = DateFormatter().monthSymbols[Int(dateString1)! - 1]
        
        self.firstDate_lbl.text = "Monthly Intentions"
        self.secondDate_lbl.text = monthName1 + " " + dateString
        
    }
    
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        if text_View.textColor == UIColor.lightGray {
//            text_View.text = ""
//            text_View.textColor = UIColor.black
//        }
//    }
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if text_View.text.isEmpty {
//            text_View.text = "Write your answer here"
//            text_View.textColor = UIColor.lightGray
//        }
//    }
    
    @IBAction func hidePopUpView1(_ sender: Any) {
        self.optionView1.removeFromSuperview()
    }
    @IBAction func AffirmIntentions(_ sender: Any) {
        self.optionView1.removeFromSuperview()
        saveIntentions()
    }
    
    func saveIntentions() {
       
            let parameterDictionary = NSMutableDictionary()
         let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
           parameterDictionary.setValue("tribe123", forKey: "api_key")
            parameterDictionary.setValue(userID, forKey: "user_id")
            parameterDictionary.setValue("Monthly", forKey: "type")
            parameterDictionary.setValue(text_View.text, forKey: "answere")
            parameterDictionary.setValue(self.secondDate_subLbl.text, forKey: "question")
           print(parameterDictionary)
            let methodName = "insert_intention"

            DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
                let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
                let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""

                if status == "1" {
                    
                        if self.comesFromSignUp == "yes2" {
                            self.view.makeToast(message)
//                            DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
//                                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//                                                let newViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//                                                let navigationController = UINavigationController(rootViewController: newViewController)
//                                                UIApplication.shared.windows.first?.rootViewController = navigationController
//                                                UIApplication.shared.windows.first?.makeKeyAndVisible()
//                            }
                            print(USER_VIBE)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
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
                                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                            let navigate = storyboard.instantiateViewController(withIdentifier: "SecondTabBarVC") as! SecondTabBarVC
                                            let leftController = storyboard.instantiateViewController(withIdentifier: "LeftMenuViewController") as! LeftMenuViewController
                                            let slideMenuController = SlideMenuController(mainViewController: UINavigationController(rootViewController:navigate), leftMenuViewController: leftController)
                                            slideMenuController.delegate = leftController as? SlideMenuControllerDelegate
                                            UIApplication.shared.windows.first?.rootViewController = slideMenuController
                                            UIApplication.shared.windows.first?.makeKeyAndVisible()
                                        self.tabBarController?.tabBar.isUserInteractionEnabled = true
                                        SELECT_VIBE = ""
                                    }else{
                                        //5
                                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                        let navigate = storyboard.instantiateViewController(withIdentifier: "TTabBarViewController") as! TTabBarViewController
                                        let leftController = storyboard.instantiateViewController(withIdentifier: "LeftMenuViewController") as! LeftMenuViewController
                                        let slideMenuController = SlideMenuController(mainViewController: UINavigationController(rootViewController:navigate), leftMenuViewController: leftController)
                                        slideMenuController.delegate = leftController as? SlideMenuControllerDelegate
                                        UIApplication.shared.windows.first?.rootViewController = slideMenuController
                                        UIApplication.shared.windows.first?.makeKeyAndVisible()
                                        self.tabBarController?.tabBar.isUserInteractionEnabled = true
                                    }
                                }else{
                                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                    let navigate = storyboard.instantiateViewController(withIdentifier: "thirdTabBarVC") as! thirdTabBarVC
                                    let leftController = storyboard.instantiateViewController(withIdentifier: "LeftMenuViewController") as! LeftMenuViewController
                                    let slideMenuController = SlideMenuController(mainViewController: UINavigationController(rootViewController:navigate), leftMenuViewController: leftController)
                                    slideMenuController.delegate = leftController as? SlideMenuControllerDelegate
                                    UIApplication.shared.windows.first?.rootViewController = slideMenuController
                                    UIApplication.shared.windows.first?.makeKeyAndVisible()
                                    
                                    if !USER_VIBE.contains("Mini") &&  USER_VIBE.contains("Soul Love") && !USER_VIBE.contains("Tribe") {
                                        SELECT_VIBE = "Soul Love"
                                    }
                                    if !USER_VIBE.contains("Mini") &&  !USER_VIBE.contains("Soul Love") && USER_VIBE.contains("Tribe") {
                                        SELECT_VIBE = "Tribe"
                                    }
                                }
                            }
                        }else{
                            self.view.makeToast(message)
//                            DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
//                                self.navigationController?.popViewController(animated: true)
//                            }
                            if showIntentionVC.contains("Overall") && !showIntentionVC.contains("yearly") {
                                showIntentionVC = showIntentionVC.replacingOccurrences(of: "monthly", with: "")
                                DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "overAllIntentions") as! overAllIntentions
                                    self.navigationController?.pushViewController(vc, animated: true)
                                    showIntentionVC = showIntentionVC.replacingOccurrences(of: "Overall", with: "")
                                    print(showIntentionVC)
                                }
                            }else{
                                if !showIntentionVC.contains("Overall") && showIntentionVC.contains("yearly") {
                                    showIntentionVC = showIntentionVC.replacingOccurrences(of: "monthly", with: "")
                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "yearlyIntentionsVC") as! yearlyIntentionsVC
                                    self.navigationController?.pushViewController(vc, animated: true)
                                    showIntentionVC = showIntentionVC.replacingOccurrences(of: "yearly", with: "")
                                    print(showIntentionVC)
                                }else{
                                    DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
                                        let vc = self.storyboard?.instantiateViewController(identifier: "IntentionListVC") as! IntentionListVC
                                        vc.comeFromIntentions = "yes"
                                        self.navigationController?.pushViewController(vc, animated: true)
                                    }
                                }
                            }
                            
                        }
                    }
                    
                else {
                     self.view.makeToast(message)
                }
            }
       // }
        
    }
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        if text_View.textColor == UIColor.lightGray {
//            text_View.text = ""
//            text_View.textColor = UIColor.black
//        }
//    }
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if text_View.text.isEmpty {
//            text_View.text = "Write your answer here"
//            text_View.textColor = UIColor.lightGray
//        }
//    }
    
    func IntenstionAPI(Type:String!){
        let date = Date()
        let dateformat = DateFormatter()
        dateformat.dateFormat = "yyyy-MM-dd"
        let finaldate = dateformat.string(from: date ?? Date())
        let parameterDictionary = NSMutableDictionary()
        let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
        parameterDictionary.setValue("tribe123", forKey: "api_key")
        parameterDictionary.setValue(userID, forKey: "user_id")
        parameterDictionary.setValue(Type, forKey: "type")
        parameterDictionary.setValue(finaldate, forKey: "date")
        print(parameterDictionary)
        let methodName = "update_intension_list"
        DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""

            if status == "1" {
                self.view.makeToast(message)
            }
            else {
                self.view.makeToast(message)
            }
        }
}
    
    @IBAction func skipBtnAction(_ sender: Any) {
        if self.comesFromSignUp == "yes2" {
            self.IntenstionAPI(Type: "month")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
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
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let navigate = storyboard.instantiateViewController(withIdentifier: "SecondTabBarVC") as! SecondTabBarVC
                            let leftController = storyboard.instantiateViewController(withIdentifier: "LeftMenuViewController") as! LeftMenuViewController
                            let slideMenuController = SlideMenuController(mainViewController: UINavigationController(rootViewController:navigate), leftMenuViewController: leftController)
                            slideMenuController.delegate = leftController as? SlideMenuControllerDelegate
                            UIApplication.shared.windows.first?.rootViewController = slideMenuController
                            UIApplication.shared.windows.first?.makeKeyAndVisible()
                        self.tabBarController?.tabBar.isUserInteractionEnabled = true
                    }else{
                        //5
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let navigate = storyboard.instantiateViewController(withIdentifier: "TTabBarViewController") as! TTabBarViewController
                        let leftController = storyboard.instantiateViewController(withIdentifier: "LeftMenuViewController") as! LeftMenuViewController
                        let slideMenuController = SlideMenuController(mainViewController: UINavigationController(rootViewController:navigate), leftMenuViewController: leftController)
                        slideMenuController.delegate = leftController as? SlideMenuControllerDelegate
                        UIApplication.shared.windows.first?.rootViewController = slideMenuController
                        UIApplication.shared.windows.first?.makeKeyAndVisible()
                        self.tabBarController?.tabBar.isUserInteractionEnabled = true
                    }
                }else{
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let navigate = storyboard.instantiateViewController(withIdentifier: "thirdTabBarVC") as! thirdTabBarVC
                    let leftController = storyboard.instantiateViewController(withIdentifier: "LeftMenuViewController") as! LeftMenuViewController
                    let slideMenuController = SlideMenuController(mainViewController: UINavigationController(rootViewController:navigate), leftMenuViewController: leftController)
                    slideMenuController.delegate = leftController as? SlideMenuControllerDelegate
                    UIApplication.shared.windows.first?.rootViewController = slideMenuController
                    UIApplication.shared.windows.first?.makeKeyAndVisible()
                    
                    if !USER_VIBE.contains("Mini") &&  USER_VIBE.contains("Soul Love") && !USER_VIBE.contains("Tribe") {
                        SELECT_VIBE = "Soul Love"
                    }
                    if !USER_VIBE.contains("Mini") &&  !USER_VIBE.contains("Soul Love") && USER_VIBE.contains("Tribe") {
                        SELECT_VIBE = "Tribe"
                    }
                }
            }
        }else{
            let vc = self.storyboard?.instantiateViewController(identifier: "IntentionListVC") as! IntentionListVC
            vc.comeFromIntentions = "yes"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func saveBtnAction(_ sender: Any) {
        if self.text_View.text == "" {
            self.view.makeToast("Please fill your intentions")
        }else{
        self.optionView1.frame = self.view.frame
        self.optionView1.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.view.addSubview(self.optionView1)
        }
    }
    @IBAction func backMenu(_ sender: Any) {
        if self.comesFromSignUp == "yes2" {
            print(USER_VIBE)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
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
                        
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let navigate = storyboard.instantiateViewController(withIdentifier: "SecondTabBarVC") as! SecondTabBarVC
                            let leftController = storyboard.instantiateViewController(withIdentifier: "LeftMenuViewController") as! LeftMenuViewController
                            let slideMenuController = SlideMenuController(mainViewController: UINavigationController(rootViewController:navigate), leftMenuViewController: leftController)
                            slideMenuController.delegate = leftController as? SlideMenuControllerDelegate
                            UIApplication.shared.windows.first?.rootViewController = slideMenuController
                            UIApplication.shared.windows.first?.makeKeyAndVisible()
                        self.tabBarController?.tabBar.isUserInteractionEnabled = true
                    }else{
                        //5
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let navigate = storyboard.instantiateViewController(withIdentifier: "TTabBarViewController") as! TTabBarViewController
                        let leftController = storyboard.instantiateViewController(withIdentifier: "LeftMenuViewController") as! LeftMenuViewController
                        let slideMenuController = SlideMenuController(mainViewController: UINavigationController(rootViewController:navigate), leftMenuViewController: leftController)
                        slideMenuController.delegate = leftController as? SlideMenuControllerDelegate
                        UIApplication.shared.windows.first?.rootViewController = slideMenuController
                        UIApplication.shared.windows.first?.makeKeyAndVisible()
                        self.tabBarController?.tabBar.isUserInteractionEnabled = true
                    }
                }else{
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let navigate = storyboard.instantiateViewController(withIdentifier: "thirdTabBarVC") as! thirdTabBarVC
                    let leftController = storyboard.instantiateViewController(withIdentifier: "LeftMenuViewController") as! LeftMenuViewController
                    let slideMenuController = SlideMenuController(mainViewController: UINavigationController(rootViewController:navigate), leftMenuViewController: leftController)
                    slideMenuController.delegate = leftController as? SlideMenuControllerDelegate
                    UIApplication.shared.windows.first?.rootViewController = slideMenuController
                    UIApplication.shared.windows.first?.makeKeyAndVisible()
                    
                    if !USER_VIBE.contains("Mini") &&  USER_VIBE.contains("Soul Love") && !USER_VIBE.contains("Tribe") {
                        SELECT_VIBE = "Soul Love"
                    }
                    if !USER_VIBE.contains("Mini") &&  !USER_VIBE.contains("Soul Love") && USER_VIBE.contains("Tribe") {
                        SELECT_VIBE = "Tribe"
                    }
                }
            }
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
}
