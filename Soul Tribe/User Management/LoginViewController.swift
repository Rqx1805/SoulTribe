//
//  LoginViewController.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 04/06/21.
//

import UIKit
import KeychainSwift
import GoogleSignIn
import AuthenticationServices
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

var UserUIimageData: UIImage?
var UserUIimagString: String?
class LoginViewController: UIViewController,UITextFieldDelegate {
   
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var emailview: UIView!
    @IBOutlet weak var passwordview: UIView!
    @IBOutlet weak var invalidEmail: UILabel!
    @IBOutlet weak var wrongPassword: UILabel!
    @IBAction func checkbtnAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    let keychain = KeychainSwift()
    var appleemaill = ""
    var applename = ""
    var dataparse = [String:Any]()
    var dataparse1 = [String:Any]()
    var dataparse2 = [String:Any]()
    @IBOutlet weak var socialview:UIView!
    @IBOutlet weak var socialstackview:UIStackView!
    @IBOutlet weak var socialviewheightconst:NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        invalidEmail.isHidden = true
        wrongPassword.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        emailTxt.setLeftPaddingPoints(10)
        passwordTxt.setLeftPaddingPoints(10)
        self.navigationController?.isNavigationBarHidden = true

        emailview.layer.cornerRadius = 7
        emailview.layer.borderWidth = 1.2
        emailview.layer.borderColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0).cgColor
        
        passwordview.layer.cornerRadius = 7
        passwordview.layer.borderWidth = 1.2
        passwordview.layer.borderColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0).cgColor
        CheckSocialLoginAPI()
        // Do any additional setup after loading the view.
    }
    
    func CheckSocialLoginAPI(){
            let paraDict = NSMutableDictionary()
            paraDict.setValue(Config().api_key, forKey: "api_key")
            print(paraDict)
            let methodName = "social_status"
            DataManager.getAPIResponse(paraDict , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
                let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
                let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
                let social_status  = DataManager.getVal(responseData?["social_status"]) as? String ?? ""
                print(message)
                if status == "1" {
                    if social_status == "1"{
                        self.socialstackview.isHidden = false
                        self.socialviewheightconst.constant = 60
                    }else{
                        self.socialstackview.isHidden = true
                        self.socialviewheightconst.constant = 0
                    }
                }
                else {
                    print(message)
                    self.socialstackview.isHidden = true
                    self.socialviewheightconst.constant = 0
                }
            }
        }
    
    override func viewWillAppear(_ animated: Bool) {
        if DataManager.getVal(self.keychain.get("email_A")) as? String ?? "" != "" {
            emailTxt.text = (DataManager.getVal(self.keychain.get("email_A")) as? String ?? "")
            passwordTxt.text = (DataManager.getVal(self.keychain.get("password_A")) as? String ?? "")
            checkBtn.isSelected = true
        } else {
            passwordTxt.text = ""
            emailTxt.text = ""
            checkBtn.isSelected = false
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        self.invalidEmail.isHidden = true
        self.wrongPassword.isHidden = true
        
        return true
    }
    
    @IBAction func forgotPasswordBtnAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func termsBtnAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "WebVwViewController") as! WebVwViewController
        vc.urlStr = "https://soultribenow.com/terms"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func signInBtnAction(_ sender: Any) {
        self.invalidEmail.isHidden = true
        self.wrongPassword.isHidden = true
        self.view.endEditing(true)
        
        if ValidationClass().ValidateLoginForm(self){
            basicFunctions.presentLoader()
      
            let parameterDictionary = NSMutableDictionary()

            let deviceToken = DataManager.getVal(Config().AppUserDefaults.object(forKey: "dvcTocken") as? String) as? String ?? ""
            print("ppppppp \(deviceToken)")
            parameterDictionary.setValue(deviceToken, forKey: "device_token")
            parameterDictionary.setValue("2", forKey: "device_type")
            parameterDictionary.setValue(emailTxt.text ?? "", forKey: "email")
            parameterDictionary.setValue(passwordTxt.text ?? "", forKey: "password")
            parameterDictionary.setValue(Config().api_key, forKey: "api_key")
        
            print(parameterDictionary)

            let methodName = "login"
                   
            DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
                let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
                let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
                  
                if status == "1" {
                    
                    let data = DataManager.getVal(responseData?["data"]) as? [String:Any] ?? [:]
                    
                    USER_VIBE = DataManager.getVal(data["vibe"]) as? String ?? ""
                    Config().AppUserDefaults.setValue(USER_VIBE, forKey: "userVibe")
                    
                    let screen_val = DataManager.getVal(data["app_screen"]) as? String ?? ""
                        
                        print(data)
                    self.view.makeToast(message)
                        
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
                    
                    if self.checkBtn.isSelected == true {
                        self.keychain.set(self.passwordTxt.text ?? "", forKey: "password_A")
                        self.keychain.set(self.emailTxt.text ?? "", forKey: "email_A")
                    }else {
                        if (DataManager.getVal(Config().AppUserDefaults.value(forKey: "email_A")) as! String) != "" {
                                
                            self.keychain.delete("email_A")
                            self.keychain.delete("password_A")
                        }
                    }
                    if screen_val == "0"{
                        let vc = self.storyboard?.instantiateViewController(identifier: "LocationAccessVC") as! LocationAccessVC
                        self.navigationController?.pushViewController(vc, animated: true)
                    }else if screen_val == "1"{
                        let vc = self.storyboard?.instantiateViewController(identifier: "SetprofileVC") as! SetprofileVC
                        vc.comeFromLogInviewVC = true
                        vc.comesFrom = ""
                        self.navigationController?.pushViewController(vc, animated: true)
                    }else if screen_val == "2"{
                        let vc = self.storyboard?.instantiateViewController(identifier: "SetProfilestep2VC") as! SetProfilestep2VC
                        self.navigationController?.pushViewController(vc, animated: true)
                    }else if screen_val == "3"{
//                        let arr = (DataManager.getVal(data["vibe"]) as? String ?? "").components(separatedBy: ",")
                            
//                        if arr.contains("Soul Love") || arr.contains("Tribe"){
                            let vc = self.storyboard?.instantiateViewController(identifier: "SetProfilestep3VC") as! SetProfilestep3VC
                            vc.vibe = DataManager.getVal(data["vibe"]) as? String ?? ""
                            self.navigationController?.pushViewController(vc, animated: true)
//                        }
//                        else{
//                            let vc = self.storyboard?.instantiateViewController(identifier: "SetProfilefinalVC") as! SetProfilefinalVC
//                            self.navigationController?.pushViewController(vc, animated: true)
//                        }
                    }else if screen_val == "4"{
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
                                        navigate.selectedIndex = 2
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
                    }
                }else if status == "3" {
                    basicFunctions.stopLoading()
                    self.deactivateAlart()
                }
                else if status == "2"{
                    let data = DataManager.getVal(responseData?["data"]) as? [String:Any] ?? [:]
    
                    self.view.makeToast(message)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                        let vc = self.storyboard?.instantiateViewController(identifier: "VerficationViewController") as! VerficationViewController
                        vc.datatype = "1"
                        vc.userId = DataManager.getVal(data["id"]) as? String ?? ""
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
                else if status == "0"{
                    self.view.makeToast(message)
                    if message == "Invalid email" {
                        self.emailview.layer.borderColor = UIColor.red.cgColor
                        self.invalidEmail.isHidden = false
                        self.wrongPassword.isHidden = true
                    }
                    else if message == "Invalid password"{
                        self.passwordview.layer.borderColor = UIColor.red.cgColor
//                        self.passwordTxt.layer.borderWidth = 1
                        self.invalidEmail.isHidden = true
                        self.wrongPassword.isHidden = false
                    }
                }
                else{
                    self.view.makeToast(message)
                }
                basicFunctions.stopLoading()
            }
        }
    }

    @IBAction func facebookBtnAction(_ sender: Any) {
        handleFacebookLogin()
    }
    
    @IBAction func twitterBtnAction(_ sender: Any) {
        handleAppleIdRequest()
    }
    
    @IBAction func googleBtnAction(_ sender: Any) {
        googleSigninInit()
    }
    
    @IBAction func signUpBtnAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
   

}

extension LoginViewController{
    func handleFacebookLogin(){
        let loginManager = LoginManager()
        loginManager.logIn(permissions: [.publicProfile, .email], viewController: self, completion: { loginResult in
            switch loginResult {
            case .failed(let error):
                print("\(error)")
            case .cancelled:
                print("cancelled")
            case .success(let grantedPermissions, let declinedPermissions, _):
                print("\(grantedPermissions) \(declinedPermissions)")
                
                if grantedPermissions.contains(.email){
                    self.getFBUserData()
                }
            }
        })
    }
    
    
    func handleAppleIdRequest() {
        if #available(iOS 13.0, *) {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
            
        }else{
            self.view.makeToast(  Bundle.main.localizedString(forKey: "Pleaseupdateyourappleversiontouseapplesignin", value: nil, table: "Localizable"))
        }
    }
    
    
    func showTextInputPrompt(withMessage message: String,completionBlock: @escaping ((Bool, String?) -> Void)) {
        let prompt = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
          completionBlock(false, nil)
        }
        weak var weakPrompt = prompt
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
          guard let text = weakPrompt?.textFields?.first?.text else { return }
          completionBlock(true, text)
        }
        prompt.addTextField(configurationHandler: nil)
        prompt.addAction(cancelAction)
        prompt.addAction(okAction)
        present(prompt, animated: true, completion: nil)
    }
    
    func socialLogin(cred : AuthCredential,usr:GIDGoogleUser){
        Auth.auth().signIn(with: cred) { authResult, error in
            if let error = error {
                let isMFAEnabled = true
            
                let authError = error as NSError
                if isMFAEnabled, authError.code == AuthErrorCode.secondFactorRequired.rawValue {
                    // The user is a multi-factor user. Second factor challenge is required.
                    let resolver = authError.userInfo[AuthErrorUserInfoMultiFactorResolverKey] as! MultiFactorResolver
                    var displayNameString = ""
                    for tmpFactorInfo in resolver.hints {
                        displayNameString += tmpFactorInfo.displayName ?? ""
                        displayNameString += " "
                    }
            
            
                    self.showTextInputPrompt(withMessage: "Select factor to sign in\n\(displayNameString)", completionBlock: { userPressedOK, displayName in
                        var selectedHint: PhoneMultiFactorInfo?
                        for tmpFactorInfo in resolver.hints {
                            if displayName == tmpFactorInfo.displayName {
                                selectedHint = tmpFactorInfo as? PhoneMultiFactorInfo
                            }
                        }
                        PhoneAuthProvider.provider().verifyPhoneNumber(with: selectedHint!, uiDelegate: nil,multiFactorSession: resolver.session) { verificationID, error in
                            if error != nil {
                                print("Multi factor start sign in failed. Error: \(error.debugDescription)")
                            } else {
                                self.showTextInputPrompt(withMessage: "Verification code for \(selectedHint?.displayName ?? "")",completionBlock: { userPressedOK, verificationCode in
                                    let credential: PhoneAuthCredential? = PhoneAuthProvider.provider().credential(withVerificationID: verificationID!,verificationCode: verificationCode!)
                                    let assertion: MultiFactorAssertion? = PhoneMultiFactorGenerator.assertion(with: credential!)
                                    resolver.resolveSignIn(with: assertion!) { authResult, error in
                                        if error != nil {
                                            print("Multi factor finanlize sign in failed. Error:\(error.debugDescription)")
                                        } else {
                                            self.navigationController?.popViewController(animated: true)
                                        }
                                    }
                                }
                                )
                            }
                        }
                    }
                    )
                } else {
                    self.view.makeToast(error.localizedDescription)
                    return
                }
                // ...
                return
            }
        
        // User is signed in
            let googleId = DataManager.getVal(usr.userID) as? String ?? ""
        //        let email_id = DataManager.getVal(user.profile.email) as? String ?? ""
        //        let first_name = DataManager.getVal(user.profile.givenName) as? String ?? ""
        //        let last_name = DataManager.getVal(user.profile.familyName) as? String ?? ""
        
        guard let emailv = usr.profile?.email else { return }
        guard let imageUrl = usr.profile?.imageURL(withDimension: 400) else { return }
        print(imageUrl)
        //emailIdTxtFld.text = emailv
        
        var socialInfo : [String:String] = [:]
        socialInfo["email"] = emailv
        socialInfo["social_id"] = usr.userID
        socialInfo["social_type"] = "google"
        socialInfo["first_name"] = usr.profile?.givenName
        socialInfo["last_name"] = usr.profile?.familyName
        socialInfo["mobile_number"] = ""
        socialInfo["image"] = imageUrl.path
        print(imageUrl.path)
        self.dataparse1 = socialInfo
        self.api_socialLogin(info: socialInfo, type: "Google")
            
        }
    }
    
    func googleSigninInit() {
        let clientID = FirebaseApp.app()?.options.clientID ?? ""
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in
            if error != nil {
                return
            }
            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else {
                return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                   accessToken: authentication.accessToken)
            
            if user != nil {
                socialLogin(cred: credential, usr: user!)
            }else{
                Bundle.main.localizedString(forKey: "UnabletosigninwiththeaccountPleasetryagain", value: nil, table: "Localizable")
            }
        }
    }
    
    
    //MARK:- Facebook User Data
    func getFBUserData(){
        if((AccessToken.current) != nil){
            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completion: {(connection, result, error) -> Void in
                if error != nil{
                    print("FB error")
                    return
                }
                let fbLoginManager = LoginManager()
                fbLoginManager.logOut()
                print(result as Any)
                
                let fields = result as? [String:Any];
                self.FacebookLogin_API(data : fields ?? [:])
            })
        }
    }
    
    
    func FacebookLogin_API(data : [String:Any]){
        
//        let fullName = DataManager.getVal(data["name"]) as? String ?? ""
        let firstName = DataManager.getVal(data["first_name"]) as? String ?? ""
        let lastName = DataManager.getVal(data["last_name"]) as? String ?? ""
        let social_id = DataManager.getVal(data["id"]) as? String ?? ""
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
        self.dataparse = socialInfo
        self.api_socialLogin(info: socialInfo, type: "Fb")
        
    }
    
    func deactivateAlart() {
        let myAlert = UIAlertController(title: "Soul Tribe!", message:"Your account has been deactivated by an Admin. If you think this is a mistake, you can contact us.", preferredStyle: UIAlertController.Style.alert);
        let okAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler:nil)

        let sayhi = UIAlertAction(title: "Contact Admin", style: UIAlertAction.Style.default, handler:  { action in
            let whatsappURL = NSURL(string: "https://soultribenow.com/contact-us")
            if UIApplication.shared.canOpenURL(whatsappURL as! URL) {
                UIApplication.shared.open(whatsappURL as! URL, options: [:], completionHandler: { (Bool) in

                    })
                }
                    
                })

                // this action can add to more button
                myAlert.addAction(okAction);
                myAlert.addAction(sayhi);

        self.present(myAlert, animated: true, completion: nil)
    }
    
     
    
    
    func api_socialLogin(info : [String:Any], type: String){
          
        basicFunctions.presentLoader()

        let parameterDictionary = NSMutableDictionary()
        let deviceToken = DataManager.getVal(Config().AppUserDefaults.object(forKey: "dvcTocken") as? String) as? String ?? ""
        print("ppppppp \(deviceToken)")
        parameterDictionary.setValue(deviceToken, forKey: "device_token")
        parameterDictionary.setValue(DataManager.getVal(info["email"]) as? String ?? "", forKey: "email")
        parameterDictionary.setValue("\(DataManager.getVal(info["first_name"]) as? String ?? "") \(DataManager.getVal(info["last_name"]) as? String ?? "")", forKey: "name")
        parameterDictionary.setValue(DataManager.getVal(info["image"]) as? String ?? "", forKey: "profile_image")
        parameterDictionary.setValue(Config().api_key, forKey: "api_key")
        parameterDictionary.setValue("2", forKey: "device_type")
        let timeZone = TimeZone.current.identifier

        parameterDictionary.setValue(timeZone, forKey: "timezone")

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
                
                let passwords = DataManager.getVal(data["passwords"]) as? String ?? ""
                
               
                
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
                
                if self.checkBtn.isSelected == true {
                    self.keychain.set(self.passwordTxt.text ?? "", forKey: "password_A")
                    self.keychain.set(self.emailTxt.text ?? "", forKey: "email_A")
                }else {
                    if (DataManager.getVal(Config().AppUserDefaults.value(forKey: "email_A")) as! String) != "" {
                            
                        self.keychain.delete("email_A")
                        self.keychain.delete("password_A")
                    }
                }
                
                
                if passwords != "" {
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
                }else{
                    if type == "Fb" {
                        let vc  = self.storyboard?.instantiateViewController(withIdentifier: "SocialLoginPasswordVC") as! SocialLoginPasswordVC
                        vc.data = self.dataparse
                        vc.type = "Fb"
                        self.navigationController?.pushViewController(vc, animated: true)
                    }else if type == "Google" {
                        let vc  = self.storyboard?.instantiateViewController(withIdentifier: "SocialLoginPasswordVC") as! SocialLoginPasswordVC
                        vc.data = self.dataparse1
                        vc.type = "Google"
                        self.navigationController?.pushViewController(vc, animated: true)
                    }else{
                        let vc  = self.storyboard?.instantiateViewController(withIdentifier: "SocialLoginPasswordVC") as! SocialLoginPasswordVC
                        vc.data = self.dataparse2
                        vc.type = "apple"
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                   

                }
                 
             
            }else if status == "3" {
                basicFunctions.stopLoading()
                self.deactivateAlart()
            }
            else {
                self.view.makeToast(message, duration: 2.0, position: .bottom, title: nil, image: nil, style: ToastManager.shared.style, completion: nil)
            }
//                self.removeSpinner()
            basicFunctions.stopLoading()
        }
    }
}

extension LoginViewController : ASAuthorizationControllerDelegate{
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        switch authorization.credential {
            case let credentials as ASAuthorizationAppleIDCredential:
                DispatchQueue.main.async {

                    let appleId = credentials.user
                    print(appleId)
                    var appleUserFirstName = credentials.fullName?.givenName ?? ""
                    var appleUserLastName = credentials.fullName?.familyName ?? ""
                    var appleUserEmail = credentials.email ?? ""
                    
                    self.applename = appleUserFirstName + " " + appleUserLastName
                    self.appleemaill = appleUserEmail
                    Config().AppUserDefaults.setValue(appleId, forKey: "AppleToken")
                    if appleUserFirstName == "" {
                        appleUserFirstName = UserDefaults.standard.string(forKey: "AppleUserFirstName") ?? ""
                    }else{
                         Config().AppUserDefaults.setValue(appleUserFirstName, forKey: "AppleUserFirstName")
                    }
                    
                    if appleUserLastName == "" {
                        appleUserLastName = UserDefaults.standard.string(forKey: "AppleUserLastName") ?? ""
                    }else{
                        Config().AppUserDefaults.setValue(appleUserLastName, forKey: "AppleUserLastName")
                    }
                    
                    if appleUserEmail == "" {
                        appleUserEmail = UserDefaults.standard.string(forKey: "AppleUserEmail") ?? ""
                    }else{
                        Config().AppUserDefaults.setValue(appleUserEmail, forKey: "AppleUserEmail")
                    }
                    
                    var appleInfo : [String:String] = [:]
                    appleInfo["social_id"] = appleId
                    appleInfo["social_type"] = "apple"
                    appleInfo["email"] = appleUserEmail
                    appleInfo["first_name"] = appleUserFirstName
                    appleInfo["last_name"] = appleUserLastName
                    self.dataparse2 = appleInfo
                    self.api_socialLogin(info: appleInfo, type: "apple")
                   //apicall
                }

        case let credentials as ASPasswordCredential:
            DispatchQueue.main.async {

                let appleUsername = credentials.user
                print(appleUsername as Any)
                let applePassword = credentials.password
                print(applePassword as Any)
                //Write your code
                
                //apicall

            }

        default :
            let alert: UIAlertController = UIAlertController(title: "Apple Sign In", message: "Something went wrong with your Apple Sign In!", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

            self.present(alert, animated: true, completion: nil)
            break
        }
    }


    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error){
        
        let alert: UIAlertController = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


extension LoginViewController : ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}
