//
//  HomeTabVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 07/06/21.
//

import UIKit
import Koloda
import SDWebImage

class SoulTribeTab1: UIViewController, SlideMenuControllerDelegate,SendThroughProtocol{
    
    func sendDataforCardSwip(swipe: String) {
        self.cardView.swipe(.left)
    }
    @IBOutlet weak var BuyPremiumPlanPopUp: UIView!
    @IBOutlet weak var BuyPremiumPlanPopUpPopUpCornerRadius: UIView!
    @IBOutlet weak var BuyPremiumPlanPopUpPopUp_UpgradeBtn: UIButton!
    @IBOutlet weak var BuyPremiumPlanPopUpPopUp_TitleTextLbl: UILabel!
    
    @IBOutlet weak var SnapsCountPopUp: UIView!
    @IBOutlet weak var SnapsCountPopUpCornerRadius: UIView!
    @IBOutlet weak var SnapsCountPopUp_CancelBtn: UIButton!
    
    @IBOutlet weak var IntentionsExpiredPopUp: UIView!
    @IBOutlet weak var IntentionsExpiredPopUpCornerRadius: UIView!
    @IBOutlet weak var IntentionsExpiredPopUp_UpgradeBtn: UIButton!
    @IBOutlet weak var IntentionsExpiredPopUp_TitleTextLbl: UILabel!
    @IBOutlet weak var IntentionsExpiredPopUp_TitleTextLbl2: UILabel!
    @IBOutlet weak var IntentionsExpiredPopUp_TitleTextLbl3: UILabel!
    @IBOutlet weak var IntentionsExpiredPopUp_TitleTextLbl4: UILabel!
    
    @IBOutlet weak var dailyLimitView: UIView!
    @IBOutlet weak var dailyLimitViewCornerRadius: UIView!
    @IBOutlet weak var dailyLimitView_CancelBtn: UIButton!
    @IBOutlet weak var dailyLimitView_UpgradeBtn: UIButton!
    
    @IBOutlet weak var SwipeMatchView: UIView!
    @IBOutlet weak var SwipeMatchViewCornerRadius: UIView!
    @IBOutlet weak var SwipeMatch_MessageBtn: UIButton!
    @IBOutlet weak var SwipeMatch_KeepSwipingBtn: UIButton!
    @IBOutlet weak var SwipeMatch_Image1: UIImageView!
    @IBOutlet weak var SwipeMatch_Image2: UIImageView!
    @IBOutlet weak var sparkVibeImage: UIImageView!
    @IBOutlet weak var matchlbl: UILabel!
    @IBOutlet weak var TopMatchLbl: UILabel!
    
    @IBOutlet weak var optionView1: UIView!
    @IBOutlet weak var optionView1CornerRadius: UIView!
    @IBOutlet weak var alphaView_SoulBtn: UIButton!
    @IBOutlet weak var alphaView_TribeBtn: UIButton!
    
    @IBOutlet weak var ad_View: UIView!
    @IBOutlet weak var ad_imgView: UIImageView!
    
    
  @IBOutlet weak var btnnext: UIButton!
  @IBOutlet weak var fitnessview: UIView!
  @IBOutlet weak var artsview: UIView!
  @IBOutlet weak var musicsview: UIView!
  @IBOutlet weak var shopingsview: UIView!
  @IBOutlet weak var alienview: UIView!
  @IBOutlet weak var sportsview: UIView!
  @IBOutlet weak var mainview: UIView!
  @IBOutlet weak var popupview: UIView!
  @IBOutlet weak var innerpopupvc: UIView!
  @IBOutlet weak var btnsoullove: UIButton!
  @IBOutlet weak var btntribe: UIButton!
  @IBOutlet weak var cardView: CustomKolodaView!
  @IBOutlet weak var topView: UIView!
  @IBOutlet weak var topOptionMenuView: UIView!
  @IBOutlet weak var HomeVibeBtn: UIButton!
  @IBOutlet weak var confirmBlockView: UIView!
  @IBOutlet weak var homeTopMenuBtn: UIButton!
    @IBOutlet weak var notificationBadgeLbl: UILabel!
    var adsrighturl = ""
    var kolodaCurrentIndexValue = Int()
    var dailySwipelimit = String()
  var lblimgView = UIView()
    var noDataImage = UIImageView()
    var noDataLbl = UILabel()
    var noDataView = UIView()
    var profileImageString = String()
    var hobbiesArray = [String]()
    var getproductImages = [NSDictionary]()
  var picturesArray = [String]()
  var receiverName = String()
  var receiverAddress = String()
    var snapsCount = String()
    var gradient = CAGradientLayer()
  var ageInt = Int()
  var CategorySelect = String()
  var profileDict = [NSDictionary]()
  var leftDrawerTransition:DrawerTransition!
  var left = LeftMenuViewController()
  var swipeUserID = Int()
  var changeRightSwipeBtnImage = String()
  var adCount = Int()
    var vw = UIView()
    
    var matchPopUpid = Int()
    var matchPopUpName = String()
    var matchPopUpRoomId = String()
    var matchPopUpImg = String()
    var checkopen = "0"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if premiumPlaStatus == 1 || premiumFreePlanStatus == 1 {
            self.BuyPremiumPlanPopUpPopUp_UpgradeBtn.setTitle("Start Your FREE 7-Day Trial Today!", for: .normal)
        }else{
            self.BuyPremiumPlanPopUpPopUp_UpgradeBtn.setTitle("Start Your FREE 7-Day Trial Today!", for: .normal)
        }
        
        BuyPremiumPlanPopUpPopUpCornerRadius.layer.cornerRadius = 8
        BuyPremiumPlanPopUpPopUp_UpgradeBtn.layer.cornerRadius = 8
        
        IntentionsExpiredPopUpCornerRadius.layer.cornerRadius = 8
        IntentionsExpiredPopUp_UpgradeBtn.layer.cornerRadius = 8
        
        adCount = 0
        getData(vibeType: SELECT_VIBE)
        dailyLimitViewCornerRadius.layer.cornerRadius = 8
        dailyLimitView_CancelBtn.layer.cornerRadius = 6
        dailyLimitView_CancelBtn.layer.borderWidth = 0.4
        dailyLimitView_CancelBtn.layer.borderColor = UIColor.lightGray.cgColor
        dailyLimitView_UpgradeBtn.layer.cornerRadius = 6
        
        SnapsCountPopUpCornerRadius.layer.cornerRadius = 6
        SnapsCountPopUp_CancelBtn.layer.cornerRadius = 6
        
        notificationBadgeLbl.layer.cornerRadius = notificationBadgeLbl.frame.height/2
        notificationBadgeLbl.layer.borderColor = UIColor.white.cgColor
        notificationBadgeLbl.layer.borderWidth = 0.7
        
        let img = UserDefaults.standard.value(forKey: "user_image") as? String ?? ""
        SwipeMatch_MessageBtn.layer.cornerRadius = 8
        SwipeMatch_KeepSwipingBtn.layer.cornerRadius = 8
        SwipeMatch_Image1.layer.cornerRadius = 8
        SwipeMatch_Image2.layer.cornerRadius = 8
        SwipeMatch_Image1.transform = CGAffineTransform(rotationAngle: CGFloat(-25))
        SwipeMatch_Image2.transform = CGAffineTransform(rotationAngle: CGFloat(25))
        changeRightSwipeBtnImage = "1"
        
//         let img = UserDefaults.standard.value(forKey: "user_image") as? String
//         let urll = URL(string: Config().baseImageUrl + img!)!
//         let data = try! Data(contentsOf: urll)
//         let image = UIImage(data: data)!
//
////         let resized = resizeImage(image: image, targetSize: CGSize(width: 30, height: 30))?.withRenderingMode(.alwaysOriginal)
//        let resized = image.circularImage(size: 30).withRenderingMode(.alwaysOriginal)
//         self.tabBarController?.tabBar.items![4].image = resized
//         self.tabBarController?.tabBar.items![4].selectedImage = resized
        
//        let resized = UserUIimageData?.circularImage(size: 30).withRenderingMode(.alwaysOriginal)
        let resized = UserUIimageData?.roundedWithStroke(width: 5).withRenderingMode(.alwaysOriginal)
         self.tabBarController?.tabBar.items![2].image = resized
         self.tabBarController?.tabBar.items![2].selectedImage = resized
        
        self.tabBarController?.tabBar.isUserInteractionEnabled = true
        self.optionView1CornerRadius.layer.cornerRadius = 5
        self.tabBarController?.navigationController?.navigationBar.isHidden = true
        topOptionMenuView.isHidden = true
        topOptionMenuView.layer.cornerRadius = 8
        cardView.countOfVisibleCards = 1
        cardView.delegate = self
        cardView.dataSource = self
        self.navigationController?.isNavigationBarHidden = true
        
        if SELECT_VIBE == "" {
            popupview.isHidden = false
            innerpopupvc.isHidden = false
        }else{
            popupview.isHidden = true
            innerpopupvc.isHidden = true
        }
        HomeVibeBtn.setTitle(SELECT_VIBE, for: .normal)
        print(USER_VIBE)
        let ra = "Mini Tribes"
        let newVibe = USER_VIBE.replacingOccurrences(of: ra, with: "Mini")
        if newVibe.contains("Mini") {
            if newVibe.contains("Mini") &&  !newVibe.contains("Soul Love") && newVibe.contains("Tribe"){
                popupview.isHidden = true
                innerpopupvc.isHidden = true
                SELECT_VIBE = "Tribe"
                self.HomeVibeBtn.setTitle("Tribe", for: .normal)
                self.homeTopMenuBtn.isHidden = true
            }else{
                
            }
        }
        if newVibe.contains("Soul Love") && !newVibe.contains("Mini") && newVibe.contains("Tribe"){
            //5
            if SELECT_VIBE == "" {
                popupview.isHidden = false
                innerpopupvc.isHidden = false
            }else{
                popupview.isHidden = true
                innerpopupvc.isHidden = true
            }
            self.homeTopMenuBtn.isHidden = false
        }
        if newVibe.contains("Soul Love") && newVibe.contains("Mini") && newVibe.contains("Tribe") {
            if SELECT_VIBE == "" {
                popupview.isHidden = false
                innerpopupvc.isHidden = false
            }else{
                popupview.isHidden = true
                innerpopupvc.isHidden = true
            }
            self.homeTopMenuBtn.isHidden = false
            
        }
        if newVibe.contains("Soul Love") && !newVibe.contains("Mini") && !newVibe.contains("Tribe") {
            popupview.isHidden = true
            innerpopupvc.isHidden = true
            SELECT_VIBE = "Soul Love"
            self.homeTopMenuBtn.isHidden = true
            self.HomeVibeBtn.setTitle("Soul Love", for: .normal)
            
        }
        if !newVibe.contains("Soul Love") && !USER_VIBE.contains("Mini") && newVibe.contains("Tribe") {
            popupview.isHidden = true
            innerpopupvc.isHidden = true
            SELECT_VIBE = "Tribe"
            self.homeTopMenuBtn.isHidden = true
            self.HomeVibeBtn.setTitle("Tribe", for: .normal)
        }
        if newVibe.contains("Soul Love") && USER_VIBE.contains("Mini") && !newVibe.contains("Tribe") {
            popupview.isHidden = true
            innerpopupvc.isHidden = true
            SELECT_VIBE = "Soul Love"
            self.homeTopMenuBtn.isHidden = true
            self.HomeVibeBtn.setTitle("Soul Love", for: .normal)
        }
        
        innerpopupvc.layer.cornerRadius = 8
        confirmBlockView.layer.cornerRadius = 8
        btnsoullove.layer.cornerRadius = 8
        btntribe.layer.cornerRadius = 8
        self.confirmBlockView.isHidden = true
        //innerpopupvc.frame = CGRect(x: 0, y: 0, width: view.frame.width * 1.2, height: view.frame.height * 1.2
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.SwipeAction(_ :)), name: Notification.Name("Swipe"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SwipeActionCross(_:)), name: Notification.Name("cross"), object: nil)
    }
    
    func get_profileAPI()  {

        let parameterDictionary = NSMutableDictionary()
        let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
        parameterDictionary.setValue("tribe123", forKey: "api_key")
        parameterDictionary.setValue(userID, forKey: "user_id")
        let timeZone = TimeZone.current.identifier

        parameterDictionary.setValue(timeZone, forKey: "timezone")
        print(parameterDictionary)
        let methodName = "get_profile"

        DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){ [](responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let user_logout_status  = DataManager.getVal(responseData?["user_logout_status"]) as? String ?? ""
            if status == "1" {
                let data = DataManager.getVal(responseData?["data"]) as? NSDictionary
                let lat = DataManager.getVal(data?["lat"]) as? String ?? ""
                let lng = DataManager.getVal(data?["lng"]) as? String ?? ""
                let city = DataManager.getVal(data?["city"]) as? String ?? ""
                let state = DataManager.getVal(data?["state"]) as? String ?? ""
                
                UserDefaults.standard.setValue(lat, forKey: "lati")
                UserDefaults.standard.setValue(lng, forKey: "longi")
                UserDefaults.standard.setValue(city, forKey: "city")
                UserDefaults.standard.setValue(state, forKey: "state")
                
                premiumPlaStatus = data?.value(forKey: "premium_plan_status") as? Int ?? 0
                premiumFreePlanStatus = data?.value(forKey: "premium_free_plan_status") as? Int ?? 0
                let emailNotificationStatus  = DataManager.getVal(data?["email_notification"]) as? String ?? ""
                let InAppNotificationStatus  = DataManager.getVal(data?["in_app_notification"]) as? String ?? ""
                UserDefaults.standard.setValue(emailNotificationStatus, forKey: "emailNotificationStatus")
                UserDefaults.standard.setValue(InAppNotificationStatus, forKey: "InAppNotificationStatus")
                USER_VIBE = data?.value(forKey: "vibe") as? String ?? ""
                Config().AppUserDefaults.setValue(USER_VIBE, forKey: "userVibe")
                if user_logout_status == "0" {
                    self.LogoutAPI()
                                }else{
                                    
                                }
            } else {
//                 self.view.makeToast(message)
                if user_logout_status == "0" {
                    self.LogoutAPI()
                }else{
                                    
            }
            }
        }
    }
    
    
    
    @IBAction func BuyPremiumPlanPopUpUpgradeBtnAction(_ sender: Any) {
        BuyPremiumPlanPopUp.removeFromSuperview()
        let navigate = storyboard?.instantiateViewController(withIdentifier: "MemberShipPlanVC") as! MemberShipPlanVC
//        navigate.comeFromProfile = "fromLikedVC"
        self.navigationController?.pushViewController(navigate, animated: true)
    }
    @IBAction func BuyPremiumPlanPopUpCancelBtnAction(_ sender: Any) {
        BuyPremiumPlanPopUp.removeFromSuperview()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if SELECT_VIBE == "" {
            SELECT_VIBE = "Soul Love"
        }
    }
    @IBAction func IntentionsExpiredPopUpUpgradeBtnAction(_ sender: Any) {
        IntentionsExpiredPopUp.removeFromSuperview()
        if self.IntentionsExpiredPopUp_TitleTextLbl2.text == "You made it through another month!" {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "monthlyIntentionsVC") as! monthlyIntentionsVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else if self.IntentionsExpiredPopUp_TitleTextLbl2.text == "What are you allowing in this year?" {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "yearlyIntentionsVC") as! yearlyIntentionsVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
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
    @IBAction func IntentionsExpiredPopUpCancelBtnAction(_ sender: Any) {
        if self.IntentionsExpiredPopUp_TitleTextLbl2.text == "You made it through another month!" {
            self.IntenstionAPI(Type: "month")
        }else if self.IntentionsExpiredPopUp_TitleTextLbl2.text == "What are you allowing in this year?" {
            self.IntenstionAPI(Type: "year")
        }
        IntentionsExpiredPopUp.removeFromSuperview()
    }
    @IBAction func dailyLimitViewUpgradeAction(_ sender: Any) {
        dailyLimitView.removeFromSuperview()
        let navigate = storyboard?.instantiateViewController(withIdentifier: "MemberShipPlanVC") as! MemberShipPlanVC
        self.navigationController?.pushViewController(navigate, animated: true)
    }
    @IBAction func dailyLimitViewCancelAction(_ sender: Any) {
        dailyLimitView.removeFromSuperview()
    }
    func ads_API(){
        
        let paraDict = NSMutableDictionary()
        paraDict.setValue(Config().api_key, forKey: "api_key")
        print(paraDict)
        
        let methodName = "get_ads_list"
        DataManager.getAPIResponse(paraDict , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
            print(message)
            if status == "1" {
                let data = DataManager.getVal(responseData?["data"]) as? NSDictionary ?? [:]
                let image = data.value(forKey: "image") as? String ?? ""
                self.ad_imgView.sd_setImage(with: URL(string: Config().baseImageUrl + image), completed: nil)
            }
            else {
            }
        }
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        UIBezierPath(
            roundedRect: rect,
            cornerRadius: newSize.height/2
            ).addClip()
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let iv = UIImageView(image: newImage)
        iv.layer.cornerRadius = iv.frame.size.width/2
        
        return newImage
    }
//
//    func roundedImage: UIImage {
//        let rect = CGRect(origin:CGPoint(x: 0, y: 0), size: self.size)
//        UIGraphicsBeginImageContextWithOptions(self.size, false, 1)
//        UIBezierPath(
//            roundedRect: rect,
//            cornerRadius: self.size.height
//            ).addClip()
//        self.draw(in: rect)
//        return UIGraphicsGetImageFromCurrentImageContext()!
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notificationBadgeLbl.isHidden = true
        HomeVibeBtn.setTitle(SELECT_VIBE, for: .normal)
        getData(vibeType: SELECT_VIBE)
        get_profileAPI()
        self.vw.removeFromSuperview()
        self.vw.isHidden = true
    }
    
    @IBAction func SwipeMatch_KeepSwiping(_ sender: Any) {
        self.SwipeMatchView.removeFromSuperview()
    }
    @IBAction func SwipeMatch_MessageAction(_ sender: Any) {
        self.SwipeMatchView.removeFromSuperview()
        let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
        
        let dict = self.profileDict[self.kolodaCurrentIndexValue]
        let swipeID = dict.value(forKey: "id") as! Int
        let name = dict.value(forKey: "name") as? String ?? ""
        let img = dict.value(forKey: "profile_image") as? String ?? ""
        let snapsCount1 = dict.value(forKey: "snaps_count") as? String ?? ""
        var roomId = ""
        let senderId = Int(swipeID)
        let userId = Int(userID)!
        if senderId < userId {
            roomId = "\(swipeID)-\(userID)"
        }else{
            roomId = "\(userID)-\(swipeID)"
           }
        
//        if premiumPlaStatus == 0 {
//            self.BuyPremiumPlanPopUpPopUp_TitleTextLbl.text = "Get access to this and other amazing features by becoming a VIP!"
//            self.BuyPremiumPlanPopUp.frame = self.view.frame
//            self.BuyPremiumPlanPopUp.backgroundColor = UIColor.black.withAlphaComponent(0.4)
//            self.view.addSubview(self.BuyPremiumPlanPopUp)
//        }else{
            let vc = self.storyboard?.instantiateViewController(identifier: "MessageVC") as! MessageVC
            vc.typeDirect = ""
            print(self.swipeUserID)
            vc.Come_chatUser_ID = String(swipeID)
            vc.socketType = "direct"
            vc.Come_userName = name
            vc.come_RoomID = roomId
            vc.snapsCount = snapsCount1
            vc.Come_user_profile_image = Config().baseImageUrl + img
            navigationController?.pushViewController(vc, animated: true)
//        }
    }
    @IBAction func SnapsCountBtnAction(_ sender: Any) {
        SnapsCountPopUp.removeFromSuperview()
    }
    @IBAction func HometopMenuAction(_ sender: Any) {
        if self.CategorySelect == "Soul Love" {
            self.alphaView_SoulBtn.setTitleColor(UIColor.systemBlue, for: .normal)
        }else{
            self.alphaView_SoulBtn.setTitleColor(UIColor.black, for: .normal)
        }
        if self.CategorySelect == "Tribe" {
            self.alphaView_TribeBtn.setTitleColor(UIColor.systemBlue, for: .normal)
        }else{
            self.alphaView_TribeBtn.setTitleColor(UIColor.black, for: .normal)
        }
        self.optionView1.frame = self.view.frame
        self.optionView1.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.view.addSubview(self.optionView1)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "hide"), object: nil)
        
//        self.topOptionMenuView.isHidden = !self.topOptionMenuView.isHidden
    }
    @IBAction func HometopMenuSoulTribeAction(_ sender: Any) {
//        self.alphaView_SoulBtn.setTitleColor(UIColor.systemBlue, for: .normal)
        self.optionView1.removeFromSuperview()
        self.topOptionMenuView.isHidden = true
        popupview.isHidden = true
        self.CategorySelect = "Soul Love"
        SELECT_VIBE = "Soul Love"
        self.HomeVibeBtn.setTitle("Soul Love", for: .normal)
        changeRightSwipeBtnImage = "Soul"
        self.getData(vibeType: self.CategorySelect)
        
        if SELECT_VIBE == "Tribe" {
            self.HomeVibeBtn.setTitle("Tribe", for: .normal)
            self.sparkVibeImage.image = UIImage(named: "HomeStar")
            self.matchlbl.text = "Keep the vibe alive and send a message!"
            self.TopMatchLbl.text = "It's a Vibe!"
        }else{
            self.HomeVibeBtn.setTitle("Soul Love", for: .normal)
            self.sparkVibeImage.image = UIImage(named: "heart")
            self.matchlbl.text = "Keep the spark alive and send a message!"
            self.TopMatchLbl.text = "It's a Match!"
        }
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeImgSoulLoveBtn"), object: nil)
    }
    @IBAction func HometopMenuTribeAction(_ sender: Any) {
//        self.alphaView_TribeBtn.setTitleColor(UIColor.systemBlue, for: .normal)
        self.optionView1.removeFromSuperview()
        self.topOptionMenuView.isHidden = true
        popupview.isHidden = true
        innerpopupvc.isHidden = true
        self.CategorySelect = "Tribe"
        SELECT_VIBE = "Tribe"
        self.HomeVibeBtn.setTitle("Tribe", for: .normal)
        changeRightSwipeBtnImage = "Tribe"
        self.getData(vibeType: self.CategorySelect)
        
        if SELECT_VIBE == "Tribe" {
            self.HomeVibeBtn.setTitle("Tribe", for: .normal)
            self.sparkVibeImage.image = UIImage(named: "HomeStar")
            self.matchlbl.text = "Keep the vibe alive and send a message!"
            self.TopMatchLbl.text = "It's a Vibe!"
        }else{
            self.HomeVibeBtn.setTitle("Soul Love", for: .normal)
            self.sparkVibeImage.image = UIImage(named: "heart")
            self.matchlbl.text = "Keep the spark alive and send a message!"
            self.TopMatchLbl.text = "It's a Match!"
        }
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeImgTribeBtn"), object: nil)
        
    }
    @IBAction func adView_cancelAction(_ sender: Any) {
        self.tabBarController?.tabBar.isHidden = false
        self.ad_View.removeFromSuperview()
    }
    @IBAction func btnnotification(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(identifier: "NotificationsVC") as! NotificationsVC
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func ConfirmBlock_Cancel(_ sender: Any) {
        self.confirmBlockView.isHidden = true
    }
    @IBAction func cancel1(_ sender: Any) {
        self.optionView1.removeFromSuperview()
    }
    @IBAction func show1(_ sender: Any) {
        
    }
    @IBAction func ConfirmBlock_Accept(_ sender: Any) {
        self.confirmBlockView.isHidden = true
        let tempVw = KolView()
        tempVw.menuoptionView.isHidden = true
        self.view.endEditing(true)
        let parameterDictionary = NSMutableDictionary()
        let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
       parameterDictionary.setValue("tribe123", forKey: "api_key")
       parameterDictionary.setValue(userID, forKey: "user_id")
       parameterDictionary.setValue("Tribe", forKey: "vibe")
        parameterDictionary.setValue(self.swipeUserID, forKey: "block_user_id")
       print(parameterDictionary)
        let methodName = "user_block"

        DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""

            if status == "1" {
                self.view.makeToast(message)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.getData(vibeType: SELECT_VIBE)
                }
//                self.cardView.swipe(.left)
                print("rr")
            }
            else {
//                 self.view.makeToast(message)
            }
        }
    }
    
    @IBAction func btnexploreuser(_ sender: Any) {
        if premiumPlaStatus == 1 || premiumFreePlanStatus == 1 {
            let vc = self.storyboard?.instantiateViewController(identifier: "LocationAccessVC") as! LocationAccessVC
            vc.comeFromHomeExplore = "y"
            navigationController?.pushViewController(vc, animated: true)
            
        }else{
            self.BuyPremiumPlanPopUpPopUp_TitleTextLbl.text = "This premium feature allows you to connect with users based on location and interests. Get access to this and other amazing features by becoming a VIP!"
            self.BuyPremiumPlanPopUp.frame = self.view.frame
            self.BuyPremiumPlanPopUp.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            self.view.addSubview(self.BuyPremiumPlanPopUp)
        }
    }
    
    @IBAction func sideMenuBtnAction(_ sender: Any) {
        self.slideMenuController()?.toggleLeft()
    }
    
    @IBAction func btnsoullove(_ sender: Any) {
        popupview.isHidden = true
        innerpopupvc.isHidden = true
        self.CategorySelect = "Soul Love"
        SELECT_VIBE = "Soul Love"
        self.HomeVibeBtn.setTitle("Soul Love", for: .normal)
        changeRightSwipeBtnImage = "Soul"
        self.getData(vibeType: self.CategorySelect)
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeImgSoulLoveBtn"), object: nil)
        self.tabBarController?.tabBar.isUserInteractionEnabled = true
//        self.slideMenuController()?.toggleLeft()
    }
    
    @IBAction func btntribe(_ sender: Any) {
        popupview.isHidden = true
        innerpopupvc.isHidden = true
        self.CategorySelect = "Tribe"
        SELECT_VIBE = "Tribe"
        self.HomeVibeBtn.setTitle("Tribe", for: .normal)
        changeRightSwipeBtnImage = "Tribe"
        self.getData(vibeType: self.CategorySelect)
//
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeImgTribeBtn"), object: nil)
        self.tabBarController?.tabBar.isUserInteractionEnabled = true
    }
    
    @objc func SwipeAction(_ pNotification: Notification) {
            
            if let extractInfo = pNotification.userInfo {
                let type = extractInfo["data"] as? String
                cardView.swipe(.right)
            }
        }
    @objc func SwipeActionCross(_ pNotification: Notification) {
            
            if let extractInfo = pNotification.userInfo {
                let type = extractInfo["data"] as? String
                cardView.swipe(.left)
            }
        }
    
    func setSideMenu() {
        self.leftDrawerTransition.presentDrawerViewController(animated: true)
    }
    
    //MARK: - Left drawer
    func setupLeftDrawer(_ controller: UIViewController) {
        
        self.leftDrawerTransition = DrawerTransition(target: controller, drawer: left)
        self.leftDrawerTransition.setPresentCompletion { print("left present...") }
        self.leftDrawerTransition.setDismissCompletion { print("left dismiss...") }
        self.leftDrawerTransition.edgeType = .left
        left.clickCellEvent { (indexpath) in
            
            //            if(indexpath.row == -1)
            //            {
            //                // NotificationCenter.default.post(name: Notification.Name("notifyMilesChange"), object: nil)
            //            }
            if(indexpath.row == 0){
               // let VC = self.storyboard?.instantiateViewController(withIdentifier: "TabBar") as! UITabBarController
               // self.navigationController?.pushViewController(VC, animated: true)
            }else if(indexpath.row == 1){
               // let vc = self.storyboard?.instantiateViewController(withIdentifier: "TermsConditionViewController") as! TermsConditionViewController
               // self.navigationController?.pushViewController(vc, animated: true)
            }else if(indexpath.row == 2) {
               // let vc = self.storyboard?.instantiateViewController(withIdentifier: "PrivacyPoliceVC") as! PrivacyPoliceVC
               // self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexpath.row == 3{
                //let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContactUsViewController") as! ContactUsViewController
               // self.navigationController?.pushViewController(vc, animated: true)
            }else if indexpath.row == 4{
               // let vc = self.storyboard?.instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController
              //  self.navigationController?.pushViewController(vc, animated: true)
            }else if indexpath.row == 5{
                //let vc = self.storyboard?.instantiateViewController(withIdentifier: "FAQViewController") as! FAQViewController
                //self.navigationController?.pushViewController(vc, animated: true)
            }else{
                
//                let nextview = LogoutPopUp.intitiateFromNib()
//                let model = BackModel()
//
//                nextview.buttonYesHandler = {
//                    let deafults = UserDefaults.standard
//                    deafults.removeObject(forKey: "UserIDAutologin")
//                    deafults.set("0", forKey: "Logoutstatus")
//                    deafults.synchronize()
//
//                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//                    self.navigationController?.pushViewController(vc, animated: true)
//                    model.closewithAnimation()
//                }
//
//                nextview.buttonNoHandler = {
//                    model.closewithAnimation()
//                }
                
               // model.showLogout(view: nextview)
            }
            self.leftDrawerTransition.dismissDrawerViewController()
        }
    }
    
    @IBAction func btngotonxt(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "hide"), object: nil)
        let vc = self.storyboard?.instantiateViewController(identifier: "ProfileController") as! ProfileController
        vc.swipeUserID = self.swipeUserID
        vc.picturesArray = self.picturesArray
        vc.vibeType = self.CategorySelect
        navigationController?.pushViewController(vc, animated: true)
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
    
    func getData(vibeType: String){
        
        self.vw.removeFromSuperview()
        self.vw.isHidden = true
        
         self.view.endEditing(true)

         let parameterDictionary = NSMutableDictionary()
        let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
        parameterDictionary.setValue("tribe123", forKey: "api_key")
        parameterDictionary.setValue(userID, forKey: "user_id")
        parameterDictionary.setValue(vibeType, forKey: "vibe")
        
        
        let lati = UserDefaults.standard.string(forKey: "lati")
        let longi = UserDefaults.standard.string(forKey: "longi")
        let city = UserDefaults.standard.string(forKey: "city")
        let state = UserDefaults.standard.string(forKey: "state")
        
        parameterDictionary.setValue(lati, forKey: "latitude")
        parameterDictionary.setValue(longi, forKey: "longitude")
        parameterDictionary.setValue(state, forKey: "state")
        parameterDictionary.setValue(city, forKey: "city")
        print(parameterDictionary)
        let methodName = "get_users_list"

         DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
             let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
             let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
             let user_logout_status  = DataManager.getVal(responseData?["user_logout_status"]) as? String ?? ""
             if status == "1" {
                 self.profileDict.removeAll()
                 self.cardView.reloadData()
                 self.profileDict = DataManager.getVal(responseData?["data"]) as! [NSDictionary]
                 SoulLoveSwipeLimitCount = Int(DataManager.getVal(responseData?["userSoulLoveSwipeCount"]) as? String ?? "")!
                 tribeSwipeLimitCount = Int(DataManager.getVal(responseData?["userTribeSwipeCount"]) as? String ?? "")!
                 let countBadge = DataManager.getVal(responseData?["notification_count"]) as? String ?? ""
                 self.notificationBadgeLbl.text = DataManager.getVal(responseData?["notification_count"]) as? String ?? ""
                 let monthlyStatus = DataManager.getVal(responseData?["monthly_status"]) as? String ?? ""
                 let yearlyStatus = DataManager.getVal(responseData?["yearly_status"]) as? String ?? ""
                 
                 if countBadge == "0"{
                     self.notificationBadgeLbl.isHidden = true
                 }else{
                     self.notificationBadgeLbl.isHidden = false
                 }
                 
                 likedNotificationCount = DataManager.getVal(responseData?["liked_count"]) as? String ?? ""
                 print("Profile :::: ;::::::::::: ::\(self.profileDict.count)")
//                 if self.changeRightSwipeBtnImage == "Soul" {
//                     NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeImgSoulLoveBtn"), object: nil)
//                 }else{
//                     NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeImgTribeBtn"), object: nil)
//                 }
                 if self.profileDict.count == 0 {
                     
                     self.vw = UIView(frame: CGRect(x: 0, y: 100, width: self.view.bounds.size.width, height: self.view.bounds.size.height - 200))
                     let img = UIImageView(frame: CGRect(x: self.vw.frame.size.width/2-60, y: self.vw.frame.size.height/2-60, width: 120, height: 120))
                     img.image = UIImage(named: "starNew")!
                     let lbl = UILabel(frame: CGRect(x: 0, y: img.frame.height - 40, width: self.vw.frame.size.width, height: self.vw.frame.size.height))
                     lbl.text = "Attraction in process!"
                     lbl.textColor = UIColor.black
                     lbl.font = UIFont(name: "Open Sans", size: 14)
                     lbl.textAlignment = .center
                     self.vw.addSubview(img)
                     self.vw.addSubview(lbl)
                    
                     self.vw.isHidden = false
                     
                     self.view.addSubview(self.vw)
                     
//                     self.noDataView.isHidden = false
//                     self.noDataView = UIView()
//                     self.noDataView.frame = CGRect(x: 0, y: 0, width: self.topView.bounds.size.width, height: self.topView.bounds.size.height)
//                     self.noDataImage = UIImageView()
//                     self.noDataImage.setImage(UIImage(named: "FullStar")!)
//                     self.noDataImage.frame = CGRect(x: self.noDataView.frame.size.width/2-40, y: self.noDataView.frame.size.height/2-40, width: 80, height: 80)
//                     self.noDataLbl.frame = CGRect(x: 0, y: self.noDataImage.frame.height + -15, width: self.topView.bounds.size.width, height: self.topView.bounds.size.height)
////                     let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: self.noDataImage.frame.height + -15, width: self.topView.bounds.size.width, height: self.topView.bounds.size.height))
//                     self.noDataLbl.text = "Attraction in Process!"
//                     self.noDataLbl.textColor = UIColor.black
//                     self.noDataLbl.textAlignment = .center
//
//                     self.noDataView.addSubview(self.noDataImage)
//                     self.noDataView.addSubview(self.noDataLbl)
//                     self.topView.addSubview(self.noDataView)
                 }else{
                     var pro = NSDictionary()
                     pro = self.profileDict[0]
                     
                     
                     
                     let idSender = pro.value(forKey: "id") as? Int ?? 0
                     let img = pro.value(forKey: "profile_image") as? String ?? ""
                     let nam = pro.value(forKey: "name") as? String ?? ""
                     
                     let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
                     var roomId = ""
                     let senderId = Int(idSender)
                     let userId = Int(userID)!
                     if senderId < userId {
                         roomId = "\(idSender)-\(SELECT_VIBE)-\(userID)"
                     }else{
                         roomId = "\(userID)-\(SELECT_VIBE)-\(idSender)"
                         }
                     self.matchPopUpid = idSender
                     self.matchPopUpImg = img
                     self.matchPopUpName = nam
                     self.matchPopUpRoomId = roomId
                     print(roomId)
                     self.vw.removeFromSuperview()
                     self.vw.isHidden = true
//                     print("hide ==========::::::::::::::::")
//                     self.noDataImage.image = UIImage(named: "")
//                     self.noDataImage.isHidden = true
//                     self.noDataLbl.text = ""
                 }
                 let dateFormatter = DateFormatter()
                 let dateFormatter1 = DateFormatter()
                 let date = NSDate()
                 dateFormatter.dateFormat = "dd"
                 dateFormatter1.dateFormat = "yyyy"
                 print(dateFormatter.string(from: date as Date)) // 2015-11-01
                 let firstdate  = dateFormatter.string(from: date as Date)
                 let firstyear  = dateFormatter1.string(from: date as Date)
                 if monthlyStatus == "0" {
                         self.IntentionsExpiredPopUp_TitleTextLbl.text = "Woohooo!!"
                         self.IntentionsExpiredPopUp_TitleTextLbl2.text = "You made it through another month!"
                         self.IntentionsExpiredPopUp_TitleTextLbl3.text = "Celebrate your wins and set new intentions for the month ahead."
                         self.IntentionsExpiredPopUp_TitleTextLbl4.text = "Remember, anything is possible!"
                         self.IntentionsExpiredPopUp.frame = self.view.frame
                         self.IntentionsExpiredPopUp.backgroundColor = UIColor.black.withAlphaComponent(0.4)
                         self.view.addSubview(self.IntentionsExpiredPopUp)
                         self.checkopen = "1"
                 }else{
                     self.IntentionsExpiredPopUp.removeFromSuperview()
                     self.checkopen = "0"
                 }
                 
                 if self.checkopen == "1" {
                     if yearlyStatus == "0"{
                             self.IntentionsExpiredPopUp_TitleTextLbl.text = "Happy New Year!"
                             self.IntentionsExpiredPopUp_TitleTextLbl2.text = "What are you allowing in this year?"
                             self.IntentionsExpiredPopUp_TitleTextLbl3.text = "Remember, as the creator of your reality you can be, do & have all your desire and more!"
                             self.IntentionsExpiredPopUp_TitleTextLbl4.text = "Dream big!"
                             self.IntentionsExpiredPopUp.frame = self.view.frame
                             self.IntentionsExpiredPopUp.backgroundColor = UIColor.black.withAlphaComponent(0.4)
                             self.view.addSubview(self.IntentionsExpiredPopUp)
                         
                     }else{
                         if self.checkopen == "1" {
                             
                         }else{
                             self.IntentionsExpiredPopUp.removeFromSuperview()
                         }
                         
                     }
                 }else{
                     if yearlyStatus == "0"{
                             self.IntentionsExpiredPopUp_TitleTextLbl.text = "Happy New Year!"
                             self.IntentionsExpiredPopUp_TitleTextLbl2.text = "What are you allowing in this year?"
                             self.IntentionsExpiredPopUp_TitleTextLbl3.text = "Remember, as the creator of your reality you can be, do & have all your desire and more!"
                             self.IntentionsExpiredPopUp_TitleTextLbl4.text = "Dream big!"
                             self.IntentionsExpiredPopUp.frame = self.view.frame
                             self.IntentionsExpiredPopUp.backgroundColor = UIColor.black.withAlphaComponent(0.4)
                             self.view.addSubview(self.IntentionsExpiredPopUp)
                         
                     }else{
                         self.IntentionsExpiredPopUp.removeFromSuperview()
                     }
                 }
                 
                 self.cardView.reloadData()
                 if user_logout_status == "0" {
                     self.LogoutAPI()
                                 }else{
                                     
                                 }
             }
             else {
//                 self.view.makeToast(message)
                 if user_logout_status == "0" {
                     self.LogoutAPI()
                                 }else{
                                     
                                 }
             }
         }
     }
    
    func RightSwipeAdsAPI(ads_id: Int, type: String){
             self.view.endEditing(true)

             let parameterDictionary = NSMutableDictionary()
            let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
            parameterDictionary.setValue("tribe123", forKey: "api_key")
            parameterDictionary.setValue(userID, forKey: "user_id")
            parameterDictionary.setValue(ads_id, forKey: "ads_id")
            parameterDictionary.setValue(type, forKey: "type")
            print(parameterDictionary)
             let methodName = "ads_view"

             DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
                 let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
                 let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
                 if status == "1" {
                     let url = URL(string: self.adsrighturl)

                     if UIApplication.shared.canOpenURL(url!) {
                         if #available(iOS 10.0, *) {
                              UIApplication.shared.open(url!, options: [:], completionHandler: { (success) in

                              })
                         } else {
                             UIApplication.shared.openURL(url!)
                         }
                     }
                 }
                 else {
                 }
             }
         }
        
        func LeftSwipeAdsAPI(ads_id: Int, type: String){
             self.view.endEditing(true)

             let parameterDictionary = NSMutableDictionary()
            let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
            parameterDictionary.setValue("tribe123", forKey: "api_key")
            parameterDictionary.setValue(userID, forKey: "user_id")
            parameterDictionary.setValue(ads_id, forKey: "ads_id")
            parameterDictionary.setValue(type, forKey: "type")
            print(parameterDictionary)
             let methodName = "ads_view"

             DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
                 let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
                 let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
                 if status == "1" {
                    
                 }
                 else {
                 }
             }
         }
    func RightSwipeAPI(SwipeUserId: Int, type: String,vibe: String,Role:String){
         self.view.endEditing(true)

         let parameterDictionary = NSMutableDictionary()
        let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
        parameterDictionary.setValue("tribe123", forKey: "api_key")
        parameterDictionary.setValue(userID, forKey: "user_id")
        parameterDictionary.setValue(SELECT_VIBE, forKey: "vibe")
        parameterDictionary.setValue(SwipeUserId, forKey: "swipe_user_id")
        parameterDictionary.setValue(type, forKey: "type")
        parameterDictionary.setValue(Role, forKey: "role")
        print(parameterDictionary)
         let methodName = "user_swipe"

         DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
             let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
             let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
             let user_logout_status  = DataManager.getVal(responseData?["user_logout_status"]) as? String ?? ""
             if status == "1" {
                 
                 let data = DataManager.getVal(responseData?["data"]) as? NSDictionary ?? [:]
                 let matchCount = data.value(forKey: "is_friend") as? Int ?? 0
                 tribeSwipeLimitCount = data.value(forKey: "userTribeSwipeCount") as? Int ?? 0
                 SoulLoveSwipeLimitCount = data.value(forKey: "userSoulLoveSwipeCount") as? Int ?? 0
                 let img = data.value(forKey: "swipe_user_profile_image") as? String ?? ""
                 let vibeStatus = data.value(forKey: "vibe") as? String ?? ""
                 self.SwipeMatch_Image1.sd_setImage(with: URL(string: Config().baseImageUrl + img), placeholderImage: UIImage(named: "default_image"))
                 
                 if matchCount == 1 {
                     if vibeStatus == "Tribe" {
                         self.sparkVibeImage.image = UIImage(named: "HomeStar")
                         self.matchlbl.text = "Keep the vibe going and send a message!"
                         self.TopMatchLbl.text = "It's a Vibe!"
                     }else{
                         self.sparkVibeImage.image = UIImage(named: "heart")
                         self.matchlbl.text = "Keep the spark alive and send a message!"
                         self.TopMatchLbl.text = "It's a Match!"
                     }
                     self.SwipeMatchView.frame = self.view.frame
                     self.SwipeMatchView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
                    self.view.addSubview(self.SwipeMatchView)
                     
                 }
                 print("rr")
                 if user_logout_status == "0" {
                     self.LogoutAPI()
                                 }else{
                                     
                                 }
             }else if status == "2"{
                 
                 self.dailySwipelimit = "expire"
                 if user_logout_status == "0" {
                     self.LogoutAPI()
                                 }else{
                                     
                                 }
             }
             else {
//                 self.view.makeToast(message)
                 if user_logout_status == "0" {
                     self.LogoutAPI()
                                 }else{
                                     
                                 }
             }
         }
     }
    @objc func ShowMenuOptionView(){
        let tempVw = KolView()
        if tempVw.menuoptionView.isHidden {
            tempVw.menuoptionView.isHidden = false
        }else{
            tempVw.menuoptionView.isHidden = true
        }
    }
    @objc func menuOptionReportBtnAction(){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "hide"), object: nil)
        let dict = self.profileDict[self.kolodaCurrentIndexValue]
        let swipeID = dict.value(forKey: "id") as! Int
        let name = dict.value(forKey: "name") as? String ?? ""
        let img = dict.value(forKey: "profile_image") as? String ?? ""
        let add = "\(dict.value(forKey: "city") as? String ?? "")" + ", " + "\(dict.value(forKey: "state") as? String ?? "")"
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReportPopUpVC") as! ReportPopUpVC
        vc.GetSwipeUserID = swipeID
        vc.getUserName = name
        vc.GetAddress = add
        vc.GetImageStr = img
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func menuOptionBlockUserBtnAction(){
        self.confirmBlockView.isHidden = false
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "hide"), object: nil)
    }
    @objc func menuOptionViewProfileBtnAction(){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "hide"), object: nil)
        let tempVw = KolView()
        tempVw.menuoptionView.isHidden = true
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileController") as! ProfileController
        vc.swipeUserID = self.swipeUserID
        vc.picturesArray = self.picturesArray
        vc.vibeType = self.CategorySelect
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func BtnLeftSwipeAction(){
        self.cardView.swipe(.left)
    }
    @objc func readMoreAdsDescription(){
        let adsView = AdsKolView()
//        if adsView.readMore.currentTitle == "Read more" {
//            adsView.descriptionLbl.numberOfLines = 0
//            //adsView.readMore.setTitle("Show less", for: .normal)
//        }else{
            adsView.descriptionLbl.numberOfLines = 3
           // adsView.readMore.setTitle("Read more", for: .normal)
       // }
    }
    @objc func BtnRightSwipeAction(){
        self.cardView.swipe(.right)
    }
    @objc func ImageClicked1(_ sender : UITapGestureRecognizer) {
        
        let actionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
                    
                }
                actionSheetController.addAction(cancelAction)
            let nearto = UIAlertAction(title: "View profile picture", style: .default) { action -> Void in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ExpandedImageViewController") as! ExpandedImageViewController
                 vc.urlStr = self.profileImageString
                 vc.shouldPrefix = true
                self.navigationController?.pushViewController(vc, animated: true)
        //                self.ChatMessageDeleteAPI(room: self.come_RoomID)
                }
                actionSheetController.addAction(nearto)
            let mostlike = UIAlertAction(title: "View Journey", style: .default) { action -> Void in
                if self.snapsCount == "0" {
                    self.view.makeToast("This user has no recent Journey posts. To add to your Soul’s Journey, click the link in your profile.")
//                    self.SnapsCountPopUp.frame = self.view.frame
//                    self.SnapsCountPopUp.backgroundColor = UIColor.black.withAlphaComponent(0.4)
//                    self.view.addSubview(self.SnapsCountPopUp)
                }else{
                    let vc1 = SB_instaStory.instantiateViewController(withIdentifier: "PresentStoryViewController") as! PresentStoryViewController
                    vc1.comeUserID = "\(self.swipeUserID)"
                    vc1.modalPresentationStyle = .fullScreen
                    self.navigationController?.present(vc1, animated: true, completion: nil)
                }
                }
        if self.snapsCount == "0" {
           
            mostlike.setValue(UIColor.lightGray, forKey: "titleTextColor")
        }else{
            mostlike.setValue(UIColor.systemBlue, forKey: "titleTextColor")
        }
                actionSheetController.addAction(mostlike)
            
                actionSheetController.popoverPresentationController?.sourceView = sender as? UIView
                
                self.present(actionSheetController, animated: true, completion: nil)
        
        print("click")
        print(self.swipeUserID)

    }
}
@available(iOS 13.0, *)
extension SoulTribeTab1: KolodaViewDataSource {
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .fast
    }
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return self.profileDict.count
    }
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        self.vw.isHidden = true
        self.vw.removeFromSuperview()
        self.picturesArray.removeAll()
        self.hobbiesArray.removeAll()
        print(profileDict.count)
        let dict = self.profileDict[index]
        let type = dict.value(forKey: "type") as? String ?? ""
        if type == "ads" {
            let adsView = AdsKolView()
            adsView.layer.cornerRadius = 20
            adsView.adsImageView.layer.cornerRadius = 20
            let img = dict.value(forKey: "image") as? String ?? ""
            let Des = dict.value(forKey: "description") as? String ?? ""
            adsView.descriptionLbl.text = Des
            Config().setimage(image_url: Config().baseImageUrl + img, image_name: adsView.adsImageView)
            adsView.adstitleLbl.text = dict.value(forKey: "title") as? String ?? ""
            adsView.descriptionView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
            print(Des.count)
//            if Des.count >= 250 {
//                adsView.readMore.isHidden = false
//                adsView.readMoreBtnHeightConstant.constant = 25
//            }else{
//                adsView.readMore.isHidden = true
//                adsView.readMoreBtnHeightConstant.constant = 0
//            }
            adsView.learnMoreBtn.addTarget(self, action: #selector(BtnRightSwipeAction), for: .touchUpInside)
            //adsView.readMore.addTarget(self, action: #selector(readMoreAdsDescription), for: .touchUpInside)
            adsView.rightSwipe.addTarget(self, action: #selector(BtnRightSwipeAction), for: .touchUpInside)
            adsView.leftSwipe.addTarget(self, action: #selector(BtnLeftSwipeAction), for: .touchUpInside)
            
            return adsView
        }else{
            let tempVw = KolView()
            if SELECT_VIBE == "Soul Love" {
                tempVw.BtnRightSwipe.setImage(UIImage(named: "heart"), for: .normal)
            }else{
                tempVw.BtnRightSwipe.setImage(UIImage(named: "HomeStar"), for: .normal)
            }
            tempVw.picturesArray.removeAll()
            tempVw.hobbiesArray.removeAll()
    //        tempVw.dropShadow()
    //        self.cardView.dropShadow()
            tempVw.layer.cornerRadius = 20
            self.cardView.layer.cornerRadius = 20
            koloda.layer.cornerRadius = 20
            self.topView.layer.cornerRadius = 20
            tempVw.greyView.layer.cornerRadius = 20
            tempVw.topUserView.clipsToBounds = true
            tempVw.topUserView.layer.cornerRadius = 8
            tempVw.topUserView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
            tempVw.userImgRoundView.layer.cornerRadius = tempVw.userImgRoundView.frame.height/2
            tempVw.userImg.layer.borderWidth = 2
            tempVw.userImg.layer.borderColor = UIColor.white.cgColor
    //        tempVw.topUserView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 8)
    //        tempVw.contentView.layer.cornerRadius = 20
    //        tempVw.mainView.layer.cornerRadius = 20
    //        tempVw.scrollView.layer.cornerRadius = 20
    //        tempVw.ageLbl.layer.cornerRadius = 10
    //        tempVw.matchLbl.layer.cornerRadius = 10
    //        tempVw.superLikeBtnTop.isHidden = true
           
    //        if profileDataArray.count == 1 {
    //            if index == 1 {
    //                cardView.countOfVisibleCards = 0
    //            }else{
    //                cardView.countOfVisibleCards = 1
    //            }
    //        }else{
    //            if index ==  addcount-1 {
    //                cardView.countOfVisibleCards = 0
    //                ind = index+1
    //            }else{
    //                cardView.countOfVisibleCards = 1
    //            }
    //        }

    //        if ind == profileDataArray.count {
    //            cardView.isHidden = true
    ////                self.SwipeView.isHidden = true
    //            self.NoDataLbl.isHidden = false
    //            self.NoDataImage.isHidden = false
    //        }else{
    //            cardView.isHidden = false
    ////                self.SwipeView.isHidden = true
    //            self.NoDataLbl.isHidden = true
    //            self.NoDataImage.isHidden = true
    //        }
            let dis = DataManager.getVal(dict["distance"]) as? String ?? ""
            //dict.value(forKey: "search_distance") as? String ?? ""
            
            self.snapsCount = DataManager.getVal(dict["snaps_count"]) as! String
            if self.snapsCount == "0" {
                self.gradient.removeFromSuperlayer()
            tempVw.userImgRoundView.layer.backgroundColor = UIColor.white.cgColor
            }else{
                gradient.cornerRadius = tempVw.userImgRoundView.layer.cornerRadius
                gradient.frame = tempVw.userImgRoundView.frame
                gradient.colors = [UIColor(red: 0.42, green: 0.39, blue: 1.00, alpha: 1.00).cgColor,UIColor(red: 0.05, green: 0.23, blue: 0.66, alpha: 1.00).cgColor,UIColor(red: 0.10, green: 0.55, blue: 0.65, alpha: 1.00).cgColor,UIColor(red: 0.14, green: 0.90, blue: 0.71, alpha: 1.00).cgColor]
                tempVw.userImgRoundView.layer.insertSublayer(gradient, at: 0)
                gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
                gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
                gradient.frame = CGRect(x: 0.0, y: 0.0, width: tempVw.userImgRoundView.frame.size.width, height: tempVw.userImgRoundView.frame.size.height)
            }
            
            let disStr = Float(dis) ?? 0.0
            let fff = Int(disStr)
            tempVw.distanceLbl.text = "\(fff)" + " " + "Mi"
            self.receiverAddress = "\(dict.value(forKey: "city") as! String)" + ", " + "\(dict.value(forKey: "state") as! String)"
            self.receiverName = dict.value(forKey: "name") as! String
            self.profileImageString = dict.value(forKey: "profile_image") as? String ?? ""
            let firstImpresssion = dict.value(forKey: "first_impression") as? String
            let hobbiesStr = dict.value(forKey: "hobbies") as? String
    //        let result = hobbiesStr!.filter { !$0.isWhitespace }
            self.swipeUserID = dict.value(forKey: "id") as! Int
            self.hobbiesArray = hobbiesStr!.components(separatedBy: ", ")
            
            if self.hobbiesArray.count == 1 {
                self.hobbiesArray = hobbiesStr!.components(separatedBy: ",")
            }else{
                self.hobbiesArray = hobbiesStr!.components(separatedBy: ", ")
            }
            tempVw.userImg.sd_setImage(with: URL(string: Config().baseImageUrl + self.profileImageString), completed: nil)
            self.ageInt = dict.value(forKey: "age") as! Int
            tempVw.ageLbl.text = String(self.ageInt)
            tempVw.userName.text = self.receiverName
            tempVw.cityBtn.setTitle(" \(self.receiverAddress)", for: .normal)
            tempVw.firstImpressionLbl.text = firstImpresssion
            self.getproductImages = dict.value(forKey: "getProductImages") as? [NSDictionary] ?? [[:]]
            for i in 0..<self.getproductImages.count{
                let dict1 = getproductImages[i]
                let images = dict1.value(forKey: "images") as? String
                self.picturesArray.append(images!)
            }
            tempVw.picturesArray = self.picturesArray
            tempVw.hobbiesArray = self.hobbiesArray
         //   ["Fitness","Music","Shopping","Aliens","Art","Sport","Fitness","Music","Shopping","Aliens"]
            
            tempVw.menuOptionReportBtn.addTarget(self, action: #selector(menuOptionReportBtnAction), for: .touchUpInside)
            tempVw.menuOptionBlockUserBtn.addTarget(self, action: #selector(menuOptionBlockUserBtnAction), for: .touchUpInside)
            tempVw.menuOptionViewProfileBtn.addTarget(self, action: #selector(menuOptionViewProfileBtnAction), for: .touchUpInside)
    //        tempVw.ClickonOptionViewBtn.addTarget(self, action: #selector(ShowMenuOptionView), for: .touchUpInside)
            tempVw.bottomViewProfileBtn.addTarget(self, action: #selector(menuOptionViewProfileBtnAction), for: .touchUpInside)
            tempVw.BtnLeftSwipe.addTarget(self, action: #selector(BtnLeftSwipeAction), for: .touchUpInside)
            tempVw.BtnRightSwipe.addTarget(self, action: #selector(BtnRightSwipeAction), for: .touchUpInside)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(ImageClicked1(_:)))
            tempVw.userImgRoundView.isUserInteractionEnabled = true
            tempVw.userImgRoundView.addGestureRecognizer(tap)
            
            tempVw.imageCollectionView.reloadData()
            tempVw.hobbiesCollectionView.reloadData()
            tempVw.pageControllerRightConstraint.constant = -CGFloat(self.picturesArray.count * 8)
            return tempVw
        }
       
    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return Bundle.main.loadNibNamed("CustomOverlayView", owner: self, options: nil)?[0] as? OverlayView
    }
}

@available(iOS 13.0, *)
extension SoulTribeTab1: KolodaViewDelegate {
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
//        cardView.resetCurrentCardIndex()
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
//        UIApplication.shared.openURL(URL(string: "https://yalantis.com/")!)
    }
    
    func kolodaShouldApplyAppearAnimation(_ koloda: KolodaView) -> Bool {
        return true
    }
    
    func kolodaShouldMoveBackgroundCard(_ koloda: KolodaView) -> Bool {
        return false
    }
    
    func kolodaShouldTransparentizeNextCard(_ koloda: KolodaView) -> Bool {
        return true
    }
    
//    func koloda(kolodaBackgroundCardAnimation koloda: KolodaView) -> POPPropertyAnimation? {
//        let animation = POPSpringAnimation(propertyNamed: kPOPViewFrame)
//        animation?.springBounciness = frameAnimationSpringBounciness
//        animation?.springSpeed = frameAnimationSpringSpeed
//        return animation
//    }
    func koloda(_ koloda: KolodaView, allowedDirectionsForIndex index: Int) -> [SwipeResultDirection]{
        return [.left,.topLeft,.bottomLeft,.right,.topRight,.bottomRight,.up]
    }
    func koloda(_ koloda: KolodaView, shouldDragCardAt index: Int) -> Bool {
//        print("dd")
//        self.lblimgView.isHidden = false
//        self.lblimgView.frame = CGRect(x: 0, y: 0, width: topView.frame.width, height: topView.frame.height)
////        self.lblimgView.backgroundColor = UIColor.darkGray
//
//        let img = UIImageView()
//        img.setImage(UIImage(named: "swipeSpart")!)
////        img.center = self.lblimgView.center
////        img.center.x = self.lblimgView.center.x
////        img.center.y = self.lblimgView.center.y
//        img.frame = CGRect(x: self.topView.frame.width/2 - 30, y: self.topView.frame.height/2 - 25, width: 60, height: 60)
//
//        let lbl = UILabel()
//        lbl.text = "Spark!"
//        lbl.textColor = UIColor.lightGray
//        lbl.frame = CGRect(x: self.topView.frame.width/2 - 30, y: img.frame.height/2 + 10, width: 60, height: 15)
//
//        self.lblimgView.addSubview(img)
//        self.lblimgView.addSubview(lbl)
//        koloda.addSubview(self.lblimgView)
        return true
    }
//    func kolodaPanBegan(_ koloda: KolodaView, card: DraggableCardView) {
//        print("ll")
//    }
//    func kolodaPanFinished(_ koloda: KolodaView, card: DraggableCardView) {
//        print("end")
////        self.lblimgView.isHidden = true
//    }
//    func koloda(_ koloda: KolodaView, draggedCardWithPercentage finishPercentage: CGFloat, in direction: SwipeResultDirection) {
//        print("ff")
//    }
    func koloda(_ koloda: KolodaView, shouldSwipeCardAt index: Int, in direction: SwipeResultDirection) -> Bool{
        if direction == .left || direction == .topLeft || direction == .bottomLeft{
         
//            if SELECT_VIBE == "Soul Love" {
//                if SoulLoveSwipeLimitCount >= 5 {
//                    self.BuyPremiumPlanPopUpPopUp_TitleTextLbl.text = "Your Swipe limit for the day has been reached. Come back tomorrow for more attraction power or upgrade for unlimited swipes!"
//                    self.BuyPremiumPlanPopUp.frame = self.view.frame
//                    self.BuyPremiumPlanPopUp.backgroundColor = UIColor.black.withAlphaComponent(0.4)
//                    self.view.addSubview(self.BuyPremiumPlanPopUp)
//                    return false
//                }else{
                        return true
//                }
//            }else{
//                if tribeSwipeLimitCount >= 5 {
//                    self.BuyPremiumPlanPopUpPopUp_TitleTextLbl.text = "Your Swipe limit for the day has been reached. Come back tomorrow for more attraction power or upgrade for unlimited swipes!"
//                    self.BuyPremiumPlanPopUp.frame = self.view.frame
//                    self.BuyPremiumPlanPopUp.backgroundColor = UIColor.black.withAlphaComponent(0.4)
//                    self.view.addSubview(self.BuyPremiumPlanPopUp)
//                    return false
//                }else{
//                    if self.adCount == 5 {
//                        ads_API()
//                        self.tabBarController?.tabBar.isHidden = true
//                         self.ad_View.frame = self.view.frame
//                        self.ad_View.backgroundColor = UIColor.white.withAlphaComponent(1)
//                        self.view.addSubview(self.ad_View)
//                        self.adCount = 0
//                        return false
//                    }else{
//                        return true
//                    }
//                }
//            }
            
        }else if direction == .up {
            return false
        }else if direction == .right {
            adCount += 1
            if SELECT_VIBE == "Soul Love" {
                if premiumPlaStatus == 1 || premiumFreePlanStatus == 1 {
                    return true
                }else{
                    if SoulLoveSwipeLimitCount >= 10 {
                        self.BuyPremiumPlanPopUpPopUp_UpgradeBtn.setTitle("Start Your FREE 7-Day Trial Today!", for: .normal)
                        self.BuyPremiumPlanPopUpPopUp_TitleTextLbl.text = "Your Swipe limit for the day has been reached. Come back tomorrow for more attraction power or upgrade for unlimited swipes!"
                        self.BuyPremiumPlanPopUp.frame = self.view.frame
                        self.BuyPremiumPlanPopUp.backgroundColor = UIColor.black.withAlphaComponent(0.4)
                        self.view.addSubview(self.BuyPremiumPlanPopUp)
                        return false
                    }else{
                        return true
                    }
                }
            }else{
                if premiumPlaStatus == 1 || premiumFreePlanStatus == 1{
                    return true
                }else{
                    if tribeSwipeLimitCount >= 10 {
                        self.BuyPremiumPlanPopUpPopUp_UpgradeBtn.setTitle("Start Your FREE 7-Day Trial Today!", for: .normal)
                        self.BuyPremiumPlanPopUpPopUp_TitleTextLbl.text = "Your Swipe limit for the day has been reached. Come back tomorrow for more attraction power or upgrade for unlimited swipes!"
                        self.BuyPremiumPlanPopUp.frame = self.view.frame
                        self.BuyPremiumPlanPopUp.backgroundColor = UIColor.black.withAlphaComponent(0.4)
                        self.view.addSubview(self.BuyPremiumPlanPopUp)
                        return false
                    }else{
                        return true
                    }
                }
        }
        }
        else{
            return false
        }
    }
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection){

        if direction == .left || direction == .topLeft || direction == .bottomLeft{
            self.kolodaCurrentIndexValue = index
            let dict = self.profileDict[index]
            let type = dict.value(forKey: "type") as? String ?? ""
            if type == "ads" {
                let adsid = dict.value(forKey: "id") as? Int ?? 0
                 self.LeftSwipeAdsAPI(ads_id: adsid, type: "reject")
//               let linkUrl = dict.value(forKey: "link") as? String ?? ""
//                let url = URL(string: linkUrl)
//                if UIApplication.shared.canOpenURL(url!) {
//                    if #available(iOS 10.0, *) {
//                         UIApplication.shared.open(url!, options: [:], completionHandler: { (success) in
//
//                         })
//                    } else {
//                        UIApplication.shared.openURL(url!)
//                    }
//                }
            }else{
                let swipeID = dict.value(forKey: "id") as! Int
                let name = dict.value(forKey: "name") as? String ?? ""
                let type = dict.value(forKey: "type") as? String ?? ""
                print(swipeID)
                print(name)
                print(self.profileDict.count)
                print(index)
                self.RightSwipeAPI(SwipeUserId: swipeID, type: "reject", vibe: self.CategorySelect, Role: type)
                
                if self.profileDict.count - 1 == index {
                    self.vw = UIView(frame: CGRect(x: 0, y: 100, width: self.view.bounds.size.width, height: self.view.bounds.size.height - 200))
                    let img = UIImageView(frame: CGRect(x: self.vw.frame.size.width/2-60, y: self.vw.frame.size.height/2-60, width: 120, height: 120))
                    img.image = UIImage(named: "starNew")!
                    let lbl = UILabel(frame: CGRect(x: 0, y: img.frame.height - 40, width: self.vw.frame.size.width, height: self.vw.frame.size.height))
                    lbl.text = "Attraction in process!"
                    lbl.textColor = UIColor.black
                    lbl.font = UIFont(name: "Open Sans", size: 15)
                    lbl.textAlignment = .center
                    self.vw.addSubview(img)
                    self.vw.addSubview(lbl)
                   
                    self.vw.isHidden = false
                    
                    self.view.addSubview(self.vw)
                }else{
                    self.vw.removeFromSuperview()
                    self.vw.isHidden = true
                }
            }
//            self.recieverId = DataManager.getVal(self.swipeUserId[0]) as? String ?? ""
//            self.recieverName = DataManager.getVal(self.swipeUserName[0]) as? String ?? ""
//            self.recieverImage = DataManager.getVal(self.swipeUserImage[0]) as? String ?? ""
//            print(recieverId)
//            print(recieverName)
//
//            self.swipeUserId.remove(at: 0)
//            self.swipeUserName.remove(at: 0)
//            self.swipeUserImage.remove(at: 0)
//            print(self.swipeUserId)
//            print(self.swipeUserName)
//            print(self.swipeUserImage)
//            self.swipeCountAPI(recieverId: self.user_id, type: "", isLike: false)
        }else if direction == .right || direction == .topRight || direction == .bottomRight{
           
            self.kolodaCurrentIndexValue = index
            
            let dict = self.profileDict[index]
            let type = dict.value(forKey: "type") as? String ?? ""
            if type == "ads" {
               
                let adsid = dict.value(forKey: "id") as? Int ?? 0
                let linkUrl = dict.value(forKey: "link") as? String ?? ""
                self.adsrighturl = linkUrl
                self.RightSwipeAdsAPI(ads_id: adsid, type: "like")
            }else{
                let swipeID = dict.value(forKey: "id") as! Int
                let name = dict.value(forKey: "name") as? String ?? ""
                let type = dict.value(forKey: "type") as? String ?? ""
                print(swipeID)
                print(name)
                print(index)
                print(self.profileDict.count)
                self.RightSwipeAPI(SwipeUserId: swipeID, type: "like", vibe: self.CategorySelect, Role: type)
                
                print(self.profileDict.count)
                
                if self.profileDict.count - 1 == index {
                    self.vw = UIView(frame: CGRect(x: 0, y: 100, width: self.view.bounds.size.width, height: self.view.bounds.size.height - 200))
                    let img = UIImageView(frame: CGRect(x: self.vw.frame.size.width/2-60, y: self.vw.frame.size.height/2-60, width: 120, height: 120))
                    img.image = UIImage(named: "starNew")!
                    let lbl = UILabel(frame: CGRect(x: 0, y: img.frame.height - 40, width: self.vw.frame.size.width, height: self.vw.frame.size.height))
                    lbl.text = "Attraction in process!"
                    lbl.textColor = UIColor.black
                    lbl.font = UIFont(name: "Open Sans", size: 15)
                    lbl.textAlignment = .center
                    self.vw.addSubview(img)
                    self.vw.addSubview(lbl)
                   
                    self.vw.isHidden = false
                    
                    self.view.addSubview(self.vw)
                }else{
                    self.vw.removeFromSuperview()
                    self.vw.isHidden = true
                }
                
            }
//            self.recieverId = DataManager.getVal(self.swipeUserId[0]) as? String ?? ""
//            self.recieverName = DataManager.getVal(self.swipeUserName[0]) as? String ?? ""
//            print(self.swipeUserName)
//            print(self.swipeUserId)
//            print(recieverId)
//            print(recieverName)
//            self.recieverImage = DataManager.getVal(self.swipeUserImage[0]) as? String ?? ""
//            self.swipeUserId.remove(at: 0)
//            self.swipeUserName.remove(at: 0)
//            self.swipeUserImage.remove(at: 0)
//            print(self.swipeUserId)
//            print(self.swipeUserName)
//            print(self.swipeUserImage)
//            print(self.recieverId)
//            print(self.user_id)
//            let Rid = Int(self.recieverId) ?? 0
//            let Uid = Int(self.user_id) ?? 0
//            if Rid < Uid {
//                self.room_id = recieverId + "-" + user_id
//                print(self.room_id)
//            }else{
//                self.room_id = user_id + "-" + recieverId
//                print(self.room_id)
//            }
//            self.swipeCountAPI(recieverId: self.user_id, type: self.Liketype, isLike: true)
//            SocketIoManagerNotification.sharedInstance.sendLikeNoti(Sender_Id: self.user_id, Sender_Name: self.user_name, Sender_Image: self.user_image, Reciever_Id: self.recieverId, Reciver_Name: self.recieverName, Reciver_Image: self.recieverImage, Type: self.Liketype, Room_id: room_id)
        }else if direction == .up {
//            self.recieverId = DataManager.getVal(self.swipeUserId[0]) as? String ?? ""
//            self.recieverName = DataManager.getVal(self.swipeUserName[0]) as? String ?? ""
//            print(self.swipeUserName)
//            print(self.swipeUserId)
//            print(recieverId)
//            print(recieverName)
//            self.recieverImage = DataManager.getVal(self.swipeUserImage[0]) as? String ?? ""
//            self.swipeUserId.remove(at: 0)
//            self.swipeUserName.remove(at: 0)
//            self.swipeUserImage.remove(at: 0)
//            print(self.swipeUserId)
//            print(self.swipeUserName)
//            print(self.swipeUserImage)
//            print(self.recieverId)
//            print(self.user_id)
//            let Rid = Int(self.recieverId) ?? 0
//            let Uid = Int(self.user_id) ?? 0
//            if Rid < Uid {
//                self.room_id = recieverId + "-" + user_id
//                print(self.room_id)
//            }else{
//                self.room_id = user_id + "-" + recieverId
//                print(self.room_id)
//            }
//            self.swipeCountAPI(recieverId: self.recieverId, type: self.Liketype, isLike: true)
//            SocketIoManagerNotification.sharedInstance.sendLikeNoti(Sender_Id: self.user_id, Sender_Name: self.user_name, Sender_Image: self.user_image, Reciever_Id: self.recieverId, Reciver_Name: self.recieverName, Reciver_Image: self.recieverImage, Type: self.Liketype, Room_id: room_id)
        }
        else{
            print("No action perform")
        }
    }
}

//extension UIImage {
//    var isPortrait:  Bool    { size.height > size.width }
//    var isLandscape: Bool    { size.width > size.height }
//    var breadth:     CGFloat { min(size.width, size.height) }
//    var breadthSize: CGSize  { .init(width: 30, height: 30) }
//    var breadthRect: CGRect  { .init(origin: .zero, size: breadthSize) }
//    var circleMasked: UIImage? {
//        guard let cgImage = cgImage?
//            .cropping(to: .init(origin: .init(x: isLandscape ? ((size.width-size.height)/2).rounded(.down) : 0,
//                                              y: isPortrait  ? ((size.height-size.width)/2).rounded(.down) : 0),
//                                size: breadthSize)) else { return nil }
//        let format = imageRendererFormat
//        format.opaque = false
//        return UIGraphicsImageRenderer(size: breadthSize, format: format).image { _ in
//            UIBezierPath(ovalIn: breadthRect).addClip()
//            UIImage(cgImage: cgImage, scale: format.scale, orientation: imageOrientation)
//            .draw(in: .init(origin: .zero, size: breadthSize))
//        }
//    }
//}
extension UIImage {

    func circularImage1(size: Int?) -> UIImage {
        let newSize = size ?? 30

        let minEdge = min(30, 30)
        let size = CGSize(width: minEdge, height: minEdge)

        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()

        self.draw(in: CGRect(origin: CGPoint.zero, size: size), blendMode: .copy, alpha: 1.0)

        context!.setBlendMode(.copy)
        context!.setFillColor(UIColor.clear.cgColor)

        let rectPath = UIBezierPath(rect: CGRect(origin: CGPoint.zero, size: size))
        let circlePath = UIBezierPath(ovalIn: CGRect(origin: CGPoint.zero, size: size))
        rectPath.append(circlePath)
        rectPath.usesEvenOddFillRule = true
        rectPath.fill()

        let result = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return result
    }

}
