//
//  ViewController.swift
//  DemoNew
//
//  Created by mac-9 on 01/07/21.
//

import UIKit
import SDWebImage

class interestcollcell: UICollectionViewCell{
    @IBOutlet weak var  cellview: UIView!
    @IBOutlet weak var interestImage: UIImageView!
    @IBOutlet weak var interstedLbl: UILabel!
}
class discriptiontblcell: UITableViewCell{
    @IBOutlet weak var  imguser: UIImageView!
    @IBOutlet weak var  ansLbl: UILabel!
    @IBOutlet weak var  qsnLbl: UILabel!
}
class discriptiontblcell1: UITableViewCell{
    @IBOutlet weak var  img: UIImageView!
    @IBOutlet weak var  ansLbl: UILabel!
    @IBOutlet weak var  qsnLbl: UILabel!
    @IBOutlet weak var  imgHeightConstraint: NSLayoutConstraint!
}
class ProfileController: UIViewController {
    
    @IBOutlet weak var readMoreBtn: UIButton!
    @IBOutlet weak var readMoreBtnHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var swipeStackView: UIStackView!
    
    @IBOutlet weak var optionView1: UIView!
    @IBOutlet weak var optionView1CornerRadius: UIView!
    @IBOutlet weak var popUpView_upgradeBtn: UIButton!
    @IBOutlet weak var popUpView_CancelBtn: UIButton!
    
    @IBOutlet weak var SnapsCountPopUp: UIView!
    @IBOutlet weak var SnapsCountPopUpCornerRadius: UIView!
    @IBOutlet weak var SnapsCountPopUp_CancelBtn: UIButton!
    
    @IBOutlet weak var vibeStatusSoulLogoWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var vibeStatusTribeLogoWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var vibeStatusDividerWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var tribeLblLeftConstant: NSLayoutConstraint!
    
    @IBOutlet weak var hobbiesCollectionHeightConstant: NSLayoutConstraint!
    
    @IBOutlet weak var nicNameTitleHide: UILabel!
    @IBOutlet weak var sexualityTitleHide: UILabel!
    @IBOutlet weak var nicNameTitleHideWidthConstant: NSLayoutConstraint!
    @IBOutlet weak var sexualityTitleHideLeftConstant: NSLayoutConstraint!
    
    @IBOutlet weak var vibeStatusTribeWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var vibeStatusSoulWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var relationShipAndSexualityViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var relationShipAndSexualityView: UIView!
    @IBOutlet weak var SoulTribeansQsnLastQsnHeightConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var intrestCollectionView: UICollectionView!
    
    @IBOutlet weak var matchView: UIView!
    @IBOutlet weak var matchCornerRadius: UIView!
    
    @IBOutlet weak var blockPopUpView: UIView!
    @IBOutlet weak var blockCornerRadius: UIView!
    @IBOutlet weak var blockBtn_Continue: UIButton!
    
    @IBOutlet weak var asnAnsTable: UITableView!
    @IBOutlet weak var asnAnsTable1: UITableView!
    @IBOutlet weak var asnAnsTable1HeightContraint: NSLayoutConstraint!
    @IBOutlet weak var asnAnsTableHeightContraint: NSLayoutConstraint!
    
    @IBOutlet weak var SoulLoveAsn1: UILabel!
    @IBOutlet weak var SoulLoveAsn2: UILabel!
    @IBOutlet weak var SoulLoveAsn3: UILabel!
    @IBOutlet weak var SoulLoveAsn4: UILabel!
    @IBOutlet weak var TribeAsn1: UILabel!
    @IBOutlet weak var SoulLoveQsnAnsView: UIView!
    @IBOutlet weak var TribeQsnAnsView: UIView!
    @IBOutlet weak var TribeQsnAnsViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var SoulLoveQsnAnsViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var optionMenuView: UIView!
    @IBOutlet weak var vibeStatusTribeLbl: UILabel!
    @IBOutlet weak var vibeStatusSoulLbl: UILabel!
    @IBOutlet weak var firstImpressionLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var userAge: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var viewcorner: UIView!
    @IBOutlet weak var borderview: UIView!
    @IBOutlet weak var imgprofile: UIImageView!
    @IBOutlet weak var btnback: UIButton!
    
    @IBOutlet weak var AKALbl: UILabel!
    @IBOutlet weak var SexualityLbl: UILabel!
    @IBOutlet weak var GenderLbl: UILabel!
    @IBOutlet weak var RelationShipStatusLbl: UILabel!
    @IBOutlet weak var ReligiousViewsLbl: UILabel!
    @IBOutlet weak var CurrentLocationLbl: UILabel!
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var userImgRoundView: UIView!
    @IBOutlet weak var stackViewCrossBtn: UIButton!
    @IBOutlet weak var stackViewStarBtn: UIButton!
    @IBOutlet weak var stackViewLoveBtn: UIButton!
    @IBOutlet weak var LBtn:UIButton!
    @IBOutlet weak var SBtn:UIButton!
    @IBOutlet weak var leftConst:NSLayoutConstraint!
    
    @IBOutlet weak var imgswp:UIImageView!
    var QsnArray = ["What inspires you to wake up every day?","What is your favorite childhood memory that still lights you up when you think about it?","If you can be, do, and have anything in this very moment what would it be?","What led to your spiritual awakening/awareness?"]
    var updateTblFirstTime = Int()
    var AnsArray = [String]()
    var senderID = Int()
    var ansTable1Count = Int()
    var tribeContain = Bool()
    var SoulLoveContain = Bool()
    var profileImageString = String()
    var picturesArray = [String]()
    var vibeType = String()
    var vibeHide = String()
    var hobbiesArray = [String]()
    var AgeInt = Int()
    var profileDict = NSDictionary()
    var swipeUserID = Int()
    var snapsCount = String()
    var gradient = CAGradientLayer()
    var cellHeight1 = Int()
    var getproductImages = [NSDictionary]()
    var vibeHeartStarIcon_visibility = String()
    var isComingFromMiniTribe = Bool()
    var questionAnsHeight = CGFloat()
    var interestImage = ["Aliens","Art","Cooking","Dancing","Fitness","Gaming","Hiking","Law of Attraction","Meditation","Music","Outdoors","Plant Medicine","Quantum Physics","Reading","Shopping","Social Events","Spirituality","Sports","Travel","Yoga"]
    var interestTxt = ["Aliens","Art","Cooking","Dancing","Fitness","Gaming","Hiking","Law of Attraction","Meditation","Music","Outdoors","Plant Medicine","Quantum Physics","Reading","Shopping","Social Events","Spirituality","Sports","Travel","Yoga"]
    var VibeNAr = [String]()
    @IBOutlet weak var compatiblemessage:UILabel!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //self.asnAnsTable1HeightContraint.constant = self.asnAnsTable1.contentSize.height
        //print(self.asnAnsTable1.contentSize.height)
        print("layout")
//        self.asnAnsTable1HeightContraint.constant = self.asnAnsTable1.contentSize.height
//        self.asnAnsTable1HeightContraint.constant = self.asnAnsTable1.contentSize.height
//        self.asnAnsTable1HeightContraint.constant = self.asnAnsTable1.contentSize.height
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isComingFromMiniTribe == true {
            swipeStackView.isHidden = true
        }else {
            swipeStackView.isHidden = false
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeStackView.isHidden = false
        if premiumPlaStatus == 0 {
            self.popUpView_upgradeBtn.setTitle("Start Your FREE 7-Day Trial Today!", for: .normal)
        }else{
            self.popUpView_upgradeBtn.setTitle("Start Your FREE 7-Day Trial Today!", for: .normal)
        }
        SnapsCountPopUpCornerRadius.layer.cornerRadius = 6
        SnapsCountPopUp_CancelBtn.layer.cornerRadius = 6
        
        cellHeight1 = 0
        ansTable1Count = 0
        userImgRoundView.layer.cornerRadius = userImgRoundView.frame.height/2
        imgprofile.layer.borderWidth = 2
        imgprofile.layer.borderColor = UIColor.white.cgColor
        
        
        print(self.swipeUserID)
        print(self.vibeType)
        self.optionView1.removeFromSuperview()
        self.optionView1CornerRadius.layer.cornerRadius = 6
        self.popUpView_upgradeBtn.layer.cornerRadius = 6
//        if self.picturesArray.count <= 1 {
//            self.asnAnsTableHeightContraint.constant = 0
//        }else{
//            self.asnAnsTableHeightContraint.constant = 300
//        }
        
//        if self.vibeType == "Soul Love" {
//            self.TribeQsnAnsViewHeightConstraint.constant = 0
//        }
        blockBtn_Continue.layer.cornerRadius = 6
        blockCornerRadius.layer.cornerRadius = 6
        matchCornerRadius.layer.cornerRadius = 6
        optionMenuView.layer.cornerRadius = 6
        optionMenuView.layer.borderColor = UIColor.lightGray.cgColor
        optionMenuView.layer.borderWidth = 0.6
        self.optionMenuView.isHidden = true
        viewcorner.layer.cornerRadius = 10
        imgprofile.layer.cornerRadius = self.imgprofile.frame.width/2
        btnback.layer.cornerRadius = 5

        borderview.layer.cornerRadius = 10
        borderview.layer.borderWidth = 2
        borderview.layer.borderColor = #colorLiteral(red: 0.4235294118, green: 0.3882352941, blue: 1, alpha: 1)
        getProfiledata()
        
        if self.picturesArray.count == 0 {
            topImage.setImage(UIImage(named: "user")!)
        }else{
            topImage.sd_setImage(with: URL(string: Config().baseImageUrl + self.picturesArray[0]), placeholderImage: UIImage(named: "user"))
        }
        
//        self.topImage.sd_setImage(with: URL(string: Config().baseImageUrl + self.picturesArray[0]), completed: nil)
        // Do any additional setup after loading the view.
        if isComingFromMiniTribe == true {
            swipeStackView.isHidden = true
        }else {
            swipeStackView.isHidden = false
        }
    }
    
    @IBAction func readMoreAction(_ sender: Any) {
        
    }
    @IBAction func matchPopUpCrossBtnAction(_ sender: Any) {
        self.matchView.removeFromSuperview()
    }
    
    @IBAction func cross_Swipe(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "cross"), object: nil,userInfo: ["data": "reject"])
        self.view.makeToast("Swipe Successfully")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func star_Swipe(_ sender: Any) {
        if self.tribeContain == true {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Swipe"), object: nil,userInfo: ["data": "Tribe"])
            self.view.makeToast("Swipe Successfully")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.navigationController?.popViewController(animated: true)
            }        }
    }
    @IBAction func love_Swipe(_ sender: Any) {
        if self.SoulLoveContain == true {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Swipe"), object: nil,userInfo: ["data": "Soul Love"])
            self.view.makeToast("Swipe Successfully")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.navigationController?.popViewController(animated: true)
            }        }
    }

    @IBAction func block_PopUp_Continue(_ sender: Any) {
        self.optionMenuView.isHidden = true
        self.blockPopUpView.removeFromSuperview()
        self.view.endEditing(true)
        let parameterDictionary = NSMutableDictionary()
        let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
       parameterDictionary.setValue("tribe123", forKey: "api_key")
       parameterDictionary.setValue(userID, forKey: "user_id")
        parameterDictionary.setValue(SELECT_VIBE, forKey: "vibe")
        parameterDictionary.setValue(self.swipeUserID, forKey: "block_user_id")
       print(parameterDictionary)
        let methodName = "user_block"

        DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""

            if status == "1" {
                print("rr")
                self.view.makeToast(message)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    self.navigationController?.popViewController(animated: true)
                }
            }
            else {
//                 self.view.makeToast(message)
            }
        }
    }
    @IBAction func block_PopUp_Cancel(_ sender: Any) {
        self.blockPopUpView.removeFromSuperview()
        self.optionMenuView.isHidden = true
    }
    
    @IBAction func Report(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReportPopUpVC") as! ReportPopUpVC
        vc.GetSwipeUserID = self.swipeUserID
        vc.getUserName = self.userName.text ?? ""
        vc.GetAddress = self.CurrentLocationLbl.text ?? ""
        vc.GetImageStr = self.profileImageString
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func Block(_ sender: Any) {
        self.blockPopUpView.frame = self.view.frame
        self.blockPopUpView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.view.addSubview(self.blockPopUpView)
    }
    @IBAction func optionMenuAction(_ sender: Any) {
        self.optionMenuView.isHidden =  !self.optionMenuView.isHidden
    }
    @IBAction func gotomsg(_ sender: Any) {
        
        if premiumPlaStatus == 0 {
            self.optionView1.frame = self.view.frame
            self.optionView1.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            self.view.addSubview(self.optionView1)
        }else{
            let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
            var roomId = ""
            let senderId = Int(self.senderID)
            let userId = Int(userID)!
            if senderId < userId {
                if SELECT_VIBE == ""
                {
                    roomId = "\(self.senderID)-\("Mini Tribes")-\(userID)"
                }
                else{
                    roomId = "\(self.senderID)-\(SELECT_VIBE)-\(userID)"
                }
                
            }else{
                
                if SELECT_VIBE == ""
                {
                    roomId = "\(userID)-\(self.senderID)"
                }
                else{
                    roomId = "\(userID)-\(self.senderID)"
                  }
                }
            let vc = self.storyboard?.instantiateViewController(identifier: "MessageVC") as! MessageVC
            vc.Come_chatUser_ID = String(self.senderID)
            vc.socketType = "direct"
            vc.typeDirect = "direct"
            vc.Come_userName = self.userName.text!
            vc.come_RoomID = roomId
            vc.snapsCount = self.snapsCount
            vc.Come_user_profile_image = Config().baseImageUrl + self.profileImageString
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func popUp_CancelAction1(_ sender: Any) {
        self.optionView1.removeFromSuperview()
    }
    @IBAction func SignUpMeNow_FreeTrialAction(_ sender: Any) {
        self.optionView1.removeFromSuperview()
        let navigate = storyboard?.instantiateViewController(withIdentifier: "MemberShipPlanVC") as! MemberShipPlanVC
        navigate.comeFromProfile = "y"
        self.navigationController?.pushViewController(navigate, animated: true)
    }
    
    
    @IBAction func btnback(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
      
    func getProfiledata(){
        self.AnsArray.removeAll()
        self.picturesArray.removeAll()
        self.hobbiesArray.removeAll()
        
        self.view.endEditing(true)
        let parameterDictionary = NSMutableDictionary()
        let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
       parameterDictionary.setValue("tribe123", forKey: "api_key")
       parameterDictionary.setValue(self.swipeUserID, forKey: "user_id")
        if SELECT_VIBE == ""{ 
            parameterDictionary.setValue("Mini Tribes", forKey: "vibe")
        }
        else{
            parameterDictionary.setValue(SELECT_VIBE, forKey: "vibe")
        }
       parameterDictionary.setValue(userID, forKey: "login_id")
       print(parameterDictionary)
        let methodName = "get_user_details"

        DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
//            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""

            if status == "1" {
                self.profileDict = DataManager.getVal(responseData?["data"]) as! NSDictionary
                self.CurrentLocationLbl.text = "\(self.profileDict.value(forKey: "city") as? String ?? "")" + ", " + "\(self.profileDict.value(forKey: "state") as? String ?? "")"
                self.userName.text = self.profileDict.value(forKey: "name") as? String
                self.profileImageString = self.profileDict.value(forKey: "profile_image") as? String ?? ""
                self.imgprofile.sd_setImage(with: URL(string: Config().baseImageUrl + self.profileImageString), completed: nil)
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(self.ImageClicked(_:)))
                self.imgprofile.isUserInteractionEnabled = true
                self.imgprofile.addGestureRecognizer(tap)
                
                self.senderID = self.profileDict.value(forKey: "id") as! Int
                self.firstImpressionLbl.text = self.profileDict.value(forKey: "first_impression") as? String
                if self.firstImpressionLbl.text == "" {
                    self.readMoreBtn.isHidden = true
                }else{
                    self.readMoreBtn.isHidden = false
                }
                let hobbiesStr = self.profileDict.value(forKey: "hobbies") as? String
//                let result = hobbiesStr!.filter { !$0.isWhitespace }
                self.hobbiesArray = hobbiesStr!.components(separatedBy: ", ")
                if self.hobbiesArray.count >= 4 {
                    self.hobbiesCollectionHeightConstant .constant = 85
                }else{
                    self.hobbiesCollectionHeightConstant .constant = 45
                }
                if self.hobbiesArray.count == 1 {
                    self.hobbiesArray = hobbiesStr!.components(separatedBy: ",")
                }else{
                    self.hobbiesArray = hobbiesStr!.components(separatedBy: ", ")
                }
                let vibes = self.profileDict.value(forKey: "vibe") as? String ?? ""
                let vibesArr1 = vibes.components(separatedBy: ", ")
                print(vibesArr1)
                let sortedArray = vibesArr1.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
                print(sortedArray)
                let vibestp = sortedArray.joined(separator: ", ")
                let vvv = UserDefaults.standard.string(forKey: "userVibe")
                print(vvv)
                var ss = [String]()
                var vibesArr = String()
                ss = vibesArr1
                let ss1 = ss.joined(separator: ",")
                if ss1.contains("Mini Tribes") {
                    let ra = "Mini Tribes"
                    vibesArr = ss1.replacingOccurrences(of: ra, with: "Mini")
                }else{
                    vibesArr = ss1
                }
                let vib = vibesArr.components(separatedBy: ",")
                
                let searchToSearch = "Soul Love"
                let worlds = vib.flatMap { $0.components(separatedBy: ",")}
                self.SoulLoveContain = worlds.filter { searchToSearch.range(of:$0) != nil }.count != 0
                if self.SoulLoveContain == true {
                    self.vibeStatusSoulLbl.text = "Soul Love"
                }else{
                    self.vibeStatusSoulLbl.text = ""
                }
                let searchToSearch1 = "Tribe"
                let worlds1 = vib.flatMap { $0.components(separatedBy: ",")}
                self.tribeContain = worlds1.filter { searchToSearch1.range(of:$0) != nil }.count != 0
                print(self.tribeContain)
                if self.tribeContain == true {
                    self.vibeStatusTribeLbl.text = "Tribe"
                }else{
                    self.vibeStatusTribeLbl.text = ""
                }
                
                if self.SoulLoveContain == true && self.tribeContain == false && vvv == "Soul Love, Mini Tribes" {
                    self.compatiblemessage.text = "You are compatible with this user on Soul Love!"
                    self.swipeStackView.isHidden = false
                    self.matchView.frame = self.view.frame
                    self.matchView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                    self.view.addSubview(self.matchView)
                    self.stackViewLoveBtn.isHidden = false
                    self.stackViewStarBtn.isHidden = true
                    self.SBtn.isHidden = true
                    self.LBtn.isHidden = false
                    self.leftConst.constant = -50
                    self.imgswp.image = UIImage(named: "SoulSwipe")
                }else if self.SoulLoveContain == true && self.tribeContain == true && vvv == "Soul Love, Mini Tribes" {
                    self.compatiblemessage.text = "You are compatible with this user on Soul Love!"
                    self.swipeStackView.isHidden = false
                    self.matchView.frame = self.view.frame
                    self.matchView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                    self.view.addSubview(self.matchView)
                    self.stackViewLoveBtn.isHidden = false
                    self.stackViewStarBtn.isHidden = true
                    self.SBtn.isHidden = true
                    self.LBtn.isHidden = false
                    self.leftConst.constant = -50
                    self.imgswp.image = UIImage(named: "SoulSwipe")
                }else if self.SoulLoveContain == false && self.tribeContain == true && vvv == "Tribe, Mini Tribes" {
                    self.compatiblemessage.text = "You are compatible with this user on Tribe!"
                    self.swipeStackView.isHidden = false
                    self.matchView.frame = self.view.frame
                    self.matchView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                    self.view.addSubview(self.matchView)
                    self.stackViewLoveBtn.isHidden = true
                    self.stackViewStarBtn.isHidden = false
                    self.SBtn.isHidden = false
                    self.LBtn.isHidden = true
                    self.leftConst.constant = 30
                    self.imgswp.image = UIImage(named: "TribeSwipe")
                }
                else if self.SoulLoveContain == true && self.tribeContain == true && vvv == "Tribe, Mini Tribes" {
                    self.compatiblemessage.text = "You are compatible with this user on Tribe!"
                    self.swipeStackView.isHidden = false
                    self.matchView.frame = self.view.frame
                    self.matchView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                    self.view.addSubview(self.matchView)
                    self.stackViewLoveBtn.isHidden = true
                    self.stackViewStarBtn.isHidden = false
                    self.SBtn.isHidden = false
                    self.LBtn.isHidden = true
                    self.leftConst.constant = 30
                    self.imgswp.image = UIImage(named: "TribeSwipe")
                }
                else if self.SoulLoveContain == true && self.tribeContain == true && vvv == "Soul Love, Tribe, Mini Tribes"{
                    self.compatiblemessage.text = "You are compatible with this user on both Soul Love and Tribe!"
                    self.swipeStackView.isHidden = false
                    self.matchView.frame = self.view.frame
                    self.matchView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                    self.view.addSubview(self.matchView)
                    self.stackViewLoveBtn.isHidden = false
                    self.stackViewStarBtn.isHidden = false
                    self.SBtn.isHidden = false
                    self.LBtn.isHidden = false
                    self.leftConst.constant = 130
                    self.imgswp.image = UIImage(named: "swipePupUp")
                } else if self.SoulLoveContain == false && self.tribeContain == true && vvv == "Soul Love, Tribe, Mini Tribes"{
                    self.compatiblemessage.text = "You are compatible with this user on Tribe!"
                    self.swipeStackView.isHidden = false
                    self.matchView.frame = self.view.frame
                    self.matchView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                    self.view.addSubview(self.matchView)
                    self.stackViewLoveBtn.isHidden = true
                    self.stackViewStarBtn.isHidden = false
                    self.SBtn.isHidden = false
                    self.LBtn.isHidden = true
                    self.leftConst.constant = 30
                    self.imgswp.image = UIImage(named: "TribeSwipe")
                } else if self.SoulLoveContain == true && self.tribeContain == false && vvv == "Soul Love, Tribe, Mini Tribes"{
                    self.compatiblemessage.text = "You are compatible with this user on Soul Love!"
                    self.swipeStackView.isHidden = false
                    self.matchView.frame = self.view.frame
                    self.matchView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                    self.view.addSubview(self.matchView)
                    self.stackViewLoveBtn.isHidden = false
                    self.stackViewStarBtn.isHidden = true
                    self.SBtn.isHidden = true
                    self.LBtn.isHidden = false
                    self.leftConst.constant = -50
                    self.imgswp.image = UIImage(named: "SoulSwipe")
                }
//                else if self.SoulLoveContain == true && self.tribeContain == true && vibestp == "Mini Tribes, Soul Love, Tribe"{
//                    self.compatiblemessage.text = "You are compatible with this user on both Soul Love and Tribe!"
//                    self.swipeStackView.isHidden = false
//                    self.matchView.frame = self.view.frame
//                    self.matchView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
//                    self.view.addSubview(self.matchView)
//                }else if self.SoulLoveContain == false && self.tribeContain == true && vibestp == "Mini Tribes, Soul Love, Tribe"{
//                    self.compatiblemessage.text = "You are compatible with this user on Tribe!"
//                    self.swipeStackView.isHidden = false
//                    self.matchView.frame = self.view.frame
//                    self.matchView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
//                    self.view.addSubview(self.matchView)
//                }else if self.SoulLoveContain == true && self.tribeContain == false && vibestp == "Mini Tribes, Soul Love, Tribe"{
//                    self.compatiblemessage.text = "You are compatible with this user on Soul Love!"
//                    self.swipeStackView.isHidden = false
//                    self.matchView.frame = self.view.frame
//                    self.matchView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
//                    self.view.addSubview(self.matchView)
//                }
                else{
                    self.swipeStackView.isHidden = true
                }
                
//                if self.SoulLoveContain == true && self.tribeContain == true {
//                    if self.vibeType == "Tribe" {
//                        //self.swipeStackView.isHidden = false
//                        self.matchView.frame = self.view.frame
//                        self.matchView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
//                        self.view.addSubview(self.matchView)
//                        if self.tribeContain == true && SELECT_VIBE == "Tribe" {
//                           // self.compatiblemessage.text = "You are compatible with this user on Tribe!"
//                        }else if self.tribeContain == true  && SELECT_VIBE == "Soul Love, Tribe" {
//                            //self.compatiblemessage.text = "You are compatible with this user on Tribe!"
//                        }else if self.tribeContain == true  && SELECT_VIBE == "Soul Love, Tribe, Mini Tribe" {
//                            //self.compatiblemessage.text = "You are compatible with this user on Tribe!"
//                        }
////                        self.compatiblemessage.text = "You are compatible with this user on Tribe!"
//                    }else if self.vibeType == "Soul Love" {
//
//                    }
//                    else{
//                        if self.vibeHide == "1" {
//                            self.swipeStackView.isHidden = true
//                        }else{
//                            if self.SoulLoveContain == true && SELECT_VIBE == "Soul Love" {
//                               // self.compatiblemessage.text = "You are compatible with this user on Soul Love!"
//                              //  self.swipeStackView.isHidden = false
//                                self.matchView.frame = self.view.frame
//                                self.matchView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
//                                self.view.addSubview(self.matchView)
//                            }else if self.SoulLoveContain == true && self.tribeContain == true && SELECT_VIBE == "Soul Love" {
//                               // self.compatiblemessage.text = "You are compatible with this user on Soul Love!"
//                              //  self.swipeStackView.isHidden = false
//                                self.matchView.frame = self.view.frame
//                                self.matchView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
//                                self.view.addSubview(self.matchView)
//                            }else if self.SoulLoveContain == false && self.tribeContain == true && SELECT_VIBE == "Tribe" {
//                                //self.compatiblemessage.text = "You are compatible with this user on Tribe!"
//                               // self.swipeStackView.isHidden = false
//                                self.matchView.frame = self.view.frame
//                                self.matchView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
//                                self.view.addSubview(self.matchView)
//                            }
//                            else if self.SoulLoveContain == true && self.tribeContain == true && SELECT_VIBE == "Tribe" {
//                              //  self.compatiblemessage.text = "You are compatible with this user on Tribe!"
//                               // self.swipeStackView.isHidden = false
//                                self.matchView.frame = self.view.frame
//                                self.matchView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
//                                self.view.addSubview(self.matchView)
//                            }
//                            else if self.SoulLoveContain == true && self.tribeContain == true && SELECT_VIBE == "Soul Love, Tribe"{
//                               // self.compatiblemessage.text = "You are compatible with this user on both Soul Love and Tribe!"
//                               // self.swipeStackView.isHidden = false
//                                self.matchView.frame = self.view.frame
//                                self.matchView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
//                                self.view.addSubview(self.matchView)
//                            } else if self.SoulLoveContain == false && self.tribeContain == true && SELECT_VIBE == "Soul Love, Tribe"{
//                               // self.compatiblemessage.text = "You are compatible with this user on Tribe!"
//                               // self.swipeStackView.isHidden = false
//                                self.matchView.frame = self.view.frame
//                                self.matchView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
//                                self.view.addSubview(self.matchView)
//                            } else if self.SoulLoveContain == true && self.tribeContain == false && SELECT_VIBE == "Soul Love, Tribe"{
//                               // self.compatiblemessage.text = "You are compatible with this user on Soul Love!"
//                               // self.swipeStackView.isHidden = false
//                                self.matchView.frame = self.view.frame
//                                self.matchView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
//                                self.view.addSubview(self.matchView)
//                            } else if self.SoulLoveContain == true && self.tribeContain == true && SELECT_VIBE == "Soul Love, Tribe, Mini Tribe"{
//                              //  self.compatiblemessage.text = "You are compatible with this user on both Soul Love and Tribe!"
//                              //  self.swipeStackView.isHidden = false
//                                self.matchView.frame = self.view.frame
//                                self.matchView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
//                                self.view.addSubview(self.matchView)
//                            }else if self.SoulLoveContain == false && self.tribeContain == true && SELECT_VIBE == "Soul Love, Tribe, Mini Tribe"{
//                              //  self.compatiblemessage.text = "You are compatible with this user on Tribe!"
//                               // self.swipeStackView.isHidden = false
//                                self.matchView.frame = self.view.frame
//                                self.matchView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
//                                self.view.addSubview(self.matchView)
//                            }else if self.SoulLoveContain == true && self.tribeContain == false && SELECT_VIBE == "Soul Love, Tribe, Mini Tribe"{
//                               // self.compatiblemessage.text = "You are compatible with this user on Soul Love!"
//                               // self.swipeStackView.isHidden = false
//                                self.matchView.frame = self.view.frame
//                                self.matchView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
//                                self.view.addSubview(self.matchView)
//                            }
//                            else{
//
//                            }
//                           // self.compatiblemessage.text = "You are compatible with this user on both Soul Love and Tribe!"
//
//                        }
//
//                    }
//
//                }else if self.SoulLoveContain == true && self.tribeContain == false {
//                   // self.swipeStackView.isHidden = false
//                    self.matchView.frame = self.view.frame
//                    self.matchView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
//                    self.view.addSubview(self.matchView)
//                    //self.compatiblemessage.text = "You are compatible with this user on both Soul Love and Tribe!"
//                }else{
//
//                }
                if self.SoulLoveContain == true && self.tribeContain == false {
                    
                    self.stackViewStarBtn.removeFromSuperview()
                    self.relationShipAndSexualityViewHeightConstraint.constant = 0
                    self.relationShipAndSexualityView.isHidden = true
                    self.SoulLoveQsnAnsViewHeightConstraint.constant = 150
                    self.vibeStatusDividerWidthConstraint.constant = 0
                    self.vibeStatusTribeWidthConstraint.constant = 0
                    self.vibeStatusTribeLogoWidthConstraint.constant = 0
                    self.vibeStatusSoulWidthConstraint.constant = 60
                    self.vibeStatusSoulLogoWidthConstraint.constant = 10
                   
                    
                }else{
                    if self.SoulLoveContain == false && self.tribeContain == true {
                        self.stackViewLoveBtn.removeFromSuperview()
//                        self.SoulLoveQsnAnsViewHeightConstraint = self.SoulLoveQsnAnsView.heightAnchor.constraint(equalToConstant: 0)
                        self.SoulLoveQsnAnsViewHeightConstraint.constant = 0
                        self.SoulLoveQsnAnsView.isHidden = true
//                        self.SoulLoveQsnAnsView.frame.size.height = 0
                        self.vibeStatusSoulLogoWidthConstraint.constant = 0
                        self.vibeStatusDividerWidthConstraint.constant = 0
                        self.vibeStatusSoulWidthConstraint.constant = 0
                        self.vibeStatusTribeLogoWidthConstraint.constant = 15
                        self.RelationShipStatusLbl.text = "_"
                        if self.vibeHide == "1" {
                           // self.swipeStackView.isHidden = true
                        }else{
                            //self.swipeStackView.isHidden = false
                            self.matchView.frame = self.view.frame
                            self.matchView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                            self.view.addSubview(self.matchView)
                           // self.compatiblemessage.text = "You are compatible with this user on Tribe!"
                        }
                    }
                    else{
                        self.relationShipAndSexualityViewHeightConstraint.constant = 0
                        self.relationShipAndSexualityView.isHidden = true
                        self.SoulLoveQsnAnsViewHeightConstraint.constant = 150
                        
//                        self.relationShipAndSexualityView.isHidden = false
                    }
                }
                self.AKALbl.text = self.profileDict.value(forKey: "nick_name") as? String
                self.SexualityLbl.text = self.profileDict.value(forKey: "mini_tribe_sexuality") as? String
                self.RelationShipStatusLbl.text = self.profileDict.value(forKey: "mini_tribe_relationship_status") as? String
                
                self.SoulLoveAsn1.text = self.profileDict.value(forKey: "relationship_looking_for_soul_love") as? String
                self.SoulLoveAsn2.text = self.profileDict.value(forKey: "soul_love_my_sexuality") as? String
                self.SoulLoveAsn3.text = self.profileDict.value(forKey: "soul_love_my_relationship_status") as? String
                self.SoulLoveAsn4.text = self.profileDict.value(forKey: "soul_love_QA") as? String
                
                
                if self.SoulLoveContain == false && self.tribeContain == true {
                    self.SoulLoveQsnAnsViewHeightConstraint.constant = 0
                    self.SoulLoveQsnAnsView.isHidden = true
                    self.tribeLblLeftConstant.constant = -7
                }else{
                    self.tribeLblLeftConstant.constant = 4
                    if self.SoulLoveAsn4.text?.count == nil {
                        self.SoulTribeansQsnLastQsnHeightConstraint.constant = 0
                        
                        if self.SoulLoveQsnAnsView.isHidden == false {
                            self.SoulLoveQsnAnsViewHeightConstraint.constant = 150
                        }
                    }else{
                        if self.SoulLoveAsn4.text == "Write your answer here (Optional)" {
                            self.SoulTribeansQsnLastQsnHeightConstraint.constant = 0
                            self.SoulLoveQsnAnsViewHeightConstraint.constant = 60
                            self.SoulLoveAsn4.text = ""
                        }else{
                            self.SoulLoveAsn4.text = self.profileDict.value(forKey: "soul_love_QA") as? String
                            self.SoulTribeansQsnLastQsnHeightConstraint.constant = 28
                        }
                    }
                }
               
                let tribe1 = self.profileDict.value(forKey: "tribe_QA") as? String
                if tribe1?.count == 0 || tribe1 == nil {
                    self.TribeQsnAnsViewHeightConstraint.constant = 0
                    self.TribeQsnAnsView.isHidden = true
                }else{
                    self.TribeQsnAnsView.isHidden = false
                    self.TribeQsnAnsViewHeightConstraint.constant = 90
                }
                self.TribeAsn1.text = self.profileDict.value(forKey: "tribe_QA") as? String
                self.AKALbl.text = self.profileDict.value(forKey: "nick_name") as? String
                if self.AKALbl.text?.count == nil {
//                    self.nicNameTitleHideWidthConstant.constant = 0
//                    self.sexualityTitleHideLeftConstant.constant = 0
                    self.AKALbl.text = "-"
                }else{
//                    self.nicNameTitleHideWidthConstant.constant = 40
//                    self.sexualityTitleHideLeftConstant.constant = 160
//                    self.nicNameTitleHide.text = "A.K.A"
                    self.AKALbl.text = self.profileDict.value(forKey: "nick_name") as? String
                }
                self.snapsCount = "\(self.profileDict.value(forKey: "snaps_count") as? Int ?? 0)"
                
                if self.snapsCount == "0" {
                    self.gradient.removeFromSuperlayer()
                  self.userImgRoundView.layer.backgroundColor = UIColor.white.cgColor
                }else{
                    self.gradient.cornerRadius = self.userImgRoundView.layer.cornerRadius
                    self.gradient.frame = self.userImgRoundView.frame
                    self.gradient.colors = [UIColor(red: 0.42, green: 0.39, blue: 1.00, alpha: 1.00).cgColor,UIColor(red: 0.05, green: 0.23, blue: 0.66, alpha: 1.00).cgColor,UIColor(red: 0.10, green: 0.55, blue: 0.65, alpha: 1.00).cgColor,UIColor(red: 0.14, green: 0.90, blue: 0.71, alpha: 1.00).cgColor]
                    self.userImgRoundView.layer.insertSublayer(self.gradient, at: 0)
                    self.gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
                    self.gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
                    self.gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.userImgRoundView.frame.size.width, height: self.userImgRoundView.frame.size.height)
                }
                
                self.GenderLbl.text = self.profileDict.value(forKey: "gender") as? String
                let distance = self.profileDict.value(forKey: "search_distance") as? String
                let distanceType = self.profileDict.value(forKey: "distance_type") as? String ?? ""
                self.distanceLbl.text = "\(distance!)" + " " + "Mi"
                
                self.ReligiousViewsLbl.text = self.profileDict.value(forKey: "religious") as? String
                self.AgeInt = self.profileDict.value(forKey: "age") as! Int
                self.userAge.text = String(self.AgeInt)
                self.intrestCollectionView.reloadData()
                
                if self.SoulLoveContain == false && self.tribeContain == false {
                    print("both false")
                    self.swipeStackView.isHidden = true
                    self.relationShipAndSexualityViewHeightConstraint.constant = 0
                    self.relationShipAndSexualityView.isHidden = true
                    self.SoulLoveQsnAnsViewHeightConstraint.constant = 0
                    self.SoulLoveQsnAnsView.isHidden = true
                    self.TribeQsnAnsViewHeightConstraint.constant = 0
                    self.TribeQsnAnsView.isHidden = true
                    
                    self.vibeStatusSoulLbl.text = "Mini Tribes"
                    self.vibeStatusSoulWidthConstraint.constant = 120
                    self.vibeStatusDividerWidthConstraint.constant = 0
                    self.vibeStatusTribeWidthConstraint.constant = 0
                    self.vibeStatusTribeLogoWidthConstraint.constant = 0
                    self.vibeStatusSoulLogoWidthConstraint.constant = 0
                }
                
                let qsn1 = self.profileDict.value(forKey: "QA_1") as? String
                let qsn2 = self.profileDict.value(forKey: "QA_2") as? String
                let qsn3 = self.profileDict.value(forKey: "QA_3") as? String
                let qsn4 = self.profileDict.value(forKey: "QA_4") as? String
                
                if qsn1?.count != nil {
                    self.ansTable1Count += 1
                    self.AnsArray.append(qsn1!)
                }
                if qsn2?.count != nil {
                    self.ansTable1Count += 1
                    self.AnsArray.append(qsn2!)
                }
                if qsn3?.count != nil {
                    self.ansTable1Count += 1
                    self.AnsArray.append(qsn3!)
                }
                if qsn4?.count != nil{
                    self.ansTable1Count += 1
                    self.AnsArray.append(qsn4!)
                }
                
                print(self.AnsArray.count)
                
                
                
                if self.ansTable1Count >= self.picturesArray.count - 1 {

                    self.asnAnsTable1HeightContraint.constant = CGFloat(200 * self.ansTable1Count)
                }else{

                    self.asnAnsTable1HeightContraint.constant = CGFloat(240 * self.picturesArray.count) + CGFloat(20 * self.ansTable1Count)

                }
//                let txtCount = self.ansTable1Count
//                let pictureCount = self.picturesArray.count - 1
//                if txtCount > pictureCount {
//                    <#code#>
//                }
                //self.asnAnsTable1.estimatedRowHeight = UITableView.automaticDimension
//                self.asnAnsTable.reloadData()
                if self.picturesArray.count == 0 {
                    self.getproductImages = self.profileDict.value(forKey: "get_product_images") as? [NSDictionary] ?? [[:]]
                    self.asnAnsTable1HeightContraint.constant = CGFloat(200 + (self.getproductImages.count * 240)) +  CGFloat( 110 * self.AnsArray.count)
                    for i in 0..<self.getproductImages.count{
                        let dict1 = self.getproductImages[i]
                        let images = dict1.value(forKey: "images") as? String
                        self.picturesArray.append(images!)
                        Config().setimage(image_url: "\(Config().baseImageUrl)" + "\(self.picturesArray[0])", image_name: self.topImage)
                    }
                }
                
                self.cellHeight1 = 0
                self.asnAnsTable1.reloadData()
                if self.isComingFromMiniTribe == true {
                    self.swipeStackView.isHidden = true
                }else {
                    self.swipeStackView.isHidden = false
                }
            }
            else {
//                 self.view.makeToast(message)
            }
        }
    }
    @IBAction func SnapsCountBtnAction(_ sender: Any) {
        SnapsCountPopUp.removeFromSuperview()
    }
    
    @objc func ImageClicked(_ sender : UIImageView) {
        
        
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
    
    
    @IBAction func readMoreBtnAction(_ sender: UIButton) {
        
        if self.readMoreBtn.currentTitle == "Read less" {
            self.readMoreBtnHeightConstraint.constant = 14
            self.readMoreBtn.setTitle("Read More", for: .normal)
        }else{
            if self.firstImpressionLbl.text?.count ?? 15 <= 60 {
                self.readMoreBtnHeightConstraint.constant = 28
                self.readMoreBtn.setTitle("Read less", for: .normal)
            }else if self.firstImpressionLbl.text?.count ?? 15 <= 120 {
                self.readMoreBtnHeightConstraint.constant = 42
                self.readMoreBtn.setTitle("Read less", for: .normal)
            }else if self.firstImpressionLbl.text?.count ?? 15 <= 180 {
                self.readMoreBtnHeightConstraint.constant = 56
                self.readMoreBtn.setTitle("Read less", for: .normal)
            }else if self.firstImpressionLbl.text?.count ?? 15 <= 200 {
                self.readMoreBtnHeightConstraint.constant = 90
                self.readMoreBtn.setTitle("Read less", for: .normal)
            }else if self.firstImpressionLbl.text?.count ?? 15 <= 240 {
                self.readMoreBtnHeightConstraint.constant = 110
                self.readMoreBtn.setTitle("Read less", for: .normal)
            }else{
                self.readMoreBtnHeightConstraint.constant = 14
            }
        }
    }
    @objc func ImageClicked1(_ sender : UITapGestureRecognizer) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ExpandedImageViewController") as! ExpandedImageViewController
        vc.urlStr = self.picturesArray[sender.view!.tag + 1]
         vc.shouldPrefix = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProfileController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource{
   
    //MARK: COLLECTION VIEW METHOD
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.hobbiesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "interestcollcell", for: indexPath) as! interestcollcell
        cell.cellview.layer.cornerRadius = 5
        cell.cellview.layer.borderWidth = 1
        cell.cellview.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        cell.interestImage.image = UIImage(named: self.hobbiesArray[indexPath.row])
        cell.interstedLbl.text = self.hobbiesArray[indexPath.row]
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
        
    }
    //UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width/4, height: collectionView.frame.height/2.2);

        }
    
    //MARK: TABLE VIEW METHOD
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if tableView == asnAnsTable {
//            return self.picturesArray.count - 1
//        }else{

            if self.ansTable1Count >= self.picturesArray.count - 1 {
                
                return self.ansTable1Count
            }else{
                    return self.picturesArray.count - 1
            }
//        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        if tableView == asnAnsTable {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "discriptiontblcell", for: indexPath) as! discriptiontblcell
//            cell.imguser.layer.cornerRadius = 10
//            cell.imguser.sd_setImage(with: URL(string: Config().baseImageUrl + self.picturesArray[indexPath.row + 1]), completed: nil)
//            return cell
//        }else{
//            let imgCount = self.picturesArray.count - 1
            let cell = tableView.dequeueReusableCell(withIdentifier: "discriptiontblcell1", for: indexPath) as! discriptiontblcell1
//            if self.QsnArray.count == 0 || self.AnsArray.count == 0 {
                
//            }else{
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ImageClicked1(_:)))
        cell.img.isUserInteractionEnabled = true
        cell.img.addGestureRecognizer(tap)
        tap.view?.tag = indexPath.row
        
                if indexPath.row < self.picturesArray.count - 1 {
                    
                    cell.img.sd_setImage(with: URL(string: Config().baseImageUrl + self.picturesArray[indexPath.row + 1]), placeholderImage: #imageLiteral(resourceName: "default_image"), options: .refreshCached) { (image, error, cachesType, url) in
                    }
                    cell.qsnLbl.text = ""
                    cell.ansLbl.text = ""
                    cell.imgHeightConstraint.constant = 240
                    cellHeight1 += 240
                }else{
                    cell.qsnLbl.text = ""
                    cell.ansLbl.text = ""
                    cell.imgHeightConstraint.constant = 0
                }
//            }
            if self.QsnArray.count == 0 || self.AnsArray.count == 0 {
                
            }else{
                if indexPath.row < self.ansTable1Count {
                    cell.qsnLbl.text = self.QsnArray[indexPath.row]
                    cell.ansLbl.text = self.AnsArray[indexPath.row]
                    cellHeight1 += 80
                }else{
                    cell.qsnLbl.text = ""
                    cell.ansLbl.text = ""
                }
            }
//        questionAnsHeight += cell.contentView.frame.height
        asnAnsTable1HeightContraint.constant = CGFloat(self.picturesArray.count * 100)
//        defer {
//            let lblHeight = cell.ansLbl.bounds.height
//            print(lblHeight)
//        }
//        let lblHeight = cell.ansLbl.bounds.height
//        print(lblHeight)
//        self.asnAnsTable1HeightContraint.constant = CGFloat(cellHeight1)
        cell.contentView.setNeedsLayout()
        cell.contentView.layoutIfNeeded()
            return cell
        
//        }
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if tableView == asnAnsTable {
//            return 300
//        }else{
//        if indexPath.row < self.picturesArray.count - 1 {
//            return 320
//        }else{
//            return 100
//        }
//
//
//        }
//
//    }
}
