//
//  WhoLikedMeVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 11/06/21.
//

import UIKit
import MTSlideToOpen

class WhoLikedMetblcell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
   
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var ageLbl: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var imagecolletion: UICollectionView!
    @IBOutlet weak var swipeBtn: UIButton!
    @IBOutlet weak var firstImpressionLbl: UILabel!
    @IBOutlet weak var interestcollection: UICollectionView!
    @IBOutlet weak var mainviewcornor: UIView!
    @IBOutlet weak var three_OptionView: UIView!
    @IBOutlet weak var reportPopUpBtn: UIButton!
    @IBOutlet weak var blockPopUpBtn: UIButton!
    @IBOutlet weak var ViewProfilePopUpBtn: UIButton!
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var viewProfileBottom: UIButton!
    @IBOutlet weak var imagePageControl: UIPageControl!
    @IBOutlet weak var pageControllerRightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var MtSlideOpenView: MTSlideToOpenView!
    var hobbiesArray = [String]()
    var picturesArray = [String]()
    var distance = String()
    var pController: WhoLikedMeVC!
    let screenWidth = UIScreen.main.bounds.size.width
    override func awakeFromNib() {
        super.awakeFromNib()
        imagecolletion.isPagingEnabled = true
        imagePageControl.layer.cornerRadius = 10
        
        userImg.layer.cornerRadius = userImg.frame.width/2
        self.three_OptionView.isHidden = true
        self.three_OptionView.layer.cornerRadius = 8
        // Initialization code
        self.imagecolletion.delegate = self
        self.imagecolletion.dataSource = self

        self.interestcollection.delegate = self
        self.interestcollection.dataSource = self
        self.MtSlideOpenView.layer.cornerRadius = 22
        
//        MtSlideOpenView.delegate = self
//        MtSlideOpenView.thumnailImageView.image = UIImage(named: "heart")
//        MtSlideOpenView.labelText = "Like Back >>"
//        MtSlideOpenView.textColor = .black
//        MtSlideOpenView.textLabel.textAlignment = .center
//        MtSlideOpenView.backgroundColor = UIColor(red: 0.84, green: 0.84, blue: 1.00, alpha: 1.00)
//        MtSlideOpenView.slidingColor = .clear
//        MtSlideOpenView.sliderBackgroundColor = .clear
//        MtSlideOpenView.textFont = UIFont(name: "Open Sans", size: 17)!
//        MtSlideOpenView.layer.borderColor = UIColor(red: 0.24, green: 0.78, blue: 0.61, alpha: 1.00).cgColor
//        MtSlideOpenView.layer.borderWidth = 0.8
        
        
        self.imagePageControl.transform = CGAffineTransform(scaleX: -3, y: -3)
        imagePageControl.transform = CGAffineTransform(rotationAngle: CGFloat(CGFloat.pi/2))
        
//        self.pageControllerRightConstraint.constant = CGFloat(self.picturesArray.count * 5)
        
        if #available(iOS 14.0, *) {
            imagePageControl.backgroundStyle = .automatic
            imagePageControl.allowsContinuousInteraction = false
        }
       
    }
    
    @IBAction func addThreeOption(_ sender: Any) {
        self.three_OptionView.isHidden = !self.three_OptionView.isHidden
    }
    @IBAction func reportUserAction(_ sender: Any) {
        
    }
    @IBAction func SkipBtnAction(_ sender: Any) {
        
    }
    @IBAction func SkipBtnAction1(_ sender: Any) {
        
    }
    @IBAction func blockUserAction(_ sender: Any) {
//        self.optionView1.removeFromSuperview()
//        self.optionView1.frame = self.view.frame
//        self.optionView1.backgroundColor = UIColor.black.withAlphaComponent(0.4)
//        self.view.addSubview(self.optionView1)
        
    }
    @IBAction func viewProfileAction(_ sender: Any) {
        
    }
    @IBAction func viewBottomProfileAction(_ sender: Any) {
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           
            if collectionView == imagecolletion{
                imagePageControl.numberOfPages = self.picturesArray.count
                 imagePageControl.isHidden = !(self.picturesArray.count > 1)
                return self.picturesArray.count
            }else{
                return self.hobbiesArray.count
            }
        }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == self.imagecolletion{
            self.imagePageControl.currentPage = indexPath.item
        }
    }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if collectionView == imagecolletion
            
            {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WhoLikedMecollcell1", for: indexPath) as! WhoLikedMecollcell1
                cell.lblKm.layer.cornerRadius = 6
                cell.lblKm.text = distance
                cell.tag = indexPath.row
                cell.clipsToBounds = true
                cell.collectioImg.sd_setImage(with: URL(string: Config().baseImageUrl + self.picturesArray[indexPath.row]), placeholderImage: UIImage(named: "default_image"))
                
                cell.contentView.layoutIfNeeded()
                cell.contentView.setNeedsLayout()
                return cell
            }
            else
            {
                let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "WhoLikedMecollcell2", for: indexPath) as! WhoLikedMecollcell2
                cell1.cornorview.layer.cornerRadius = 5
                        
                cell1.interestImage.image = UIImage(named: self.hobbiesArray[indexPath.item])
                cell1.interstedLbl.text = self.hobbiesArray[indexPath.item]
    //            cell1.cornorview.layer.borderWidth = 1
    //            cell1.cornorview.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                return cell1
            }
    }
            //UICollectionViewDelegateFlowLayout
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                if collectionView == imagecolletion {
                    return CGSize(width: imagecolletion.bounds.width, height: imagecolletion.bounds.height)
                }else{
                    //return CGSize(width: UIScreen.main.bounds.width/3-50, height: 30)
                    return CGSize(width: screenWidth/3-38, height: 30)
                }
        }
}
class WhoLikedMecollcell1: UICollectionViewCell{
    @IBOutlet weak var lblKm: UILabel!

    @IBOutlet weak var collectioImg: UIImageView!
}

class WhoLikedMecollcell2: UICollectionViewCell{
    @IBOutlet weak var cornorview: UIView!
    @IBOutlet weak var interestImage: UIImageView!
    @IBOutlet weak var interstedLbl: UILabel!
}

class WhoLikedMeVC: UIViewController {
    
    
    @IBOutlet weak var BuyPremiumPlanPopUp: UIView!
    @IBOutlet weak var BuyPremiumPlanPopUpPopUpCornerRadius: UIView!
    @IBOutlet weak var BuyPremiumPlanPopUpPopUp_UpgradeBtn: UIButton!
    @IBOutlet weak var BuyPremiumPlanPopUpPopUp_TitleTextLbl: UILabel!
    
    @IBOutlet weak var optionView1: UIView!
    @IBOutlet weak var optionView1CornerRadius: UIView!
    @IBOutlet weak var PopUpView_ContinueBtn: UIButton!
    @IBOutlet weak var PopUpView_CancelBtn: UIButton!
    
    var interestImage = ["Aliens","Art","Cooking","Dancing","Fitness","Gaming","Hiking","Law of Attraction","Meditation","Music","Outdoors","Plant Medicine","Quantum Physics","Reading","Shopping","Social Events","Spirituality","Sports","Travel","Yoga"]
    var interestTxt = ["Aliens","Art","Cooking","Dancing","Fitness","Gaming","Hiking","Law of Attraction","Meditation","Music","Outdoors","Plant Medicine","Quantum Physics","Reading","Shopping","Social Events","Spirituality","Sports","Travel","Yoga"]
   
    @IBOutlet weak var table_view: UITableView!
    @IBOutlet weak var tribeLbl: UILabel!
    @IBOutlet weak var soulLoveLbl: UILabel!
    @IBOutlet weak var tribeBtn: UIButton!
    @IBOutlet weak var soulLoveBtn: UIButton!
    var leftDrawerTransition:DrawerTransition!
    var left = LeftMenuViewController()
    var wholikeList = NSMutableArray()
    var categoryVibeType = String()
    var receiverAddress = String()
    var ageInt = Int()
    var getproductImages = [NSDictionary]()
    var profileDict = [NSDictionary]()
    var hobbiesStr = String()
    var swipeUserID = Int()
    var sendPicturesArray = [String]()
    var notitficatioData = [String:Any]()
    var isComeFromPushNotitfication = String()
    override func viewDidLoad() {
        
        if premiumPlaStatus == 1 || premiumFreePlanStatus == 1{
            
            self.BuyPremiumPlanPopUpPopUp_UpgradeBtn.setTitle("Start Your FREE 7-Day Trial Today!", for: .normal)
            
        }else{
            self.BuyPremiumPlanPopUpPopUp_UpgradeBtn.setTitle("Start Your FREE 7-Day Trial Today!", for: .normal)
        }
        
        BuyPremiumPlanPopUpPopUpCornerRadius.layer.cornerRadius = 8
        BuyPremiumPlanPopUpPopUp_UpgradeBtn.layer.cornerRadius = 8
        print(notitficatioData)
        if self.isComeFromPushNotitfication == "yes" {
            let vibe = DataManager.getVal(notitficatioData["vibe"]) as? String ?? ""
            let preMiumPlanStatus = DataManager.getVal(notitficatioData["premium_plan_status"]) as? String ?? ""
            if preMiumPlanStatus == "0" {
                self.BuyPremiumPlanPopUpPopUp_TitleTextLbl.text = "Get access to this and other amazing features by becoming a VIP!"
                self.BuyPremiumPlanPopUp.frame = self.view.frame
                self.BuyPremiumPlanPopUp.backgroundColor = UIColor.black.withAlphaComponent(0.4)
                self.view.addSubview(self.BuyPremiumPlanPopUp)
            }else{
            
                if vibe == "Soul Love" {
                    super.viewDidLoad()
                    self.navigationController?.isNavigationBarHidden = true
                    self.soulLoveLbl.backgroundColor = UIColor(red: 13/255, green: 58/255, blue: 169/255, alpha: 1)
                    self.soulLoveBtn.setTitleColor(UIColor(red: 13/255, green: 58/255, blue: 169/255, alpha: 1), for: .normal)
                    self.tribeLbl.backgroundColor = UIColor.white
                    self.tribeBtn.setTitleColor(UIColor(red: 13/255, green: 58/255, blue: 169/255, alpha: 1), for: .normal)
                    self.categoryVibeType = "Soul Love"
                    getlikeduser_list(vibetype: "Soul Love")
                    self.soulLoveBtn.isHidden = false
                    self.soulLoveLbl.isHidden = false
                    self.tribeBtn.isHidden = true
                    self.tribeLbl.isHidden = true
                }
                else if vibe == "Tribe"{
                    super.viewDidLoad()
                    self.navigationController?.isNavigationBarHidden = true
                    self.soulLoveLbl.backgroundColor = UIColor.white
                    self.soulLoveBtn.setTitleColor(UIColor(red: 13/255, green: 58/255, blue: 169/255, alpha: 1), for: .normal)
                    self.tribeLbl.backgroundColor = UIColor(red: 13/255, green: 58/255, blue: 169/255, alpha: 1)
                    self.tribeBtn.setTitleColor(UIColor(red: 13/255, green: 58/255, blue: 169/255, alpha: 1), for: .normal)
                    self.categoryVibeType = "Tribe"
                    getlikeduser_list(vibetype: "Tribe")
                    table_view.reloadData()
                    self.soulLoveBtn.isHidden = true
                    self.soulLoveLbl.isHidden = true
                    self.tribeBtn.isHidden = false
                    self.tribeLbl.isHidden = false
                }else{
                    self.soulLoveBtn.isHidden = false
                    self.soulLoveLbl.isHidden = false
                    self.tribeBtn.isHidden = false
                    self.tribeLbl.isHidden = false
                }
            }
           
        }else{
            super.viewDidLoad()
            self.navigationController?.isNavigationBarHidden = true
            self.soulLoveLbl.backgroundColor = UIColor(red: 13/255, green: 58/255, blue: 169/255, alpha: 1)
            self.soulLoveBtn.setTitleColor(UIColor(red: 13/255, green: 58/255, blue: 169/255, alpha: 1), for: .normal)
            self.tribeLbl.backgroundColor = UIColor.white
            self.tribeBtn.setTitleColor(UIColor(red: 13/255, green: 58/255, blue: 169/255, alpha: 1), for: .normal)
            self.categoryVibeType = "Soul Love"
            getlikeduser_list(vibetype: "Soul Love")
        }
        
        
        
        table_view.rowHeight = UITableView.automaticDimension
        self.optionView1CornerRadius.layer.cornerRadius = 6
        self.PopUpView_CancelBtn.layer.cornerRadius = 6
        self.PopUpView_ContinueBtn.layer.cornerRadius = 6
        self.PopUpView_CancelBtn.layer.borderWidth = 0.5
        self.PopUpView_CancelBtn.layer.borderColor = UIColor.lightGray.cgColor
        // Do any additional setup after loading the view.
    }
    
    func getlikeduser_list(vibetype: String){
        let parameterDictionary = NSMutableDictionary()
     let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
       parameterDictionary.setValue("tribe123", forKey: "api_key")
        parameterDictionary.setValue(userID, forKey: "user_id")
        parameterDictionary.setValue(vibetype, forKey: "vibe")
       print(parameterDictionary)
        let methodName = "get_liked_users_list"

        DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""

            if status == "1" {
                self.profileDict = DataManager.getVal(responseData?["data"]) as? [NSDictionary] ?? []
                print(self.profileDict.count)
                self.table_view.reloadData()
            }
            else {
//                 self.view.makeToast(message)
            }
        }
    }
    @IBAction func BuyPremiumPlanPopUpUpgradeBtnAction(_ sender: Any) {
        BuyPremiumPlanPopUp.removeFromSuperview()
        let navigate = storyboard?.instantiateViewController(withIdentifier: "MemberShipPlanVC") as! MemberShipPlanVC
        self.navigationController?.pushViewController(navigate, animated: true)
    }
    @IBAction func BuyPremiumPlanPopUpCancelBtnAction(_ sender: Any) {
        BuyPremiumPlanPopUp.removeFromSuperview()
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
    @IBAction func ConfirmBlock_Cancel(_ sender: Any) {
        self.optionView1.removeFromSuperview()
    }
    @IBAction func ConfirmBlock_Continue(_ sender: Any) {
        self.optionView1.removeFromSuperview()
        
//        self.confirmBlockView.isHidden = true
        let tempVw = KolView()
        tempVw.menuoptionView.isHidden = true
        self.view.endEditing(true)
        let parameterDictionary = NSMutableDictionary()
        let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
       parameterDictionary.setValue("tribe123", forKey: "api_key")
       parameterDictionary.setValue(userID, forKey: "user_id")
       parameterDictionary.setValue(self.categoryVibeType, forKey: "vibe")
        parameterDictionary.setValue(self.swipeUserID, forKey: "block_user_id")
       print(parameterDictionary)
        let methodName = "user_block"

        DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""

            if status == "1" {
                self.view.makeToast(message)
                self.table_view.reloadData()
                self.getlikeduser_list(vibetype: self.categoryVibeType)
                print("rr")
            }
            else {
//                 self.view.makeToast(message)
            }
        }
    }
    
    @IBAction func backbtnaction(_ sender:UIButton) {
        self.slideMenuController()?.toggleLeft()
      
        
    }
    @IBAction func SoulLovebtnAction(_ sender:UIButton) {
        
        self.soulLoveLbl.backgroundColor = UIColor(red: 13/255, green: 58/255, blue: 169/255, alpha: 1)
        self.soulLoveBtn.setTitleColor(UIColor(red: 13/255, green: 58/255, blue: 169/255, alpha: 1), for: .normal)
        self.tribeLbl.backgroundColor = UIColor.white
        self.tribeBtn.setTitleColor(UIColor(red: 13/255, green: 58/255, blue: 169/255, alpha: 1), for: .normal)
        self.categoryVibeType = "Soul Love"
        getlikeduser_list(vibetype: self.categoryVibeType)
        table_view.reloadData()
    }
    @IBAction func tribebtnAction(_ sender:UIButton) {
        self.soulLoveLbl.backgroundColor = UIColor.white
        self.soulLoveBtn.setTitleColor(UIColor(red: 13/255, green: 58/255, blue: 169/255, alpha: 1), for: .normal)
        self.tribeLbl.backgroundColor = UIColor(red: 13/255, green: 58/255, blue: 169/255, alpha: 1)
        self.tribeBtn.setTitleColor(UIColor(red: 13/255, green: 58/255, blue: 169/255, alpha: 1), for: .normal)
        self.categoryVibeType = "Tribe"
        getlikeduser_list(vibetype: "Tribe")
        table_view.reloadData()
    }
    @objc func menuOptionReportBtnAction(_ sender: UIButton){
        
        var dict = NSDictionary()
        dict = self.profileDict[sender.tag]
        let id = dict.value(forKey: "id") as! Int
        let name = dict.value(forKey: "name") as? String ?? ""
        let addres = "\(dict.value(forKey: "city") as! String)" + ", " + "\(dict.value(forKey: "state") as! String)"
        let image = dict.value(forKey: "profile_image") as? String ?? ""
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReportPopUpVC") as! ReportPopUpVC
        vc.GetSwipeUserID = id
        vc.getUserName = name
        vc.GetAddress = addres
        vc.GetImageStr = image
        self.navigationController?.pushViewController(vc, animated: true)
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
    func RightSwipeAPI(SwipeUserId: Int, type: String,vibe: String,Role:String!){
         self.view.endEditing(true)

         let parameterDictionary = NSMutableDictionary()
        let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
        parameterDictionary.setValue("tribe123", forKey: "api_key")
        parameterDictionary.setValue(userID, forKey: "user_id")
        parameterDictionary.setValue(vibe, forKey: "vibe")
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
                 self.view.makeToast(message)
                 
                 let data = DataManager.getVal(responseData?["data"]) as? NSDictionary ?? [:]
                 let matchCount = data.value(forKey: "is_friend") as? Int ?? 0
                 print("rr")
                 self.getlikeduser_list(vibetype: self.categoryVibeType)
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
    @objc func like_Swipe(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "cross"), object: nil,userInfo: ["data": "like"])
        self.view.makeToast("Swipe Successfully")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func skip_Swipe(_ sender: UIButton) {
        var dict = NSDictionary()
        dict = self.profileDict[sender.tag]
        let swipeID = dict.value(forKey: "id") as! Int
        let type = dict.value(forKey: "type") as? String ?? ""
        self.RightSwipeAPI(SwipeUserId: swipeID, type: "reject", vibe: self.categoryVibeType, Role: type)
    }
    
    @objc func menuOptionBlockUserBtnAction(){
        
        self.optionView1.frame = self.view.frame
        self.optionView1.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.view.addSubview(self.optionView1)
    }
    @objc func menuOptionViewProfileBtnAction(_ sender: UIButton){
        
        var dict = NSDictionary()
        dict = self.profileDict[sender.tag]

        let id = dict.value(forKey: "id") as! Int
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileController") as! ProfileController
        vc.swipeUserID = id
        vc.picturesArray = self.sendPicturesArray
        vc.vibeType = self.categoryVibeType
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension WhoLikedMeVC: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if self.profileDict.count>0
          {
            numOfSections = 1
            table_view.backgroundView = nil
             }
        else{
//            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: table_view.bounds.size.width, height: table_view.bounds.size.height))
//            noDataLabel.text = "Attraction in Process!"
//            noDataLabel.textColor = UIColor.black
//            noDataLabel.textAlignment = .center
//            table_view.backgroundView  = noDataLabel
            
            let vw = basicFunctions.noDataAvailableWithImageNew(str: "Attraction in Process!", tbl: table_view)
            table_view.backgroundView  = vw
                        return 0
        }
        return numOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.profileDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WhoLikedMetblcell", for: indexPath) as! WhoLikedMetblcell
        cell.picturesArray.removeAll()
        cell.mainviewcornor.layer.cornerRadius = 12
        var dict = NSDictionary()
        dict = self.profileDict[indexPath.row]
        print(dict)
        cell.distance = "\(dict.value(forKey: "distance") as! String)" + " " + "Mi"
        cell.locationLbl.text = "\(dict.value(forKey: "city") as? String ?? "")" + ", " + "\(dict.value(forKey: "state") as? String ?? "")"
        cell.userName.text = dict.value(forKey: "name") as? String ?? ""
        let profileImg = dict.value(forKey: "profile_image") as? String ?? ""
        let firstImpresssion = dict.value(forKey: "first_impression") as? String
        self.hobbiesStr = dict.value(forKey: "hobbies") as? String ?? ""
//        let result = hobbiesStr!.filter { !$0.isWhitespace }
        
        self.swipeUserID = dict.value(forKey: "id") as! Int
        cell.hobbiesArray = hobbiesStr.components(separatedBy: ", ")

        if cell.hobbiesArray.count == 1 {
            cell.hobbiesArray = hobbiesStr.components(separatedBy: ",")
        }else{
            cell.hobbiesArray = hobbiesStr.components(separatedBy: ", ")
        }
        cell.userImg.sd_setImage(with: URL(string: Config().baseImageUrl + profileImg), completed: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ImageClicked(_:)))
               cell.userImg.isUserInteractionEnabled = true
               cell.userImg.addGestureRecognizer(tap)
        tap.view?.tag = indexPath.row
        
        self.ageInt = dict.value(forKey: "age") as! Int
        cell.ageLbl.text = String(self.ageInt)

//        cell.locationLbl.text = self.receiverAddress
        cell.firstImpressionLbl.text = firstImpresssion
        self.getproductImages = dict.value(forKey: "getProductImages") as! [NSDictionary]
        
        print(self.getproductImages)
        for i in 0..<self.getproductImages.count{
            let dict1 = getproductImages[i]
            let images = dict1.value(forKey: "images") as? String
            cell.picturesArray.append(images!)
            self.sendPicturesArray.append(images!)
        }
        cell.pageControllerRightConstraint.constant = -CGFloat(cell.picturesArray.count * 8)
        cell.imagecolletion.reloadData()
        cell.interestcollection.reloadData()
        
        cell.ViewProfilePopUpBtn.tag = indexPath.row
        cell.reportPopUpBtn.tag = indexPath.row
        cell.blockPopUpBtn.tag = indexPath.row
        cell.reportPopUpBtn.addTarget(self, action: #selector(menuOptionReportBtnAction), for: .touchUpInside)
        cell.blockPopUpBtn.addTarget(self, action: #selector(menuOptionBlockUserBtnAction), for: .touchUpInside)
        cell.ViewProfilePopUpBtn.addTarget(self, action: #selector(menuOptionViewProfileBtnAction), for: .touchUpInside)
//        cell.swipeBtn.addTarget(self, action: #selector(like_Swipe(_ :)), for: .touchUpInside)
        cell.skipBtn.tag = indexPath.row
        cell.skipBtn.addTarget(self, action: #selector(skip_Swipe(_ :)), for: .touchUpInside)
        cell.viewProfileBottom.addTarget(self, action: #selector(menuOptionViewProfileBtnAction), for: .touchUpInside)
        
        cell.MtSlideOpenView.delegate = self
        if self.categoryVibeType == "Soul Love" {
            cell.MtSlideOpenView.thumnailImageView.image = UIImage(named: "heart")
        }else{
            cell.MtSlideOpenView.thumnailImageView.image = UIImage(named: "HomeStar")
        }
//        cell.MtSlideOpenView.thumnailImageView.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        cell.MtSlideOpenView.tag = indexPath.row
        cell.MtSlideOpenView.thumnailImageView.backgroundColor = .clear
        cell.MtSlideOpenView.labelText = "Like Back >>"
        cell.MtSlideOpenView.textColor = .black
        cell.MtSlideOpenView.textLabel.textAlignment = .center
        cell.MtSlideOpenView.backgroundColor = UIColor(red: 0.84, green: 0.84, blue: 1.00, alpha: 1.00)
        cell.MtSlideOpenView.slidingColor = .clear
        cell.MtSlideOpenView.sliderBackgroundColor = .clear
        cell.MtSlideOpenView.textFont = UIFont(name: "Open Sans", size: 17)!
        cell.MtSlideOpenView.layer.borderColor = UIColor(red: 0.24, green: 0.78, blue: 0.61, alpha: 1.00).cgColor
        cell.MtSlideOpenView.layer.borderWidth = 0.8
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 700
    }
    
    @objc func ImageClicked(_ sender : UITapGestureRecognizer) {
        let dict = self.profileDict[sender.view?.tag ?? -1]
        
           let tempurlStr = DataManager.getVal(dict["profile_image"]) as? String ?? ""
           
           let vc = self.storyboard?.instantiateViewController(withIdentifier: "ExpandedImageViewController") as! ExpandedImageViewController
        vc.shouldPrefix = true
           vc.urlStr = tempurlStr
           self.navigationController?.pushViewController(vc, animated: true)
       }
}
extension WhoLikedMeVC: MTSlideToOpenDelegate{
    func mtSlideToOpenDelegateDidFinish(_ sender: MTSlideToOpenView) {
        sender.resetStateWithAnimation(false)
        var dict = NSDictionary()
        dict = self.profileDict[sender.tag]
        let swipeID = dict.value(forKey: "id") as! Int
        let type = dict.value(forKey: "type") as? String ?? ""
        self.RightSwipeAPI(SwipeUserId: swipeID, type: "like", vibe: self.categoryVibeType, Role: "user")
    }
}
