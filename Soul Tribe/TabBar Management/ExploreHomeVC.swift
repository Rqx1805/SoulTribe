//
//  ExploreHomeVC.swift
//  Soul Tribe
//
//  Created by MAC-30 on 08/12/21.
//

import UIKit
import Koloda

class interestcollcell1: UICollectionViewCell{
    @IBOutlet weak var  cellview: UIView!
    @IBOutlet weak var interestImage: UIImageView!
    @IBOutlet weak var interstedLbl: UILabel!
}

class ExploreHomeVC: UIViewController {
    
    @IBOutlet weak var dailyLimitView: UIView!
    @IBOutlet weak var dailyLimitViewCornerRadius: UIView!
    @IBOutlet weak var dailyLimitView_CancelBtn: UIButton!
    @IBOutlet weak var dailyLimitView_UpgradeBtn: UIButton!
    
    @IBOutlet weak var BuyPremiumPlanPopUp: UIView!
    @IBOutlet weak var BuyPremiumPlanPopUpPopUpCornerRadius: UIView!
    @IBOutlet weak var BuyPremiumPlanPopUpPopUp_UpgradeBtn: UIButton!
    @IBOutlet weak var BuyPremiumPlanPopUpPopUp_TitleTextLbl: UILabel!
    
    @IBOutlet weak var SwipeMatchView: UIView!
    @IBOutlet weak var SwipeMatchViewCornerRadius: UIView!
    @IBOutlet weak var SwipeMatch_MessageBtn: UIButton!
    @IBOutlet weak var SwipeMatch_KeepSwipingBtn: UIButton!
    @IBOutlet weak var SwipeMatch_Image1: UIImageView!
    @IBOutlet weak var SwipeMatch_Image2: UIImageView!
    @IBOutlet weak var sparkVibeImage: UIImageView!
    @IBOutlet weak var matchlbl: UILabel!
    @IBOutlet weak var TopMatchLbl: UILabel!
    
    @IBOutlet weak var SnapsCountPopUp: UIView!
    @IBOutlet weak var SnapsCountPopUpCornerRadius: UIView!
    @IBOutlet weak var SnapsCountPopUp_CancelBtn: UIButton!
    
    @IBOutlet weak var blockPupUpView: UIView!
    @IBOutlet weak var blockPupUpViewCornerRadius: UIView!
    @IBOutlet weak var blockPopUp_CancelBtn: UIButton!
    @IBOutlet weak var blockPopUp_ContinueBtn: UIButton!
    
    @IBOutlet weak var filterBottomView: UIView!
    @IBOutlet weak var filterBottomViewCornerRadius: UIView!
    
    @IBOutlet weak var filterCollectionView: UICollectionView!
    
    @IBOutlet weak var name_Lbl: UILabel!
    @IBOutlet weak var locationlbl: UILabel!
    @IBOutlet weak var filterView1: UIView!
    @IBOutlet weak var filterView2: UIView!
    @IBOutlet weak var filter1Btn: UIButton!
    @IBOutlet weak var filter2Btn: UIButton!
    @IBOutlet weak var TopView: UIView!
    @IBOutlet weak var cardView: CustomKolodaView!
    
    @IBOutlet weak var ad_View: UIView!
    @IBOutlet weak var ad_imgView: UIImageView!
    var adsrighturl = ""
    var kolodaCurrentIndexValue = Int()
    var profileDict = [NSDictionary]()
    var swipeUserID = Int()
    var vw = UIView()
    var hobbiesArray = [String]()
    var getproductImages = [NSDictionary]()
    var picturesArray = [String]()
    var profileImageString = String()
    var receiverName = String()
    var receiverAddress = String()
    var snapsCount = String()
    var gradient = CAGradientLayer()
    var ageInt = Int()
    var comeLat = String()
    var comeLong = String()
    var comeState = String()
    var comecity = String()
    var myHobbies = [String]()
    var selectedHobbies = [String]()
    var comeAddress = String()
    var adCount = Int()
    var dailySwipelimit = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adCount = 0
        dailyLimitViewCornerRadius.layer.cornerRadius = 8
        dailyLimitView_CancelBtn.layer.cornerRadius = 6
        dailyLimitView_CancelBtn.layer.borderWidth = 0.4
        dailyLimitView_CancelBtn.layer.borderColor = UIColor.lightGray.cgColor
        dailyLimitView_UpgradeBtn.layer.cornerRadius = 6
        
        if premiumPlaStatus == 1 || premiumFreePlanStatus == 1 {
           
            self.BuyPremiumPlanPopUpPopUp_UpgradeBtn.setTitle("Start Your FREE 7-Day Trial Today!!", for: .normal)
            
        }else{
            self.BuyPremiumPlanPopUpPopUp_UpgradeBtn.setTitle("Start Your FREE 7-Day Trial Today!", for: .normal)
        }
        
        BuyPremiumPlanPopUpPopUpCornerRadius.layer.cornerRadius = 8
        BuyPremiumPlanPopUpPopUp_UpgradeBtn.layer.cornerRadius = 8
        
        self.SwipeMatchViewCornerRadius.layer.cornerRadius = 5
        
        SnapsCountPopUpCornerRadius.layer.cornerRadius = 6
        SnapsCountPopUp_CancelBtn.layer.cornerRadius = 6
        
        name_Lbl.text = SELECT_VIBE
        locationlbl.text = "  \(self.comeAddress)"
        myHobbies = Config().AppUserDefaults.value(forKey: "myHobbies") as? [String] ?? []
        print(myHobbies)
        filterBottomViewCornerRadius.layer.cornerRadius = 4
        
        cardView.delegate = self
        cardView.dataSource = self
        
        blockPupUpViewCornerRadius.layer.cornerRadius = 6
        blockPopUp_ContinueBtn.layer.cornerRadius = 6
        blockPopUp_CancelBtn.layer.cornerRadius = 6
        blockPopUp_CancelBtn.layer.borderColor = UIColor.lightGray.cgColor
        blockPopUp_CancelBtn.layer.borderWidth = 0.4
        
        filterView1.layer.cornerRadius = 3
        filterView1.layer.borderWidth = 0.2
        filterView1.layer.borderColor = UIColor.darkGray.cgColor
        cardView.countOfVisibleCards = 1
        filterView2.layer.cornerRadius = 3
        filterView2.layer.borderWidth = 0.2
        filterView2.layer.borderColor = UIColor.darkGray.cgColor
        
        
        
        let img = UserDefaults.standard.value(forKey: "user_image") as? String ?? ""
        SwipeMatch_MessageBtn.layer.cornerRadius = 8
        SwipeMatch_KeepSwipingBtn.layer.cornerRadius = 8
        SwipeMatch_Image1.layer.cornerRadius = 8
        SwipeMatch_Image2.layer.cornerRadius = 8
        SwipeMatch_Image1.transform = CGAffineTransform(rotationAngle: CGFloat(-25))
        SwipeMatch_Image2.transform = CGAffineTransform(rotationAngle: CGFloat(25))
       
        SwipeMatch_Image2.sd_setImage(with: URL(string: Config().baseImageUrl + img), placeholderImage: UIImage(named: "default_image"))

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
    
    @IBAction func dailyLimitViewUpgradeAction(_ sender: Any) {
        dailyLimitView.removeFromSuperview()
        let navigate = storyboard?.instantiateViewController(withIdentifier: "MemberShipPlanVC") as! MemberShipPlanVC
        self.navigationController?.pushViewController(navigate, animated: true)
    }
    @IBAction func dailyLimitViewCancelAction(_ sender: Any) {
        dailyLimitView.removeFromSuperview()
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
//            roomId = "\(swipeID)-\(SELECT_VIBE)-\(userID)"
            roomId = "\(swipeID)-\(userID)"
        }else{
//            roomId = "\(userID)-\(SELECT_VIBE)-\(swipeID)"
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData(vibeType: SELECT_VIBE, sort: "", interest: "", city: self.comecity, state: self.comeState)
    }
    @IBAction func backMenu(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func filter1Action(_ sender: Any){
        let actionSheetController = UIAlertController(title: "Sort", message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            
        }
        actionSheetController.addAction(cancelAction)
    let nearto = UIAlertAction(title: "Near to Far", style: .default) { action -> Void in
        self.getData(vibeType: SELECT_VIBE, sort: "distance", interest: "", city: self.comeLat, state: self.comeLong)
//                self.ChatMessageDeleteAPI(room: self.come_RoomID)
        }
        actionSheetController.addAction(nearto)
    let mostlike = UIAlertAction(title: "Most Liked First", style: .default) { action -> Void in
        self.getData(vibeType: SELECT_VIBE, sort: "liked", interest: "", city: self.comeLat, state: self.comeLong)
        }
        actionSheetController.addAction(mostlike)
    
        actionSheetController.popoverPresentationController?.sourceView = sender as? UIView
        
        self.present(actionSheetController, animated: true, completion: nil)
    }
    @IBAction func filter2Action(_ sender: Any){
        self.filterBottomView.frame = self.view.frame
        self.filterBottomView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.view.addSubview(self.filterBottomView)
    }
    @IBAction func FilterViewApplyBtnAction(_ sender: Any) {
        self.filterBottomView.removeFromSuperview()
        self.getData(vibeType: SELECT_VIBE, sort: "", interest: self.selectedHobbies.joined(separator: ","), city: self.comeLat, state: self.comeLong)
    }
    @IBAction func FilterViewCrossBtnAction(_ sender: Any) {
        self.filterBottomView.removeFromSuperview()
    }
    @IBAction func blockPopUp_CancelBtnAction(_ sender: Any) {
        self.blockPupUpView.removeFromSuperview()
    }
    @IBAction func blockPopUp_ContinueBtnAction(_ sender: Any) {
        self.blockPupUpView.removeFromSuperview()
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
//                self.cardView.swipe(.left)
                self.getData(vibeType: SELECT_VIBE, sort: "", interest: "", city: self.comeLat, state: self.comeLong)
                print("rr")
            }
            else {
//                 self.view.makeToast(message)
            }
        }
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
    func getData(vibeType: String, sort: String, interest: String, city: String, state: String){
        
        self.vw.removeFromSuperview()
        self.vw.isHidden = true
        
         self.view.endEditing(true)

         let parameterDictionary = NSMutableDictionary()
        let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
        parameterDictionary.setValue("tribe123", forKey: "api_key")
        parameterDictionary.setValue(userID, forKey: "user_id")
        parameterDictionary.setValue(vibeType, forKey: "vibe")
        parameterDictionary.setValue(self.comeLat, forKey: "latitude")
        parameterDictionary.setValue(self.comeLong, forKey: "longitude")
        parameterDictionary.setValue(city, forKey: "city")
        parameterDictionary.setValue(state, forKey: "state")
        parameterDictionary.setValue(interest, forKey: "interest")
        parameterDictionary.setValue(sort, forKey: "sort")
        print(parameterDictionary)
        let methodName = "get_users_list"

         DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
             let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
             let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
             let user_logout_status  = DataManager.getVal(responseData?["user_logout_status"]) as? String ?? ""
             if status == "1" {
                
                 self.profileDict.removeAll()
                 self.cardView.reloadData()
                 SoulLoveSwipeLimitCount = Int(DataManager.getVal(responseData?["userSoulLoveSwipeCount"]) as? String ?? "")!
                 tribeSwipeLimitCount = Int(DataManager.getVal(responseData?["userTribeSwipeCount"]) as? String ?? "")!
                 self.profileDict = DataManager.getVal(responseData?["data"]) as! [NSDictionary]
                 likedNotificationCount = DataManager.getVal(responseData?["liked_count"]) as? String ?? ""
                 print("Profile :::: ;::::::::::: ::\(self.profileDict.count)")
//                 if self.changeRightSwipeBtnImage == "Soul" {
//                     NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeImgSoulLoveBtn"), object: nil)
//                 }else{
//                     NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeImgTribeBtn"), object: nil)
//                 }
                 if self.profileDict.count == 0 {
                     
                     self.vw = UIView(frame: CGRect(x: 0, y: 100, width: self.TopView.frame.size.width, height: self.TopView.frame.size.height - 200))
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
                     
                     self.TopView.addSubview(self.vw)
                     
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
                     self.vw.removeFromSuperview()
                     self.vw.isHidden = true
//                     print("hide ==========::::::::::::::::")
//                     self.noDataImage.image = UIImage(named: "")
//                     self.noDataImage.isHidden = true
//                     self.noDataLbl.text = ""
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
    @objc func menuOptionReportBtnAction(){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "hide"), object: nil)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReportPopUpVC") as! ReportPopUpVC
        let dict = self.profileDict[self.kolodaCurrentIndexValue]
        let swipeID = dict.value(forKey: "id") as! Int
        let name = dict.value(forKey: "name") as? String ?? ""
        let img = dict.value(forKey: "profile_image") as? String ?? ""
        let add = "\(dict.value(forKey: "city") as? String ?? "")" + ", " + "\(dict.value(forKey: "state") as? String ?? "")"
        
        vc.GetSwipeUserID = swipeID
        vc.getUserName = name
        vc.GetAddress = add
        vc.GetImageStr = img
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func menuOptionBlockUserBtnAction(){
        self.blockPupUpView.frame = self.view.frame
        self.blockPupUpView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
       self.view.addSubview(self.blockPupUpView)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "hide"), object: nil)
    }
    @objc func menuOptionViewProfileBtnAction(){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "hide"), object: nil)
        let tempVw = KolView()
        tempVw.menuoptionView.isHidden = true
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileController") as! ProfileController
        vc.swipeUserID = self.swipeUserID
        vc.picturesArray = self.picturesArray
        vc.vibeType = SELECT_VIBE
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func BtnLeftSwipeAction(){
        self.cardView.swipe(.left)
        
    }
    @objc func readMoreAdsDescription(){
        let adsView = AdsKolView()
//        if adsView.readMore.currentTitle == "Read more" {
//            adsView.descriptionLbl.numberOfLines = 0
//            adsView.readMore.setTitle("Show less", for: .normal)
//        }else{
            adsView.descriptionLbl.numberOfLines = 3
           // adsView.readMore.setTitle("Read more", for: .normal)
        //}
    }
    @objc func BtnRightSwipeAction(){
        self.cardView.swipe(.right)
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
    @IBAction func SnapsCountBtnAction(_ sender: Any) {
        SnapsCountPopUp.removeFromSuperview()
    }
    @objc func ImageClicked1(_ sender : UITapGestureRecognizer) {
        
        if self.snapsCount == "0" {
            self.view.makeToast("This user has no recent Journey posts. To add to your Soul’s Journey, click the link in your profile.")
//            self.SnapsCountPopUp.frame = self.view.frame
//            self.SnapsCountPopUp.backgroundColor = UIColor.black.withAlphaComponent(0.4)
//            self.view.addSubview(self.SnapsCountPopUp)
        }else{
            let vc1 = SB_instaStory.instantiateViewController(withIdentifier: "PresentStoryViewController") as! PresentStoryViewController
            vc1.comeUserID = "\(self.swipeUserID)"
            vc1.modalPresentationStyle = .fullScreen
            self.navigationController?.present(vc1, animated: true, completion: nil)
        }
        print("click")
        print(self.swipeUserID)
    }
}

@available(iOS 13.0, *)
extension ExploreHomeVC: KolodaViewDataSource {
    
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
           // adsView.readMore.addTarget(self, action: #selector(readMoreAdsDescription), for: .touchUpInside)
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
            self.TopView.layer.cornerRadius = 20
            tempVw.greyView.layer.cornerRadius = 20
            tempVw.topUserView.clipsToBounds = true
            tempVw.topUserView.layer.cornerRadius = 8
            tempVw.topUserView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
            tempVw.userImgRoundView.layer.cornerRadius = tempVw.userImgRoundView.frame.height/2
            tempVw.userImg.layer.borderWidth = 2
            tempVw.userImg.layer.borderColor = UIColor.white.cgColor
            
    //        let gradient = CAGradientLayer()
    //        gradient.cornerRadius = tempVw.userImgRoundView.layer.cornerRadius
    //        gradient.frame = tempVw.userImgRoundView.frame
    //        gradient.colors = [UIColor(red: 0.42, green: 0.39, blue: 1.00, alpha: 1.00).cgColor,UIColor(red: 0.05, green: 0.23, blue: 0.66, alpha: 1.00).cgColor,UIColor(red: 0.10, green: 0.55, blue: 0.65, alpha: 1.00).cgColor,UIColor(red: 0.14, green: 0.90, blue: 0.71, alpha: 1.00).cgColor]
    //        tempVw.userImgRoundView.layer.insertSublayer(gradient, at: 0)
    //        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
    //        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
    //        gradient.frame = CGRect(x: 0.0, y: 0.0, width: tempVw.userImgRoundView.frame.size.width, height: tempVw.userImgRoundView.frame.size.height)
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
                self.gradient.cornerRadius = tempVw.userImgRoundView.layer.cornerRadius
                self.gradient.frame = tempVw.userImgRoundView.frame
                self.gradient.colors = [UIColor(red: 0.42, green: 0.39, blue: 1.00, alpha: 1.00).cgColor,UIColor(red: 0.05, green: 0.23, blue: 0.66, alpha: 1.00).cgColor,UIColor(red: 0.10, green: 0.55, blue: 0.65, alpha: 1.00).cgColor,UIColor(red: 0.14, green: 0.90, blue: 0.71, alpha: 1.00).cgColor]
                tempVw.userImgRoundView.layer.insertSublayer(self.gradient, at: 0)
                self.gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
                self.gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
                self.gradient.frame = CGRect(x: 0.0, y: 0.0, width: tempVw.userImgRoundView.frame.size.width, height: tempVw.userImgRoundView.frame.size.height)
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
extension ExploreHomeVC: KolodaViewDelegate {
    
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
        if direction == .left {
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
//            if self.adCount == 2 {
//                ads_API()
//                self.tabBarController?.tabBar.isHidden = true
//                 self.ad_View.frame = self.view.frame
//                self.ad_View.backgroundColor = UIColor.systemGray.withAlphaComponent(1)
//                self.view.addSubview(self.ad_View)
//                self.adCount = 0
//                return false
//            }else{
//                return true
//            }
            return false
        }else if direction == .right {
            
            
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
        }else{
            return false
        }
    }
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection){

        if direction == .left {
            self.kolodaCurrentIndexValue = index
            let dict = self.profileDict[index]
            let type = dict.value(forKey: "type") as? String ?? ""
            if type == "ads" {
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
                let adsid = dict.value(forKey: "id") as? Int ?? 0
                 self.LeftSwipeAdsAPI(ads_id: adsid, type: "reject")

            }else{
                let swipeID = dict.value(forKey: "id") as! Int
                let name = dict.value(forKey: "name") as? String ?? ""
                let type = dict.value(forKey: "type") as? String ?? ""
                print(swipeID)
                print(name)
                print(self.profileDict.count)
                print(index)
                self.RightSwipeAPI(SwipeUserId: swipeID, type: "reject", vibe: SELECT_VIBE, Role: type)
                
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
        }else if direction == .right {
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
                self.RightSwipeAPI(SwipeUserId: swipeID, type: "like", vibe: SELECT_VIBE, Role: type)
                
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
//            adCount += 1
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
extension ExploreHomeVC: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.myHobbies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "interestcollcell1", for: indexPath) as! interestcollcell1
        cell.cellview.layer.cornerRadius = 5
        cell.cellview.layer.borderWidth = 1
        cell.cellview.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        cell.interestImage.image = UIImage(named: self.myHobbies[indexPath.row])
        cell.interstedLbl.text = self.myHobbies[indexPath.row]
        
       // UIColor(red: 0.09, green: 0.78, blue: 0.60, alpha: 1.00)
        if self.selectedHobbies.contains(self.myHobbies[indexPath.row]) {
            cell.cellview.backgroundColor = UIColor(red: 0.09, green: 0.78, blue: 0.60, alpha: 1.00)
        }else{
            cell.cellview.backgroundColor = UIColor.white
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    //UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width/4, height: collectionView.frame.height/2.2);

       }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if self.selectedHobbies.contains(self.myHobbies[indexPath.row]) {
            self.selectedHobbies = self.selectedHobbies.filter{$0 != self.myHobbies[indexPath.row]}
        }else{
            self.selectedHobbies.append(self.myHobbies[indexPath.row])
        }
        print(self.selectedHobbies)

        self.filterCollectionView.reloadData()
    }
}
