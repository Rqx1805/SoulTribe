//
//  ProfileTabVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 07/06/21.
//

import UIKit


class qsnAnsTableCellnew: UITableViewCell{
    @IBOutlet weak var  ansLbl: UILabel!
    @IBOutlet weak var  qsnLbl: UILabel!
}

class SoulTribeTab3: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SlideMenuControllerDelegate{
    
    @IBAction func btn_editProfileAction(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(identifier: "SetprofileVC") as! SetprofileVC
        vc.comesFrom = "Edit"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    var snapsCount = String()
    let gradient = CAGradientLayer()
    @IBOutlet weak var galleryCollectionVIew: UICollectionView!
    @IBOutlet weak var interestCollectionView: UICollectionView!
    @IBOutlet weak var imgprofile: UIImageView!
    
    @IBOutlet weak var SnapsCountPopUp: UIView!
    @IBOutlet weak var SnapsCountPopUpCornerRadius: UIView!
    @IBOutlet weak var SnapsCountPopUp_CancelBtn: UIButton!
    @IBOutlet weak var userImgRoundView: UIView!

    var QsnArray = ["What inspires you to wake up every day?","What is your favorite childhood memory that still lights you up when you think about it?","if you can be, do, and have anything in this very moment what would it be?","what led to your spiritual awakening/awareness?"]
    var interestImage = ["Aliens","Art","Cooking","Dancing","Fitness","Gaming","Hiking","Law of Attraction","Meditation","Music","Outdoors","Plant Medicine","Quantum Physics","Reading","Shopping","Social Events","Spirituality","Sports","Travel","Yoga"]
    var interestTxt = ["Aliens","Art","Cooking","Dancing","Fitness","Gaming","Hiking","Law of Attraction","Meditation","Music","Outdoors","Plant Medicine","Quantum Physics","Reading","Shopping","Social Events","Spirituality","Sports","Travel","Yoga"]

    @IBOutlet weak var Name_Age: UILabel!
    @IBOutlet weak var first_impression: UILabel!
    @IBOutlet weak var nick_name: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var vibe: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var religious: UILabel!
    @IBOutlet weak var sexuality: UILabel!
    @IBOutlet weak var nicNameTitleHide: UILabel!
    @IBOutlet weak var sexualityTitleHide: UILabel!
    @IBOutlet weak var nicNameTitleHideWidthConstant: NSLayoutConstraint!
    @IBOutlet weak var sexualityTitleHideLeftConstant: NSLayoutConstraint!
    
    @IBOutlet weak var asnAnsTableHeightContraint: NSLayoutConstraint!
    @IBOutlet weak var asnAnsTable: UITableView!

    @IBOutlet weak var readMoreBtn: UIButton!
    @IBOutlet weak var readMoreBtnHeightConstraint: NSLayoutConstraint!
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    var leftDrawerTransition:DrawerTransition!
    var left = LeftMenuViewController()
    var imgBase_url = ""
    var nameAge = ""
    var hobbiesStr = ""
    var hobbiesArray = [String]()
    var product_imagesArray = [[String:Any]]()
    var SendToOverAllVC = String()
    var SendToYearlyVC = String()
    var SendToMonthlyVC = String()
    
    
    var ansTable1Count = Int()
    var AnsArray = [String]()
//    var gallery_image_url = ""

    var apiData = [String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SnapsCountPopUpCornerRadius.layer.cornerRadius = 6
        SnapsCountPopUp_CancelBtn.layer.cornerRadius = 6
        
        self.ansTable1Count = 0
        forIntentionHide = true
        imgprofile.layer.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        imgprofile.layer.shadowOpacity = 0.8
        imgprofile.layer.shadowOffset = .zero
        imgprofile.layer.shadowRadius = 8
        imgprofile.layer.cornerRadius = 65
        imgprofile.layer.borderWidth = 2.5
        imgprofile.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

        imgprofile.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        imgprofile.layer.borderWidth = 2.5
        imgprofile.layer.shadowRadius = 0.6

        
        let LiberaryLayOut = UICollectionViewFlowLayout()
        LiberaryLayOut.itemSize = CGSize(width: screenWidth/2.8, height: 30)
        LiberaryLayOut.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        LiberaryLayOut.minimumInteritemSpacing = 0
        LiberaryLayOut.minimumLineSpacing = 10
        LiberaryLayOut.scrollDirection = .vertical
        interestCollectionView.collectionViewLayout = LiberaryLayOut

        
        //        let LiberaryLayOut1 = UICollectionViewFlowLayout()
//        LiberaryLayOut1.itemSize = CGSize(width: screenWidth, height: 120)
//        LiberaryLayOut1.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
////        LiberaryLayOut1.minimumInteritemSpacing = 0
//        LiberaryLayOut1.minimumLineSpacing = 0
//        LiberaryLayOut1.scrollDirection = .vertical
//        galleryCollectionVIew.collectionViewLayout = LiberaryLayOut1

        setupLeftDrawer(self)
//        get_profileAPI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        get_profileAPI()
        self.userImgRoundView.layer.cornerRadius = self.userImgRoundView.frame.height/2
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
    func get_profileAPI(){
        self.ansTable1Count = 0
        showIntentionVC.removeAll()
        self.AnsArray.removeAll()
        self.asnAnsTableHeightContraint.constant = 0
        let parameterDictionary = NSMutableDictionary()
        let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
       parameterDictionary.setValue("tribe123", forKey: "api_key")
       parameterDictionary.setValue(userID, forKey: "user_id")
        let timeZone = TimeZone.current.identifier

        parameterDictionary.setValue(timeZone, forKey: "timezone")
       print(parameterDictionary)
        let methodName = "get_profile"

        DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){ [self](responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
            let data = DataManager.getVal(responseData?["data"]) as? NSDictionary
            let user_logout_status  = DataManager.getVal(responseData?["user_logout_status"]) as? String ?? ""
            self.apiData = data as? [String:Any] ?? [:]
            
            let profile_image  = DataManager.getVal(data?["profile_image"]) as? String ?? ""
            self.imgBase_url = Config().baseImageUrl + profile_image
             
            let name = DataManager.getVal(data?["name"]) as? String ?? ""
            let age = DataManager.getVal(data?["age"]) as? String ?? ""
            
            self.nameAge = name + " | " + age
            
            if status == "1" {

                self.imgprofile.sd_setImage(with: URL(string: self.imgBase_url), placeholderImage: #imageLiteral(resourceName: "user"), options: .refreshCached) { (image, error, cachesType, url) in
                        }
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(ImageClicked(_:)))
                imgprofile.isUserInteractionEnabled = true
                imgprofile.addGestureRecognizer(tap)
                let lat = DataManager.getVal(data?["lat"]) as? String ?? ""
                let lng = DataManager.getVal(data?["lng"]) as? String ?? ""
                let city = DataManager.getVal(data?["city"]) as? String ?? ""
                let state = DataManager.getVal(data?["state"]) as? String ?? ""
                
                UserDefaults.standard.setValue(lat, forKey: "lati")
                UserDefaults.standard.setValue(lng, forKey: "longi")
                UserDefaults.standard.setValue(city, forKey: "city")
                UserDefaults.standard.setValue(state, forKey: "state")
                
                
                USER_VIBE = data?.value(forKey: "vibe") as? String ?? ""
                Config().AppUserDefaults.setValue(USER_VIBE, forKey: "userVibe")
                self.vibe.text = data?.value(forKey: "vibe") as? String
                self.first_impression.text = DataManager.getVal(data?["first_impression"]) as? String ?? ""
                if self.first_impression.text == "" {
                    self.readMoreBtn.isHidden = true
                }else{
                    self.readMoreBtn.isHidden = false
                }
                self.Name_Age.text = self.nameAge
                self.nick_name.text = DataManager.getVal(data?["nick_name"]) as? String ?? ""
                if self.nick_name.text == "" {
                    self.nicNameTitleHideWidthConstant.constant = 0
                    self.sexualityTitleHideLeftConstant.constant = 0
                    self.nicNameTitleHide.text = ""
                }else{
                    self.nicNameTitleHideWidthConstant.constant = 40
                    self.sexualityTitleHideLeftConstant.constant = 160
                    self.nicNameTitleHide.text = "A.K.A"
                }
                let emailNotificationStatus  = DataManager.getVal(data?["email_notification"]) as? String ?? ""
                let InAppNotificationStatus  = DataManager.getVal(data?["in_app_notification"]) as? String ?? ""
                UserDefaults.standard.setValue(emailNotificationStatus, forKey: "emailNotificationStatus")
                UserDefaults.standard.setValue(InAppNotificationStatus, forKey: "InAppNotificationStatus")
                self.gender.text = DataManager.getVal(data?["gender"]) as? String ?? ""
                self.address.text = "\(DataManager.getVal(data?["city"]) as? String ?? "")" + ", " + "\(DataManager.getVal(data?["state"]) as? String ?? "")"
                self.religious.text = DataManager.getVal(data?["religious"]) as? String ?? ""
                self.sexuality.text = DataManager.getVal(data?["mini_tribe_sexuality"]) as? String ?? ""
                self.status.text = DataManager.getVal(data?["mini_tribe_relationship_status"]) as? String ?? ""
                self.hobbiesStr = DataManager.getVal(data?["hobbies"]) as? String ?? ""
                self.hobbiesArray = self.hobbiesStr.components(separatedBy: ", ")
                Config().AppUserDefaults.set(self.hobbiesArray, forKey: "myHobbies")
                let product_images = DataManager.getVal(data?["get_product_images"]) as? NSArray ?? []

                self.snapsCount = DataManager.getVal(data?["snaps_count"]) as! String
                if self.snapsCount == "0" {
                    self.imgprofile.layer.borderColor = UIColor.white.cgColor
                    self.gradient.removeFromSuperlayer()
                    self.userImgRoundView.layer.backgroundColor = UIColor.white.cgColor
                }else{
                    self.userImgRoundView.layer.cornerRadius = self.userImgRoundView.frame.height/2
    
                    gradient.cornerRadius = self.userImgRoundView.layer.cornerRadius
                    gradient.frame = self.userImgRoundView.frame
                    gradient.colors = [UIColor(red: 0.42, green: 0.39, blue: 1.00, alpha: 1.00).cgColor,UIColor(red: 0.05, green: 0.23, blue: 0.66, alpha: 1.00).cgColor,UIColor(red: 0.10, green: 0.55, blue: 0.65, alpha: 1.00).cgColor,UIColor(red: 0.14, green: 0.90, blue: 0.71, alpha: 1.00).cgColor]
                    self.userImgRoundView.layer.insertSublayer(gradient, at: 0)
                    gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
                    gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
                    gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.userImgRoundView.frame.size.width, height: self.userImgRoundView.frame.size.height)
                }
                self.product_imagesArray = product_images as! [[String : Any]]
//                let gallery_image  = DataManager.getVal(product_images?["images"]) as? String ?? ""
                
                self.SendToOverAllVC = DataManager.getVal(data?["overall_application_status"]) as? String ?? ""
                self.SendToMonthlyVC = DataManager.getVal(data?["monthly_status"]) as? String ?? ""
                self.SendToYearlyVC = DataManager.getVal(data?["yearly_status"]) as? String ?? ""
                
                if self.SendToOverAllVC == "0" {
                    showIntentionVC.append("Overall")
                }
                if self.SendToMonthlyVC == "0" {
                    showIntentionVC.append("monthly")
                }
                if self.SendToYearlyVC == "0" {
                    showIntentionVC.append("yearly")
                }
                print(showIntentionVC)
                
                
                let qsn1 = data?.value(forKey: "QA_1") as? String
                let qsn2 = data?.value(forKey: "QA_2") as? String
                let qsn3 = data?.value(forKey: "QA_3") as? String
                let qsn4 = data?.value(forKey: "QA_4") as? String
                
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
                
//                self.asnAnsTableHeightContraint.constant = CGFloat(20 + (self.AnsArray.count * 65))
                self.asnAnsTableHeightContraint.constant = 0
                
                self.asnAnsTable.reloadData()
                
                self.galleryCollectionVIew.reloadData()
                self.interestCollectionView.reloadData()
                if user_logout_status == "0" {
                                    LogoutAPI()
                                }else{
                                    
                                }
            } else {
                if user_logout_status == "0" {
                                    LogoutAPI()
                                }else{
                                    
                                }
//                 self.view.makeToast(message)
            }
        }
    }
    
    @IBAction func readMoreBtnAction(_ sender: UIButton) {
        print(self.first_impression.text?.count)
        
        if self.readMoreBtn.currentTitle == "Read less" {
            self.readMoreBtnHeightConstraint.constant = 14
            self.readMoreBtn.setTitle("Read More", for: .normal)
        }else{
            if self.first_impression.text?.count ?? 15 <= 60 {
                self.readMoreBtnHeightConstraint.constant = 28
                self.readMoreBtn.setTitle("Read less", for: .normal)
            }else if self.first_impression.text?.count ?? 15 <= 120 {
                self.readMoreBtnHeightConstraint.constant = 42
                self.readMoreBtn.setTitle("Read less", for: .normal)
            }else if self.first_impression.text?.count ?? 15 <= 180 {
                self.readMoreBtnHeightConstraint.constant = 56
                self.readMoreBtn.setTitle("Read less", for: .normal)
            }else if self.first_impression.text?.count ?? 15 <= 200 {
                self.readMoreBtnHeightConstraint.constant = 70
                self.readMoreBtn.setTitle("Read less", for: .normal)
            }
            else if self.first_impression.text?.count ?? 15 <= 240 {
                self.readMoreBtnHeightConstraint.constant = 90
                self.readMoreBtn.setTitle("Read less", for: .normal)
            }else if self.first_impression.text?.count ?? 15 <= 300 {
                self.readMoreBtnHeightConstraint.constant = 110
                self.readMoreBtn.setTitle("Read less", for: .normal)
            }else if self.first_impression.text?.count ?? 15 <= 320 {
                self.readMoreBtnHeightConstraint.constant = 112
                self.readMoreBtn.setTitle("Read less", for: .normal)
            }
            else if self.first_impression.text?.count ?? 15 <= 360 {
                self.readMoreBtnHeightConstraint.constant = 98
                self.readMoreBtn.setTitle("Read less", for: .normal)
            }else if self.first_impression.text?.count ?? 15 <= 420 {
                self.readMoreBtnHeightConstraint.constant = 112
                self.readMoreBtn.setTitle("Read less", for: .normal)
            }
            else{
                self.readMoreBtnHeightConstraint.constant = 14
            }
        }
    }
    @objc func ImageClicked(_ sender : UIImageView) {
        
        let actionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
                    
                }
                actionSheetController.addAction(cancelAction)
            let nearto = UIAlertAction(title: "View profile picture", style: .default) { action -> Void in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ExpandedImageViewController") as! ExpandedImageViewController
         vc.urlStr = DataManager.getVal(self.apiData["profile_image"]) as? String ?? ""
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
                    vc1.comerFromTab = "y"
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
           }


    @IBAction func btngotonext(_ sender: Any) {
        
        if self.SendToOverAllVC == "0" {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "overAllIntentions") as! overAllIntentions
                    self.navigationController?.pushViewController(vc, animated: true)
        }else if self.SendToMonthlyVC == "0" {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "monthlyIntentionsVC") as! monthlyIntentionsVC
                    self.navigationController?.pushViewController(vc, animated: true)
        }else if self.SendToYearlyVC == "0" {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "yearlyIntentionsVC") as! yearlyIntentionsVC
                    self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = self.storyboard?.instantiateViewController(identifier: "IntentionListVC") as! IntentionListVC
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func btnsidemenu(_ sender: Any) {
        self.slideMenuController()?.toggleLeft()
    }
    
    @IBAction func SnapsCountBtnAction(_ sender: Any) {
        SnapsCountPopUp.removeFromSuperview()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == interestCollectionView {
            return hobbiesArray.count
        }else{
            return product_imagesArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == interestCollectionView {
            return 10
        }
        else{
            return 10
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == interestCollectionView {
            return CGSize(width: screenWidth/3-25, height: 34)
        }else{
            return CGSize(width: collectionView.frame.width/2.1, height: collectionView.frame.width/2.1);
        }
        

    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == interestCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! InterestCell
            cell.interestViee.layer.cornerRadius = 5
            cell.interestViee.layer.borderWidth = 0.5
            cell.interestViee.layer.borderColor = UIColor.lightGray.cgColor
            cell.interestImage.image = UIImage(named: hobbiesArray[indexPath.item])
            cell.interstedLbl.text = hobbiesArray[indexPath.item]
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GalleryCell
            
            let dict = self.product_imagesArray[indexPath.row] as? [String:Any] ?? [:]
            
            let profile_image  = DataManager.getVal(dict["images"]) as? String ?? ""
            self.imgBase_url = Config().baseImageUrl + profile_image
            
            
            cell.img.sd_setImage(with: URL(string: self.imgBase_url), placeholderImage: #imageLiteral(resourceName: "default_image"), options: .refreshCached) { (image, error, cachesType, url) in
            }
            
            
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(ImageClicked1(_:)))
            cell.img.isUserInteractionEnabled = true
            cell.img.addGestureRecognizer(tap)
            tap.view?.tag = indexPath.row
            
            
            print(DataManager.getVal(dict["images"]) as? String ?? "")
           
            return cell
        }
        

    }
 
    
    @objc func ImageClicked1(_ sender : UITapGestureRecognizer) {
        let dict = self.product_imagesArray[sender.view?.tag ?? -1]
           let tempurlStr = DataManager.getVal(dict["images"]) as? String ?? ""
           
           let vc = self.storyboard?.instantiateViewController(withIdentifier: "ExpandedImageViewController") as! ExpandedImageViewController
        vc.shouldPrefix = true
           vc.urlStr = tempurlStr
           self.navigationController?.pushViewController(vc, animated: true)
       }

    @IBAction func showStoryBtnAction(_ sender: Any) {
        let vc = SB_instaStory.instantiateViewController(withIdentifier: "PresentStoryViewController") as! PresentStoryViewController
        vc.comerFromTab = "y"
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func addStoryBtnAction(_ sender: Any) {
        let vc = SB_instaStory.instantiateViewController(withIdentifier: "AddStoryVC") as! AddStoryVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func sidemenuBtnAction(_ sender: Any) {
        self.slideMenuController()?.toggleLeft()
       // setSideMenu()
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

}
extension SoulTribeTab3: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ansTable1Count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "qsnAnsTableCellnew", for: indexPath) as! qsnAnsTableCellnew
        cell.qsnLbl.text = self.QsnArray[indexPath.row]
        cell.ansLbl.text = self.AnsArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
