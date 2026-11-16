//
//  SetProfilefinalVC.swift
//  DemoNew
//
//  Created by mac-9 on 02/07/21.
//

import UIKit

class SetProfilefinalVC: UIViewController {
    
    
    @IBOutlet weak var btn_sexuality1: UIButton!
    
    @IBOutlet weak var btn_sexuality2: UIButton!
    
    @IBOutlet weak var btn_sexuality3: UIButton!
    
    @IBOutlet weak var btn_sexuality4: UIButton!
    
    @IBOutlet weak var btn_sexuality5: UIButton!
    
    @IBOutlet weak var btn_sexuality6: UIButton!
    
    @IBOutlet weak var btn_sexuality7: UIButton!
    
    
    @IBOutlet weak var btn_relationship1: UIButton!
    
    @IBOutlet weak var btn_relationship3: UIButton!
    @IBOutlet weak var btn_relationship2: UIButton!
    
    
    @IBOutlet weak var minitribesex1: UIView!
    @IBOutlet weak var minitribesex2: UIView!
    @IBOutlet weak var minitribesex3: UIView!
    @IBOutlet weak var minitribesex4: UIView!
    @IBOutlet weak var minitribesex5: UIView!
    @IBOutlet weak var minitribesex6: UIView!
    @IBOutlet weak var minitribesex7: UIView!
    
    @IBOutlet weak var minitribereletion1: UIView!
    @IBOutlet weak var minitribereletion2: UIView!
    @IBOutlet weak var minitribereletion3: UIView!
    @IBOutlet weak var btnsave: UIButton!
    @IBOutlet weak var headerview: UIView!
    @IBOutlet weak var btnchk1: UIButton!
    @IBOutlet weak var btnchk2: UIButton!
    @IBOutlet weak var btnchk3: UIButton!
    @IBOutlet weak var btnchk4: UIButton!
    @IBOutlet weak var btnchk5: UIButton!
    @IBOutlet weak var btnchk6: UIButton!
    @IBOutlet weak var btnchk7: UIButton!
    @IBOutlet weak var btnchk8: UIButton!
    @IBOutlet weak var btnchk9: UIButton!
    @IBOutlet weak var btnchk10: UIButton!

    var vibe = ""
    
    var arr_my_sexuality : NSMutableArray = []
    var arr_my_relationshipStatus : NSMutableArray = []
    var arr_soul_gender : NSMutableArray = []
    var arr_soul_sexuality : NSMutableArray = []
    var arr_soul_relationshipGoal : NSMutableArray = []
    
    var arr_tribe_gender : NSMutableArray = []
    var arr_tribe_sexuality : NSMutableArray = []
    
    
    var arr_mini_tribe_relationshipStatus : NSMutableArray = []
    var arr_mini_tribe_sexuality : NSMutableArray = []
    
    
    var q1Soul = ""
    var q1Tribe = ""
    
    var comesFrom = ""
    var userData = [String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        headerview.layer.shadowOpacity = 0.5
        headerview.layer.shadowOffset = .zero
        headerview.layer.shadowRadius = 5
       
        minitribesex1.layer.cornerRadius = 5
        minitribesex1.layer.borderWidth = 1
        minitribesex1.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        minitribesex2.layer.cornerRadius = 5
        minitribesex2.layer.borderWidth = 1
        minitribesex2.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        minitribesex3.layer.cornerRadius = 5
        minitribesex3.layer.borderWidth = 1
        minitribesex3.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        minitribesex4.layer.cornerRadius = 5
        minitribesex4.layer.borderWidth = 1
        minitribesex4.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        minitribesex5.layer.cornerRadius = 5
        minitribesex5.layer.borderWidth = 1
        minitribesex5.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        minitribesex6.layer.cornerRadius = 5
        minitribesex6.layer.borderWidth = 1
        minitribesex6.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        minitribesex7.layer.cornerRadius = 5
        minitribesex7.layer.borderWidth = 1
        minitribesex7.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        minitribereletion1.layer.cornerRadius = 5
        minitribereletion1.layer.borderWidth = 1
        minitribereletion1.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        minitribereletion2.layer.cornerRadius = 5
        minitribereletion2.layer.borderWidth = 1
        minitribereletion2.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        minitribereletion3.layer.cornerRadius = 5
        minitribereletion3.layer.borderWidth = 1
        minitribereletion3.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        btnsave.layer.cornerRadius = 5
        btnsave.layer.borderWidth = 1
        btnsave.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        if comesFrom == "Edit"{
            setupData()
        }
        // Do any additional setup after loading the view.
    }
    
    
    
    func setupData(){
        let temp_myRelationshipStatus = (DataManager.getVal(userData["mini_tribe_relationship_status"]) as? String ?? "").components(separatedBy: ", ")
        let temp_mySexuality = (DataManager.getVal(userData["mini_tribe_sexuality"]) as? String ?? "").components(separatedBy: ", ")
     
          
        for str in temp_mySexuality{
            if str == "Straight"{
                minitribesex1.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
                minitribesex1.layer.borderWidth = 1
                btnchk1.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
                arr_mini_tribe_sexuality.add("Straight")
                btn_sexuality1.isSelected = true
                
            }else if str == "Gay"{
                minitribesex2.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
                minitribesex2.layer.borderWidth = 1
                btnchk2.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
                arr_mini_tribe_sexuality.add("Gay")
                btn_sexuality2.isSelected = true
            }else if str == "Bisexual"{
                minitribesex3.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
                minitribesex3.layer.borderWidth = 1
                btnchk3.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
                arr_mini_tribe_sexuality.add("Bisexual")
                btn_sexuality3.isSelected = true
            }else if str == "Queer"{
                minitribesex4.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
                minitribesex4.layer.borderWidth = 1
                btnchk4.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
                arr_mini_tribe_sexuality.add("Queer")
                btn_sexuality4.isSelected = true
            }else if str == "Questioning"{
                minitribesex5.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
                minitribesex5.layer.borderWidth = 1
                btnchk5.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
                arr_mini_tribe_sexuality.add("Questioning")
                btn_sexuality5.isSelected = true
            }else if str == "Asexual"{
                minitribesex6.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
                minitribesex6.layer.borderWidth = 1
                btnchk6.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
                arr_mini_tribe_sexuality.add("Asexual")
                btn_sexuality6.isSelected = true
            }else if str == "Other"{
                minitribesex7.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
                minitribesex7.layer.borderWidth = 1
                btnchk7.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
                arr_mini_tribe_sexuality.add("Other")
                btn_sexuality7.isSelected = true
            }
        }
        
        for str in temp_myRelationshipStatus{
            if str == "Single"{
                minitribereletion1.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
                minitribereletion1.layer.borderWidth = 1
                btnchk8.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
                arr_mini_tribe_relationshipStatus.add("Single")
                btn_relationship1.isSelected = true
            }else if str == "Married"{
                minitribereletion2.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
                minitribereletion2.layer.borderWidth = 1
                btnchk9.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
                arr_mini_tribe_relationshipStatus.add("Married")
                btn_relationship2.isSelected = true
            }else if str == "It's Complicated"{
                minitribereletion3.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
                minitribereletion3.layer.borderWidth = 1
                btnchk10.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
                arr_mini_tribe_relationshipStatus.add("It's Complicated")
                btn_relationship3.isSelected = true
            }
        }
    }
    
    
    @IBAction func btnback(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnsave(_ sender: Any) {
        if ValidationClass().ValidateProfileSetup4Form(self){
            
            basicFunctions.presentLoader()

            let parameterDictionary = NSMutableDictionary()
            parameterDictionary.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
            parameterDictionary.setValue(Config().api_key, forKey: "api_key")
            
            parameterDictionary.setValue(arr_my_sexuality.componentsJoined(by:", "), forKey: "soul_love_my_sexuality")
            parameterDictionary.setValue(arr_my_relationshipStatus.componentsJoined(by:", "), forKey: "soul_love_my_relationship_status")
            parameterDictionary.setValue(arr_soul_gender.componentsJoined(by:", "), forKey: "soul_love_my_prefer_gender")
            parameterDictionary.setValue(arr_soul_sexuality.componentsJoined(by:", "), forKey: "soul_love_my_prefer_sexuality")
            parameterDictionary.setValue(arr_soul_relationshipGoal.componentsJoined(by:", "), forKey: "relationship_looking_for_soul_love")
            parameterDictionary.setValue(q1Soul, forKey: "soul_love_QA")
            parameterDictionary.setValue(arr_tribe_gender.componentsJoined(by:", "), forKey: "tribe_gender")
            parameterDictionary.setValue(arr_tribe_sexuality.componentsJoined(by:", "), forKey: "tribe_sexuality")
            
            parameterDictionary.setValue(q1Tribe, forKey: "tribe_QA")
            parameterDictionary.setValue(arr_mini_tribe_sexuality.componentsJoined(by:", "), forKey: "mini_tribe_sexuality")
            parameterDictionary.setValue(arr_mini_tribe_relationshipStatus.componentsJoined(by:", "), forKey: "mini_tribe_relationship_status")
            
            
            if comesFrom == "Edit"{
                parameterDictionary.setValue("edit", forKey: "type")
            }else{
                parameterDictionary.setValue("add", forKey: "type")
            }
            
            print(parameterDictionary)

            let methodName = "update_form_three"

            DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
                let status  = DataManager.getVal(responseData?["status"]) as! String
                let message  = DataManager.getVal(responseData?["message"]) as! String

                if status == "1" {
                    self.view.makeToast(message)

                    DispatchQueue.main.asyncAfter(deadline: .now()+1.5, execute: {
                        if self.comesFrom == "Edit"{
                            
//                            self.navigationController?.popToRootViewController(animated: true)
//                            self.tabBarController?.selectedIndex = 4
                            
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

                        }else{
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "overAllIntentions") as! overAllIntentions
                            vc.comesFromSignUp = "yes"
                            self.navigationController?.pushViewController(vc, animated: true)
                            
//                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                            let navigate = storyboard.instantiateViewController(withIdentifier: "TTabBarViewController") as! TTabBarViewController
//                            let leftController = storyboard.instantiateViewController(withIdentifier: "LeftMenuViewController") as! LeftMenuViewController
//                            let slideMenuController = SlideMenuController(mainViewController: UINavigationController(rootViewController:navigate), leftMenuViewController: leftController)
//                            slideMenuController.delegate = leftController as? SlideMenuControllerDelegate
//                            UIApplication.shared.windows.first?.rootViewController = slideMenuController
//                            UIApplication.shared.windows.first?.makeKeyAndVisible()
                        }
                    })
                }
                else {
                    self.view.makeToast(message, duration: 2.0, position: .bottom, title: nil, image: nil, style: ToastManager.shared.style, completion: nil)
                }
//                self.removeSpinner()
                basicFunctions.stopLoading()
            }
        }
    }
    @IBAction func soullsexualtiy1(_ sender: UIButton) {
//        sender.isSelected = !sender.isSelected
//        if sender.isSelected{
//            minitribesex1.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
//            minitribesex1.layer.borderWidth = 1
//            btnchk1.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
//            arr_mini_tribe_sexuality.add("Straight")
//        }
//        else{
//            minitribesex1.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//            minitribesex1.layer.borderWidth = 1
//            btnchk1.setImage(UIImage(named: "black circle"), for: .normal)
//            arr_mini_tribe_sexuality.remove("Straight")
//        }
        selectedBtn(view: minitribesex1, btn: btnchk1)
        unSelectedBtn(view: minitribesex2, btn: btnchk2)
        unSelectedBtn(view: minitribesex3, btn: btnchk3)
        unSelectedBtn(view: minitribesex4, btn: btnchk4)
        unSelectedBtn(view: minitribesex5, btn: btnchk5)
        unSelectedBtn(view: minitribesex6, btn: btnchk6)
        unSelectedBtn(view: minitribesex7, btn: btnchk7)
        arr_my_sexuality.removeAllObjects()
        arr_my_sexuality.add("Straight")
    }
    @IBAction func soullsexualtiy2(_ sender: UIButton) {
//        sender.isSelected = !sender.isSelected
//        if sender.isSelected{
//            minitribesex2.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
//            minitribesex2.layer.borderWidth = 1
//            btnchk2.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
//            arr_mini_tribe_sexuality.add("Gay")
//        }
//        else{
//            minitribesex2.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//            minitribesex2.layer.borderWidth = 1
//            btnchk2.setImage(UIImage(named: "black circle"), for: .normal)
//            arr_mini_tribe_sexuality.remove("Gay")
//        }
        unSelectedBtn(view: minitribesex1, btn: btnchk1)
        selectedBtn(view: minitribesex2, btn: btnchk2)
        unSelectedBtn(view: minitribesex3, btn: btnchk3)
        unSelectedBtn(view: minitribesex4, btn: btnchk4)
        unSelectedBtn(view: minitribesex5, btn: btnchk5)
        unSelectedBtn(view: minitribesex6, btn: btnchk6)
        unSelectedBtn(view: minitribesex7, btn: btnchk7)
        arr_mini_tribe_sexuality.removeAllObjects()
        arr_mini_tribe_sexuality.add("Gay")
    }
    @IBAction func soullsexualtiy3(_ sender: UIButton) {
//        sender.isSelected = !sender.isSelected
//        if sender.isSelected{
//            minitribesex3.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
//            minitribesex3.layer.borderWidth = 1
//            btnchk3.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
//            arr_mini_tribe_sexuality.add("Bisexual")
//        }
//        else{
//            minitribesex3.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//            minitribesex3.layer.borderWidth = 1
//            btnchk3.setImage(UIImage(named: "black circle"), for: .normal)
//            arr_mini_tribe_sexuality.remove("Bisexual")
//        }
        unSelectedBtn(view: minitribesex1, btn: btnchk1)
        unSelectedBtn(view: minitribesex2, btn: btnchk2)
        selectedBtn(view: minitribesex3, btn: btnchk3)
        unSelectedBtn(view: minitribesex4, btn: btnchk4)
        unSelectedBtn(view: minitribesex5, btn: btnchk5)
        unSelectedBtn(view: minitribesex6, btn: btnchk6)
        unSelectedBtn(view: minitribesex7, btn: btnchk7)
        arr_mini_tribe_sexuality.removeAllObjects()
        arr_mini_tribe_sexuality.add("Bisexual")
    }
    @IBAction func soullsexualtiy4(_ sender: UIButton) {
//        sender.isSelected = !sender.isSelected
//        if sender.isSelected{
//            minitribesex4.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
//            minitribesex4.layer.borderWidth = 1
//            btnchk4.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
//            arr_mini_tribe_sexuality.add("Queer")
//        }
//        else{
//            minitribesex3.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//            minitribesex3.layer.borderWidth = 1
//            btnchk4.setImage(UIImage(named: "black circle"), for: .normal)
//            arr_mini_tribe_sexuality.remove("Queer")
//        }
        unSelectedBtn(view: minitribesex1, btn: btnchk1)
        unSelectedBtn(view: minitribesex2, btn: btnchk2)
        unSelectedBtn(view: minitribesex3, btn: btnchk3)
        selectedBtn(view: minitribesex4, btn: btnchk4)
        unSelectedBtn(view: minitribesex5, btn: btnchk5)
        unSelectedBtn(view: minitribesex6, btn: btnchk6)
        unSelectedBtn(view: minitribesex7, btn: btnchk7)
        arr_mini_tribe_sexuality.removeAllObjects()
        arr_mini_tribe_sexuality.add("Queer")
    }
    @IBAction func soullsexualtiy5(_ sender: UIButton) {
//        sender.isSelected = !sender.isSelected
//        if sender.isSelected{
//            minitribesex5.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
//            minitribesex5.layer.borderWidth = 1
//            btnchk5.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
//            arr_mini_tribe_sexuality.add("Questioning")
//        }
//        else{
//            minitribesex5.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//            minitribesex5.layer.borderWidth = 1
//            btnchk5.setImage(UIImage(named: "black circle"), for: .normal)
//            arr_mini_tribe_sexuality.remove("Questioning")
//        }
        unSelectedBtn(view: minitribesex1, btn: btnchk1)
        unSelectedBtn(view: minitribesex2, btn: btnchk2)
        unSelectedBtn(view: minitribesex3, btn: btnchk3)
        unSelectedBtn(view: minitribesex4, btn: btnchk4)
        selectedBtn(view: minitribesex5, btn: btnchk5)
        unSelectedBtn(view: minitribesex6, btn: btnchk6)
        unSelectedBtn(view: minitribesex7, btn: btnchk7)
        arr_mini_tribe_sexuality.removeAllObjects()
        arr_mini_tribe_sexuality.add("Questioning")
    }
    @IBAction func soullsexualtiy6(_ sender: UIButton) {
//        sender.isSelected = !sender.isSelected
//        if sender.isSelected{
//            minitribesex6.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
//            minitribesex6.layer.borderWidth = 1
//            btnchk6.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
//            arr_mini_tribe_sexuality.add("Asexual")
//        }
//        else{
//            minitribesex6.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//            minitribesex6.layer.borderWidth = 1
//            btnchk6.setImage(UIImage(named: "black circle"), for: .normal)
//            arr_mini_tribe_sexuality.remove("Asexual")
//        }
        unSelectedBtn(view: minitribesex1, btn: btnchk1)
        unSelectedBtn(view: minitribesex2, btn: btnchk2)
        unSelectedBtn(view: minitribesex3, btn: btnchk3)
        unSelectedBtn(view: minitribesex4, btn: btnchk4)
        unSelectedBtn(view: minitribesex5, btn: btnchk5)
        selectedBtn(view: minitribesex6, btn: btnchk6)
        unSelectedBtn(view: minitribesex7, btn: btnchk7)
        arr_mini_tribe_sexuality.removeAllObjects()
        arr_mini_tribe_sexuality.add("Asexual")
    }
    @IBAction func soullsexualtiy7(_ sender: UIButton) {
//        sender.isSelected = !sender.isSelected
//        if sender.isSelected{
//            minitribesex7.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
//            minitribesex7.layer.borderWidth = 1
//            btnchk7.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
//            arr_mini_tribe_sexuality.add("Other")
//        }
//        else{
//            minitribesex7.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//            minitribesex7.layer.borderWidth = 1
//            btnchk7.setImage(UIImage(named: "black circle"), for: .normal)
//            arr_mini_tribe_sexuality.remove("Other")
//        }
        unSelectedBtn(view: minitribesex1, btn: btnchk1)
        unSelectedBtn(view: minitribesex2, btn: btnchk2)
        unSelectedBtn(view: minitribesex3, btn: btnchk3)
        unSelectedBtn(view: minitribesex4, btn: btnchk4)
        unSelectedBtn(view: minitribesex5, btn: btnchk5)
        unSelectedBtn(view: minitribesex6, btn: btnchk6)
        selectedBtn(view: minitribesex7, btn: btnchk7)
        arr_mini_tribe_sexuality.removeAllObjects()
        arr_mini_tribe_sexuality.add("Other")
    }
    @IBAction func relation1(_ sender: UIButton) {
//        sender.isSelected = !sender.isSelected
//        if sender.isSelected{
//            minitribereletion1.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
//            minitribereletion1.layer.borderWidth = 1
//            btnchk8.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
//            arr_mini_tribe_relationshipStatus.add("Single")
//        }
//        else{
//            minitribereletion1.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//            minitribereletion1.layer.borderWidth = 1
//            btnchk8.setImage(UIImage(named: "black circle"), for: .normal)
//            arr_mini_tribe_relationshipStatus.remove("Single")
//        }
        selectedBtn(view: minitribereletion1, btn: btnchk8)
        unSelectedBtn(view: minitribereletion2, btn: btnchk9)
        unSelectedBtn(view: minitribereletion3, btn: btnchk10)
        arr_mini_tribe_relationshipStatus.removeAllObjects()
        arr_mini_tribe_relationshipStatus.add("Single")
    }
    @IBAction func relation2(_ sender: UIButton) {
//        sender.isSelected = !sender.isSelected
//        if sender.isSelected{
//        minitribereletion2.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
//        minitribereletion2.layer.borderWidth = 1
//        btnchk9.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
//        arr_mini_tribe_relationshipStatus.add("Married")
//    }
//    else{
//        minitribereletion2.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//        minitribereletion2.layer.borderWidth = 1
//        btnchk9.setImage(UIImage(named: "black circle"), for: .normal)
//        arr_mini_tribe_relationshipStatus.remove("Married")
//    }
        unSelectedBtn(view: minitribereletion1, btn: btnchk8)
        selectedBtn(view: minitribereletion2, btn: btnchk9)
        unSelectedBtn(view: minitribereletion3, btn: btnchk10)
        arr_mini_tribe_relationshipStatus.removeAllObjects()
        arr_mini_tribe_relationshipStatus.add("Married")
    }
    @IBAction func relation3(_ sender: UIButton) {
//        sender.isSelected = !sender.isSelected
//        if sender.isSelected{
//            minitribereletion3.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
//            minitribereletion3.layer.borderWidth = 1
//            btnchk10.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
//            arr_mini_tribe_relationshipStatus.add("It's Complicated")
//
//        } 
//        else{
//            minitribereletion3.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//            minitribereletion3.layer.borderWidth = 1
//            btnchk10.setImage(UIImage(named: "black circle"), for: .normal)
//            arr_mini_tribe_relationshipStatus.remove("It's Complicated")
//        }
        unSelectedBtn(view: minitribereletion1, btn: btnchk8)
        unSelectedBtn(view: minitribereletion2, btn: btnchk9)
        selectedBtn(view: minitribereletion3, btn: btnchk10)
        arr_mini_tribe_relationshipStatus.removeAllObjects()
        arr_mini_tribe_relationshipStatus.add("It's Complicated")
    }
    
    func selectedBtn(view: UIView, btn: UIButton) {
        
        view.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
        view.layer.borderWidth = 1
        btn.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
    }
    func unSelectedBtn(view: UIView, btn: UIButton) {
        
        view.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.layer.borderWidth = 1
        btn.setImage(UIImage(named: "black circle"), for: .normal)
    }
}
