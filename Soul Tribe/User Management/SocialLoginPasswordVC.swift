//
//  SocialLoginPasswordVC.swift
//  Soul Tribe
//
//  Created by MAC-25 on 29/06/22.
//

import UIKit

class SocialLoginPasswordVC: UIViewController {

    @IBOutlet weak var newPassView: UIView!
    @IBOutlet weak var ReNewPassView: UIView!
    @IBOutlet weak var enternewpasaTxt: UITextField!
    @IBOutlet weak var reenterpassTxt: UITextField!
    var data = [String:Any]()
    var type = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        enternewpasaTxt.isSecureTextEntry = true
        reenterpassTxt.isSecureTextEntry = true
        enternewpasaTxt.setLeftPaddingPoints(10)
        reenterpassTxt.setLeftPaddingPoints(10)
        newPassView.layer.cornerRadius = 7
        newPassView.layer.borderWidth = 1.2
        newPassView.layer.borderColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0).cgColor
        
        ReNewPassView.layer.cornerRadius = 7
        ReNewPassView.layer.borderWidth = 1.2
        ReNewPassView.layer.borderColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0).cgColor
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    func FacebookLogin_API(data : [String:Any]){
        
//        let fullName = DataManager.getVal(data["name"]) as? String ?? ""
        let firstName = DataManager.getVal(data["first_name"]) as? String ?? ""
        let lastName = DataManager.getVal(data["last_name"]) as? String ?? ""
        let social_id = DataManager.getVal(data["social_id"]) as? String ?? ""
        let email = DataManager.getVal(data["email"]) as? String ?? ""
//        let facebookProfileUrl = "http://graph.facebook.com/\(social_id)/picture?type=large"
        
        let picDict = DataManager.getVal(data["picture"]) as? [String:Any] ?? [:]
        let urlDict = DataManager.getVal(picDict["data"]) as? [String:Any] ?? [:]
        let urlImg = DataManager.getVal(urlDict["url"]) as? String ?? ""
        
        
        var socialInfo : [String:String] = [:]
        socialInfo["email"] = email
        socialInfo["social_id"] = social_id
        socialInfo["social_type"] = "facebook"
        socialInfo["first_name"] = firstName
        socialInfo["last_name"] = lastName
        socialInfo["mobile_number"] = ""
        socialInfo["image"] = urlImg
        
        self.api_socialLogin(info: socialInfo, type: "Fb")
        
    }
    
    
    func api_socialLogin(info : [String:Any], type: String){
          
        basicFunctions.presentLoader()

        let parameterDictionary = NSMutableDictionary()
        
        parameterDictionary.setValue(DataManager.getVal(info["email"]) as? String ?? "", forKey: "email")
        parameterDictionary.setValue("\(DataManager.getVal(info["first_name"]) as? String ?? "") \(DataManager.getVal(info["last_name"]) as? String ?? "")", forKey: "name")
        parameterDictionary.setValue(DataManager.getVal(info["image"]) as? String ?? "", forKey: "profile_picture")
        parameterDictionary.setValue(Config().api_key, forKey: "api_key")
        parameterDictionary.setValue(enternewpasaTxt.text, forKey: "password")

        var methodName = ""
        
        if type == "Google"{
            parameterDictionary.setValue(DataManager.getVal(info["social_id"]) as? String ?? "", forKey: "google_id")
            methodName = "google_login"
        }else if type == "Fb"{
            parameterDictionary.setValue(DataManager.getVal(info["social_id"]) as? String ?? "", forKey: "facebook_id")
            methodName = "facebook_login"
        }else{
            parameterDictionary.setValue(DataManager.getVal(info["social_id"]) as? String ?? "", forKey: "apple_id")
            methodName = "apple_login"
        }
        
        print(parameterDictionary)
        
        DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as! String
            let message  = DataManager.getVal(responseData?["message"]) as! String

            if status == "1" {
               
                
                let data = DataManager.getVal(responseData?["data"]) as? [String:Any] ?? [:]
                let screen_val = DataManager.getVal(data["app_screen"]) as? String ?? ""
                 print(data)
                self.view.makeToast(message)
                
                
                USER_VIBE = DataManager.getVal(data["vibe"]) as? String ?? ""
                Config().AppUserDefaults.setValue(USER_VIBE, forKey: "userVibe")
                Config().AppUserDefaults.setValue(DataManager.getVal(data["id"]) as? String ?? "", forKey: "user_id")
                Config().AppUserDefaults.setValue(DataManager.getVal(data["name"]) as? String ?? "", forKey: "user_name")
                Config().AppUserDefaults.setValue(DataManager.getVal(data["email"]) as? String ?? "", forKey: "user_email")
                Config().AppUserDefaults.setValue(DataManager.getVal(data["profile_image"]) as? String ?? "", forKey: "user_image")
                
                let profileimg = DataManager.getVal(data["profile_image"]) as? String ?? ""
                
                if profileimg == ""  {
                    print("nil")
                }else{
                    if UserUIimagString ?? "" == UserDefaults.standard.value(forKey: "user_image") as? String  {
                        
                    }else {
                        UserUIimagString = UserDefaults.standard.value(forKey: "user_image") as? String
                        let urll = URL(string: Config().baseImageUrl + UserUIimagString!)!
                        let dataimg = try! Data(contentsOf: urll)
                        UserUIimageData = UIImage(data: dataimg)!
                    }
                }
                
                 
                if screen_val == "0"{
                    let vc = self.storyboard?.instantiateViewController(identifier: "LocationAccessVC") as! LocationAccessVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }else if screen_val == "1"{
                    let vc = self.storyboard?.instantiateViewController(identifier: "SetprofileVC") as! SetprofileVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }else if screen_val == "2"{
                    let vc = self.storyboard?.instantiateViewController(identifier: "SetProfilestep2VC") as! SetProfilestep2VC
                    self.navigationController?.pushViewController(vc, animated: true)
                }else if screen_val == "3"{
//                    let arr = (DataManager.getVal(data["vibe"]) as? String ?? "").components(separatedBy: ",")
//
//                    if arr.contains("Soul Love") || arr.contains("Tribe"){
                        let vc = self.storyboard?.instantiateViewController(identifier: "SetProfilestep3VC") as! SetProfilestep3VC
                        vc.vibe = DataManager.getVal(data["vibe"]) as? String ?? ""
                        self.navigationController?.pushViewController(vc, animated: true)
//                    }
//                    else{
//                        let vc = self.storyboard?.instantiateViewController(identifier: "SetProfilefinalVC") as! SetProfilefinalVC
//                        self.navigationController?.pushViewController(vc, animated: true)
//                    }
                }else if screen_val == "4"{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let navigate = storyboard.instantiateViewController(withIdentifier: "TTabBarViewController") as! TTabBarViewController
                        let leftController = storyboard.instantiateViewController(withIdentifier: "LeftMenuViewController") as! LeftMenuViewController
                        let slideMenuController = SlideMenuController(mainViewController: UINavigationController(rootViewController:navigate), leftMenuViewController: leftController)
                        slideMenuController.delegate = leftController as? SlideMenuControllerDelegate
                        UIApplication.shared.windows.first?.rootViewController = slideMenuController
                        UIApplication.shared.windows.first?.makeKeyAndVisible()
                    }
                }
            }
            else {
                self.view.makeToast(message, duration: 2.0, position: .bottom, title: nil, image: nil, style: ToastManager.shared.style, completion: nil)
            }
//                self.removeSpinner()
            basicFunctions.stopLoading()
        }
    }
    

    @IBAction func submitBtnAction(_ sender: Any) {
        
        if ValidationClass().ValidateResetSocialPasswordForm(self){
            if type == "Fb" {
                FacebookLogin_API(data: data)
            }else if type == "Google"{
                api_socialLogin(info: data, type: type)
            }else{
                api_socialLogin(info: data, type: type)
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
