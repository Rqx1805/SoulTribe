//
//  SetprofileVC.swift
//  DemoNew
//
//  Created by mac-9 on 02/07/21.
//

import UIKit
import YYCalendar
import AssetsPickerViewController
import Photos

class uploadimgcollcell: UICollectionViewCell{
    @IBOutlet weak var userimg: UIImageView!
    @IBOutlet weak var  brncross: UIButton!
}

class SetprofileVC: UIViewController {
    
    @IBOutlet weak var btn_sexualityM1: UIButton!
    @IBOutlet weak var btn_sexualityM2: UIButton!
    @IBOutlet weak var btn_sexualityM3: UIButton!
    @IBOutlet weak var btn_sexualityM4: UIButton!
    @IBOutlet weak var btn_sexualityM5: UIButton!
    @IBOutlet weak var btn_sexualityM6: UIButton!
    @IBOutlet weak var btn_sexualityM7: UIButton!
    
    @IBOutlet weak var btn_relationshipM1: UIButton!
    @IBOutlet weak var btn_relationshipM2: UIButton!
    @IBOutlet weak var btn_relationshipM3: UIButton!
    @IBOutlet weak var btn_relationshipM4: UIButton!
    
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
    @IBOutlet weak var minitribereletion4: UIView!
    
    @IBOutlet weak var btnchkM1: UIButton!
    @IBOutlet weak var btnchkM2: UIButton!
    @IBOutlet weak var btnchkM3: UIButton!
    @IBOutlet weak var btnchkM4: UIButton!
    @IBOutlet weak var btnchkM5: UIButton!
    @IBOutlet weak var btnchkM6: UIButton!
    @IBOutlet weak var btnchkM7: UIButton!
    @IBOutlet weak var btnchkM8: UIButton!
    @IBOutlet weak var btnchkM9: UIButton!
    @IBOutlet weak var btnchkM10: UIButton!
    @IBOutlet weak var btnchkM11: UIButton!
    
    var arr_mini_tribe_relationshipStatus : NSMutableArray = []
    var arr_mini_tribe_sexuality : NSMutableArray = []
    
    
    
    @IBOutlet weak var btn_gender5: UIButton!
    @IBOutlet weak var btn_gender4: UIButton!
    @IBOutlet weak var btn_gender6: UIButton!
    @IBOutlet weak var btn_gender3: UIButton!
    @IBOutlet weak var btn_gender2: UIButton!
    
    @IBOutlet weak var showCalenderBtn: UIButton!
    
    var comeFromLogInviewVC = Bool()
    
    @IBAction func btn_profilePicChangeAction(_ sender: UIButton) {
        addingPicssDp = "dp"
        let picker = AssetsPickerViewController()
        let config = AssetsPickerConfig()
        config.albumIsShowEmptyAlbum = false
        
        let options = PHFetchOptions()
        options.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
        options.sortDescriptors = [NSSortDescriptor(key: "duration", ascending: true)]
        
        config.assetFetchOptions = [
            .smartAlbum: options,
            .album: options
        ]
        picker.pickerConfig = config
        picker.pickerDelegate = self
        
        present(picker, animated: true, completion: nil)
        
    }
    @IBOutlet weak var txt_firstImpression: UITextView!
    
    @IBOutlet weak var img_profilePic: UIImageView!
    @IBOutlet weak var constraint_height_collectionVw: NSLayoutConstraint!
    @IBOutlet weak var vw_displayCalendar_submain: UIView!
    @IBOutlet weak var vw_displayCalendar_main: UIView!
    
    @IBOutlet weak var btn_cancel_Calendar: UIButton!
    @IBOutlet weak var btn_continue_Calendar: UIButton!
    
    @IBAction func btn_Cancel_CalendarAction(_ sender: UIButton) {
        showAgePopup = false
        vw_displayCalendar_main.isHidden = true
    }
    
    
    @IBAction func btn_continueCalendarAction(_ sender: UIButton) {
        showAgePopup = false
        vw_displayCalendar_main.isHidden = true
        self.view.endEditing(true)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        
        let today = Date()
        let modifiedDate = Calendar.current.date(byAdding: .year, value: -18, to: today)!
        print(modifiedDate)
        let strDate = formatter.string(from: modifiedDate)
          
        let calendar = YYCalendar(limitedCalendarLangType: .ENG, date: strDate, minDate: nil , maxDate: strDate, format: "yyyy-MM-dd", completion: {date in
                print(date)
                self.selectedDate = date
                self.txt_dob.text = self.selectedDate
                self.txtage.text = "\(basicFunctions.calcAge(birthday: date))"
            })
            
            calendar.headerViewBackgroundColor = Config().AppThemeMainColor.withAlphaComponent(0.3)
            calendar.selectedDayColor = Config().AppThemeMainColor
            calendar.show()
    }
    
    
    @IBOutlet weak var lbl_distanceFormat: UILabel!
    @IBOutlet weak var tableViewDistanceFormat: UITableView!
    
    @IBOutlet weak var profileview: UIView!
    @IBOutlet weak var txtname: UITextField!
    @IBOutlet weak var txtsurname: UITextField!
    @IBOutlet weak var btnnext: UIButton!
    @IBOutlet weak var viewdob: UIView!
    @IBOutlet weak var txtage: UITextField!
    @IBOutlet weak var txtkm: UITextField!
    @IBOutlet weak var viewkm: UIView!
    @IBOutlet weak var viewdiscription: UIView!

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var txt_dob: UITextField!
    @IBOutlet weak var genderview1: UIView!
    @IBOutlet weak var genderview2: UIView!
    @IBOutlet weak var genderview3: UIView!
    @IBOutlet weak var genderview4: UIView!
    @IBOutlet weak var genderview5: UIView!
    @IBOutlet weak var genderview6: UIView!
    @IBOutlet weak var headerview: UIView!
    @IBOutlet weak var btngender1: UIButton!
    @IBOutlet weak var btnchk1: UIButton!
    @IBOutlet weak var btnchk2: UIButton!
    @IBOutlet weak var btnchk3: UIButton!
    @IBOutlet weak var btnchk4: UIButton!
    @IBOutlet weak var btnchk5: UIButton!
    @IBOutlet weak var btnchk6: UIButton!
    @IBOutlet weak var slider: UISlider!
    
    var addingPicssDp = ""
    var genderVal = ""
    var arr_gender : NSMutableArray = []
    var imgarray = ["Group 27152.png"]
    
    var arr_disFormat = ["Km","Mi"]
    var selectedDistanceFormat = "Km"
    var showAgePopup = true
    var selectedDate : String = ""
    
    var arr_assets = [PHAsset]()
    var profilePicAdded = false
    
    var userData = [String:Any]()
    
    var comesFrom = ""
    
    
    var arr_editAsset = [[String:Any]] ()
    var editAssetCount = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        minitribereletion4.layer.cornerRadius = 5
        minitribereletion4.layer.borderWidth = 1
        minitribereletion4.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        txtname.setLeftPaddingPoints(10)
        txtsurname.setLeftPaddingPoints(10)
        txtage.setLeftPaddingPoints(10)
        txtkm.setLeftPaddingPoints(10)
        txt_dob.setLeftPaddingPoints(10)
        
        txt_firstImpression.delegate = self
        txt_firstImpression.text = "Share something that is unique and makes you stand out. Something that makes users want to stop swiping and explore more about you!"
        txt_firstImpression.textColor = UIColor.lightGray
        
        constraint_height_collectionVw.constant = collectionView.frame.width/2.1 + 20
        
        txtage.text = ""
        txtage.isUserInteractionEnabled = false
        
        btn_continue_Calendar.layer.cornerRadius = 8
        btn_cancel_Calendar.layer.cornerRadius = 8
        vw_displayCalendar_submain.layer.cornerRadius = 8
        
        btn_cancel_Calendar.layer.borderWidth = 2
        btn_cancel_Calendar.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        
        viewkm.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectDistanceFormat))
        viewkm.addGestureRecognizer(tap)
          
        viewdob.isUserInteractionEnabled = true
        let tapA = UITapGestureRecognizer(target: self, action: #selector(selectDOB))
        viewdob.addGestureRecognizer(tapA)
        
        self.slider.value = 15
        self.slider.addTarget(self, action: #selector(sliderSlided), for: .valueChanged)

        tableViewDistanceFormat.delegate = self
        tableViewDistanceFormat.dataSource = self
        tableViewDistanceFormat.reloadData()
        
        headerview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        headerview.layer.shadowOpacity = 0.5
        headerview.layer.shadowOffset = .zero
        headerview.layer.shadowRadius = 5
        
        profileview.layer.cornerRadius = 60
        img_profilePic.layer.cornerRadius = img_profilePic.frame.size.width/2
        
        profileview.layer.borderWidth = 2
        profileview.layer.borderColor = #colorLiteral(red: 0.05098039216, green: 0.2274509804, blue: 0.662745098, alpha: 1)
        
        txtname.layer.cornerRadius = 5
        txtname.layer.borderWidth = 1
        txtname.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        txtsurname.layer.cornerRadius = 5
        txtsurname.layer.borderWidth = 1
        txtsurname.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        viewdob.layer.cornerRadius = 5
        viewdob.layer.borderWidth = 1
        viewdob.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        txtage.layer.cornerRadius = 5
        txtage.layer.borderWidth = 1
        txtage.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        txtkm.layer.cornerRadius = 5
        txtkm.layer.borderWidth = 1
        txtkm.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        viewkm.layer.cornerRadius = 5
        viewkm.layer.borderWidth = 1
        viewkm.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        viewdiscription.layer.cornerRadius = 5
        viewdiscription.layer.borderWidth = 1
        viewdiscription.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        genderview1.layer.cornerRadius = 5
        genderview1.layer.borderWidth = 1
        genderview1.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        genderview2.layer.cornerRadius = 5
        genderview2.layer.borderWidth = 1
        genderview2.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        genderview3.layer.cornerRadius = 5
        genderview3.layer.borderWidth = 1
        genderview3.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        genderview4.layer.cornerRadius = 5
        genderview4.layer.borderWidth = 1
        genderview4.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        genderview5.layer.cornerRadius = 5
        genderview5.layer.borderWidth = 1
        genderview5.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        genderview6.layer.cornerRadius = 5
        genderview6.layer.borderWidth = 1
        genderview6.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        btnnext.layer.cornerRadius = 8
        self.slider.setThumbImage(UIImage(named: "Group 27193"), for: .normal)

        txt_dob.isUserInteractionEnabled = false
        
        if comesFrom == "Edit"{
            showAgePopup = false
            api_getData()
            showCalenderBtn.isEnabled = false
            txt_dob.isUserInteractionEnabled = false
            viewdob.isUserInteractionEnabled = false
        }else{
            showCalenderBtn.isEnabled = true
            txt_dob.isUserInteractionEnabled = false
            viewdob.isUserInteractionEnabled = true
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
    
    func api_getData(){
           
        basicFunctions.presentLoader()

        let parameterDictionary = NSMutableDictionary()
        parameterDictionary.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
        let timeZone = TimeZone.current.identifier

        parameterDictionary.setValue(timeZone, forKey: "timezone")
        parameterDictionary.setValue(Config().api_key, forKey: "api_key")
        print(parameterDictionary)

        let methodName = "get_profile"

        DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as! String
            let message  = DataManager.getVal(responseData?["message"]) as! String
            let user_logout_status  = DataManager.getVal(responseData?["user_logout_status"]) as? String ?? ""
            if status == "1" {
                self.userData = DataManager.getVal(responseData?["data"]) as? [String:Any] ?? [:]
                let lat = DataManager.getVal(self.userData["lat"]) as? String ?? ""
                let lng = DataManager.getVal(self.userData["lng"]) as? String ?? ""
                let city = DataManager.getVal(self.userData["city"]) as? String ?? ""
                let state = DataManager.getVal(self.userData["state"]) as? String ?? ""
                
                UserDefaults.standard.setValue(lat, forKey: "lati")
                UserDefaults.standard.setValue(lng, forKey: "longi")
                UserDefaults.standard.setValue(city, forKey: "city")
                UserDefaults.standard.setValue(state, forKey: "state")
                
                let emailNotificationStatus  = DataManager.getVal(self.userData["email_notification"]) as? String ?? ""
                let InAppNotificationStatus  = DataManager.getVal(self.userData["in_app_notification"]) as? String ?? ""
                UserDefaults.standard.setValue(emailNotificationStatus, forKey: "emailNotificationStatus")
                UserDefaults.standard.setValue(InAppNotificationStatus, forKey: "InAppNotificationStatus")
                self.setData()
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
                self.view.makeToast(message, duration: 2.0, position: .bottom, title: nil, image: nil, style: ToastManager.shared.style, completion: nil)
            }
//            self.removeSpinner()
            basicFunctions.stopLoading()
        }
    }
    
    @IBAction func MiniTribesexualtiyM1(_ sender: UIButton) {
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
        selectedBtn(view: minitribesex1, btn: btnchkM1)
        unSelectedBtn(view: minitribesex2, btn: btnchkM2)
        unSelectedBtn(view: minitribesex3, btn: btnchkM3)
        unSelectedBtn(view: minitribesex4, btn: btnchkM4)
        unSelectedBtn(view: minitribesex5, btn: btnchkM5)
        unSelectedBtn(view: minitribesex6, btn: btnchkM6)
        unSelectedBtn(view: minitribesex7, btn: btnchkM7)
        arr_mini_tribe_sexuality.removeAllObjects()
        arr_mini_tribe_sexuality.add("Straight")
    }
    @IBAction func MiniTribelsexualtiyM2(_ sender: UIButton) {
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
        unSelectedBtn(view: minitribesex1, btn: btnchkM1)
        selectedBtn(view: minitribesex2, btn: btnchkM2)
        unSelectedBtn(view: minitribesex3, btn: btnchkM3)
        unSelectedBtn(view: minitribesex4, btn: btnchkM4)
        unSelectedBtn(view: minitribesex5, btn: btnchkM5)
        unSelectedBtn(view: minitribesex6, btn: btnchkM6)
        unSelectedBtn(view: minitribesex7, btn: btnchkM7)
        arr_mini_tribe_sexuality.removeAllObjects()
        arr_mini_tribe_sexuality.add("Gay")
    }
    @IBAction func MiniTribelsexualtiyM3(_ sender: UIButton) {
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
        unSelectedBtn(view: minitribesex1, btn: btnchkM1)
        unSelectedBtn(view: minitribesex2, btn: btnchkM2)
        selectedBtn(view: minitribesex3, btn: btnchkM3)
        unSelectedBtn(view: minitribesex4, btn: btnchkM4)
        unSelectedBtn(view: minitribesex5, btn: btnchkM5)
        unSelectedBtn(view: minitribesex6, btn: btnchkM6)
        unSelectedBtn(view: minitribesex7, btn: btnchkM7)
        arr_mini_tribe_sexuality.removeAllObjects()
        arr_mini_tribe_sexuality.add("Bisexual")
    }
    @IBAction func MiniTribelsexualtiyM4(_ sender: UIButton) {
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
        unSelectedBtn(view: minitribesex1, btn: btnchkM1)
        unSelectedBtn(view: minitribesex2, btn: btnchkM2)
        unSelectedBtn(view: minitribesex3, btn: btnchkM3)
        selectedBtn(view: minitribesex4, btn: btnchkM4)
        unSelectedBtn(view: minitribesex5, btn: btnchkM5)
        unSelectedBtn(view: minitribesex6, btn: btnchkM6)
        unSelectedBtn(view: minitribesex7, btn: btnchkM7)
        arr_mini_tribe_sexuality.removeAllObjects()
        arr_mini_tribe_sexuality.add("Queer")
    }
    @IBAction func MiniTribelsexualtiyM5(_ sender: UIButton) {
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
        unSelectedBtn(view: minitribesex1, btn: btnchkM1)
        unSelectedBtn(view: minitribesex2, btn: btnchkM2)
        unSelectedBtn(view: minitribesex3, btn: btnchkM3)
        unSelectedBtn(view: minitribesex4, btn: btnchkM4)
        selectedBtn(view: minitribesex5, btn: btnchkM5)
        unSelectedBtn(view: minitribesex6, btn: btnchkM6)
        unSelectedBtn(view: minitribesex7, btn: btnchkM7)
        arr_mini_tribe_sexuality.removeAllObjects()
        arr_mini_tribe_sexuality.add("Questioning")
    }
    @IBAction func MiniTribelsexualtiyM6(_ sender: UIButton) {
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
        unSelectedBtn(view: minitribesex1, btn: btnchkM1)
        unSelectedBtn(view: minitribesex2, btn: btnchkM2)
        unSelectedBtn(view: minitribesex3, btn: btnchkM3)
        unSelectedBtn(view: minitribesex4, btn: btnchkM4)
        unSelectedBtn(view: minitribesex5, btn: btnchkM5)
        selectedBtn(view: minitribesex6, btn: btnchkM6)
        unSelectedBtn(view: minitribesex7, btn: btnchkM7)
        arr_mini_tribe_sexuality.removeAllObjects()
        arr_mini_tribe_sexuality.add("Asexual")
    }
    @IBAction func MiniTribelsexualtiyM7(_ sender: UIButton) {
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
        unSelectedBtn(view: minitribesex1, btn: btnchkM1)
        unSelectedBtn(view: minitribesex2, btn: btnchkM2)
        unSelectedBtn(view: minitribesex3, btn: btnchkM3)
        unSelectedBtn(view: minitribesex4, btn: btnchkM4)
        unSelectedBtn(view: minitribesex5, btn: btnchkM5)
        unSelectedBtn(view: minitribesex6, btn: btnchkM6)
        selectedBtn(view: minitribesex7, btn: btnchkM7)
        arr_mini_tribe_sexuality.removeAllObjects()
        arr_mini_tribe_sexuality.add("Other")
    }
    @IBAction func MiniTriberelationM1(_ sender: UIButton) {
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
        selectedBtn(view: minitribereletion1, btn: btnchkM8)
        unSelectedBtn(view: minitribereletion2, btn: btnchkM9)
        unSelectedBtn(view: minitribereletion3, btn: btnchkM10)
        unSelectedBtn(view: minitribereletion4, btn: btnchkM11)
        arr_mini_tribe_relationshipStatus.removeAllObjects()
        arr_mini_tribe_relationshipStatus.add("Single")
    }
    @IBAction func MiniTriberelationM2(_ sender: UIButton) {
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
        unSelectedBtn(view: minitribereletion1, btn: btnchkM8)
        selectedBtn(view: minitribereletion2, btn: btnchkM9)
        unSelectedBtn(view: minitribereletion3, btn: btnchkM10)
        unSelectedBtn(view: minitribereletion4, btn: btnchkM11)
        arr_mini_tribe_relationshipStatus.removeAllObjects()
        arr_mini_tribe_relationshipStatus.add("Married")
    }
    @IBAction func MiniTriberelationM3(_ sender: UIButton) {
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
        unSelectedBtn(view: minitribereletion1, btn: btnchkM8)
        unSelectedBtn(view: minitribereletion2, btn: btnchkM9)
        selectedBtn(view: minitribereletion3, btn: btnchkM10)
        unSelectedBtn(view: minitribereletion4, btn: btnchkM11)
        arr_mini_tribe_relationshipStatus.removeAllObjects()
        arr_mini_tribe_relationshipStatus.add("It's Complicated")
    }
    @IBAction func MiniTriberelationM4(_ sender: UIButton) {
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
        unSelectedBtn(view: minitribereletion1, btn: btnchkM8)
        unSelectedBtn(view: minitribereletion2, btn: btnchkM9)
        unSelectedBtn(view: minitribereletion3, btn: btnchkM10)
        selectedBtn(view: minitribereletion4, btn: btnchkM11)
        arr_mini_tribe_relationshipStatus.removeAllObjects()
        arr_mini_tribe_relationshipStatus.add("In a Relationship")
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
    
//    func setupDataForMiniTribe(){
//        let temp_myRelationshipStatus = (DataManager.getVal(MiniTribeuserData["mini_tribe_relationship_status"]) as? String ?? "").components(separatedBy: ", ")
//        let temp_mySexuality = (DataManager.getVal(MiniTribeuserData["mini_tribe_sexuality"]) as? String ?? "").components(separatedBy: ", ")
//
//
//        for str in temp_mySexuality{
//            if str == "Straight"{
//                minitribesex1.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
//                minitribesex1.layer.borderWidth = 1
//                btnchkM1.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
//                arr_mini_tribe_sexuality.add("Straight")
//                btn_sexualityM1.isSelected = true
//
//            }else if str == "Gay"{
//                minitribesex2.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
//                minitribesex2.layer.borderWidth = 1
//                btnchkM2.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
//                arr_mini_tribe_sexuality.add("Gay")
//                btn_sexualityM2.isSelected = true
//            }else if str == "Bisexual"{
//                minitribesex3.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
//                minitribesex3.layer.borderWidth = 1
//                btnchkM3.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
//                arr_mini_tribe_sexuality.add("Bisexual")
//                btn_sexualityM3.isSelected = true
//            }else if str == "Queer"{
//                minitribesex4.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
//                minitribesex4.layer.borderWidth = 1
//                btnchkM4.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
//                arr_mini_tribe_sexuality.add("Queer")
//                btn_sexualityM4.isSelected = true
//            }else if str == "Questioning"{
//                minitribesex5.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
//                minitribesex5.layer.borderWidth = 1
//                btnchkM5.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
//                arr_mini_tribe_sexuality.add("Questioning")
//                btn_sexualityM5.isSelected = true
//            }else if str == "Asexual"{
//                minitribesex6.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
//                minitribesex6.layer.borderWidth = 1
//                btnchkM6.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
//                arr_mini_tribe_sexuality.add("Asexual")
//                btn_sexualityM6.isSelected = true
//            }else if str == "Other"{
//                minitribesex7.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
//                minitribesex7.layer.borderWidth = 1
//                btnchkM7.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
//                arr_mini_tribe_sexuality.add("Other")
//                btn_sexualityM7.isSelected = true
//            }
//        }
//
//        for str in temp_myRelationshipStatus{
//            if str == "Single"{
//                minitribereletion1.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
//                minitribereletion1.layer.borderWidth = 1
//                btnchkM8.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
//                arr_mini_tribe_relationshipStatus.add("Single")
//                btn_relationshipM1.isSelected = true
//            }else if str == "Married"{
//                minitribereletion2.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
//                minitribereletion2.layer.borderWidth = 1
//                btnchkM9.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
//                arr_mini_tribe_relationshipStatus.add("Married")
//                btn_relationshipM2.isSelected = true
//            }else if str == "It's Complicated"{
//                minitribereletion3.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
//                minitribereletion3.layer.borderWidth = 1
//                btnchkM10.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
//                arr_mini_tribe_relationshipStatus.add("It's Complicated")
//                btn_relationshipM3.isSelected = true
//            }
//        }
//    }
  
    func setData(){
        
        let urlStr = "\(Config().baseImageUrl)\(DataManager.getVal(userData["profile_image"]) as? String ?? "")"
        
        Config().setimage(image_url: urlStr, image_name: img_profilePic)
//        img_profilePic.sd_setImage(with: URL(string: urlStr), completed: nil)
    
        let tap = UITapGestureRecognizer(target: self, action: #selector(ImageClicked(_:)))
        img_profilePic.isUserInteractionEnabled = true
        img_profilePic.addGestureRecognizer(tap)
        
        
        profilePicAdded = true
        
        txtname.text = "\(DataManager.getVal(userData["name"]) as? String ?? "")"
        txtsurname.text = DataManager.getVal(userData["nick_name"]) as? String ?? ""
        
        txt_firstImpression.text = DataManager.getVal(userData["first_impression"]) as? String ?? ""
        
        if txt_firstImpression.text != ""{
            txt_firstImpression.textColor = UIColor.black
        }else{
            txt_firstImpression.text = "Share something that is unique and stands out. Something that makes users want to stop swiping and explore more about you!"
            txt_firstImpression.textColor = UIColor.lightGray
        }
        
        let dis = Float(DataManager.getVal(userData["search_distance"]) as? String ?? "") ?? 0
        slider.value = dis
        txtkm.text = "\(Int(dis))"
        txtage.text = DataManager.getVal(userData["age"]) as? String ?? ""
        txt_dob.text = DataManager.getVal(userData["dob"]) as? String ?? ""
        selectedDate = txt_dob.text ?? ""
        selectedDistanceFormat = "Mi"
        self.lbl_distanceFormat.text = "Mi"
          
        genderVal = DataManager.getVal(userData["gender"]) as? String ?? ""
        let arr = genderVal.components(separatedBy: ", ")
        
        for str in arr{
            if str == "Female" {
                genderview1.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
                genderview1.layer.borderWidth = 1
                btnchk1.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
                arr_gender.add("Female")
                btngender1.isSelected = true
                
            }else if str == "Male"{
                genderview2.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
                genderview2.layer.borderWidth = 1
                btnchk2.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
                arr_gender.add("Male")
                btn_gender2.isSelected = true
            }else if str == "Transgender"{
                genderview3.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
                genderview3.layer.borderWidth = 1
                btnchk3.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
                arr_gender.add("Transgender")
                btn_gender3.isSelected = true
            }else if str == "Gender Fluid"{
                genderview4.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
                genderview4.layer.borderWidth = 1
                btnchk4.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
                arr_gender.add("Gender Fluid")
                btn_gender4.isSelected = true
            }else if str == "Prefer not to say"{
                genderview5.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
                genderview5.layer.borderWidth = 1
                btnchk5.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
                arr_gender.add("Prefer not to say")
                btn_gender5.isSelected = true
            }else if str == "Other"{
                genderview6.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
                genderview6.layer.borderWidth = 1
                btnchk6.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
                arr_gender.add("Other")
                btn_gender6.isSelected = true
            }
        }
        
        self.arr_editAsset = DataManager.getVal(userData["get_product_images"]) as? [[String:Any]] ?? []
        self.editAssetCount = self.arr_editAsset.count
        
        if arr_editAsset.count + 1 > 4{
            constraint_height_collectionVw.constant = (collectionView.frame.width/2.1 * 3) + 20
        }
        else if arr_editAsset.count + 1 > 2{
            constraint_height_collectionVw.constant = (collectionView.frame.width/2.1 * 2) + 20
        }else{
            constraint_height_collectionVw.constant = (collectionView.frame.width/2.1 * 1) + 20
        }
        
        //MARK:- For Mini Tribes
        
        let temp_myRelationshipStatus = (DataManager.getVal(userData["mini_tribe_relationship_status"]) as? String ?? "").components(separatedBy: ", ")
        let temp_mySexuality = (DataManager.getVal(userData["mini_tribe_sexuality"]) as? String ?? "").components(separatedBy: ", ")
          
        for str in temp_mySexuality{
            if str == "Straight"{
                minitribesex1.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
                minitribesex1.layer.borderWidth = 1
                btnchkM1.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
                arr_mini_tribe_sexuality.add("Straight")
                btn_sexualityM1.isSelected = true
            }else if str == "Gay"{
                minitribesex2.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
                minitribesex2.layer.borderWidth = 1
                btnchkM2.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
                arr_mini_tribe_sexuality.add("Gay")
                btn_sexualityM2.isSelected = true
            }else if str == "Bisexual"{
                minitribesex3.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
                minitribesex3.layer.borderWidth = 1
                btnchkM3.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
                arr_mini_tribe_sexuality.add("Bisexual")
                btn_sexualityM3.isSelected = true
            }else if str == "Queer"{
                minitribesex4.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
                minitribesex4.layer.borderWidth = 1
                btnchkM4.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
                arr_mini_tribe_sexuality.add("Queer")
                btn_sexualityM4.isSelected = true
            }else if str == "Questioning"{
                minitribesex5.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
                minitribesex5.layer.borderWidth = 1
                btnchkM5.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
                arr_mini_tribe_sexuality.add("Questioning")
                btn_sexualityM5.isSelected = true
            }else if str == "Asexual"{
                minitribesex6.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
                minitribesex6.layer.borderWidth = 1
                btnchkM6.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
                arr_mini_tribe_sexuality.add("Asexual")
                btn_sexualityM6.isSelected = true
            }else if str == "Other"{
                minitribesex7.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
                minitribesex7.layer.borderWidth = 1
                btnchkM7.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
                arr_mini_tribe_sexuality.add("Other")
                btn_sexualityM7.isSelected = true
            }
        }
        
        for str in temp_myRelationshipStatus{
            if str == "Single"{
                minitribereletion1.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
                minitribereletion1.layer.borderWidth = 1
                btnchkM8.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
                arr_mini_tribe_relationshipStatus.add("Single")
                btn_relationshipM1.isSelected = true
            }else if str == "Married"{
                minitribereletion2.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
                minitribereletion2.layer.borderWidth = 1
                btnchkM9.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
                arr_mini_tribe_relationshipStatus.add("Married")
                btn_relationshipM2.isSelected = true
            }else if str == "It's Complicated"{
                minitribereletion3.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
                minitribereletion3.layer.borderWidth = 1
                btnchkM10.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
                arr_mini_tribe_relationshipStatus.add("It's Complicated")
                btn_relationshipM3.isSelected = true
            }else if str == "In a Relationship"{
                minitribereletion4.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
                minitribereletion4.layer.borderWidth = 1
                btnchkM11.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
                arr_mini_tribe_relationshipStatus.add("In a Relationship")
                btn_relationshipM4.isSelected = true
            }
        }
        collectionView.reloadData()
        
    }
    
    @IBAction func showCalender(_ sender: Any){
        selectDOB()
    }
    
    @objc func ImageClicked(_ sender : UIImageView) {
                       
               let vc = self.storyboard?.instantiateViewController(withIdentifier: "ExpandedImageViewController") as! ExpandedImageViewController
               vc.urlStr = DataManager.getVal(userData["profile_image"]) as? String ?? ""
        vc.shouldPrefix = true
               self.navigationController?.pushViewController(vc, animated: true)
           }
    
    @objc func selectDistanceFormat(){
        //tableViewDistanceFormat.isHidden = !tableViewDistanceFormat.isHidden
    }
    
    @objc func selectDOB(){
        if showAgePopup == true {
            vw_displayCalendar_main.isHidden = false
        }else{
            self.view.endEditing(true)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            
            
            let today = Date()
            let modifiedDate = Calendar.current.date(byAdding: .year, value: -18, to: today)!
            print(modifiedDate)
            let strDate = formatter.string(from: modifiedDate)
              
            let calendar = YYCalendar(limitedCalendarLangType: .ENG, date: strDate, minDate: nil , maxDate: strDate, format: "yyyy-MM-dd", completion: {date in
                    print(date)
                    self.selectedDate = date
                    self.txt_dob.text = self.selectedDate
                    self.txtage.text = "\(basicFunctions.calcAge(birthday: date))"
                })
                
                calendar.headerViewBackgroundColor = Config().AppThemeMainColor.withAlphaComponent(0.3)
                calendar.selectedDayColor = Config().AppThemeMainColor
                calendar.show()
            
        }
    }
    
    
    @objc func sliderSlided (){
        self.txtkm.text = String(Int(self.slider.value) ?? 0)
          
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
    
    func resizeImage1(image: UIImage, targetSize: CGSize) -> UIImage? {
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
       
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    @IBAction func btnnext(_ sender: Any) {
 
        genderVal = arr_gender.componentsJoined(by: ", ")
        
        self.view.endEditing(true)

        if ValidationClass().ValidateProfileSetup1Form(self){

            basicFunctions.presentLoader()

            let parameterDictionary = NSMutableDictionary()

            let deviceToken = DataManager.getVal(Config().AppUserDefaults.object(forKey: "dvcTocken") as? String) as? String ?? ""
            print("ppppppp \(deviceToken)")
            parameterDictionary.setValue(deviceToken, forKey: "device_token")
            parameterDictionary.setValue("2", forKey: "device_type")
            parameterDictionary.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
            
            parameterDictionary.setValue(Config().api_key, forKey: "api_key")
            parameterDictionary.setValue(txtname.text ?? "", forKey: "name")
            parameterDictionary.setValue(txtsurname.text ?? "", forKey: "nick_name")
            parameterDictionary.setValue(genderVal, forKey: "gender")
            parameterDictionary.setValue(txt_dob.text ?? "", forKey: "dob")
            parameterDictionary.setValue(txtage.text ?? "", forKey: "age")
            parameterDictionary.setValue(txtkm.text ?? "", forKey: "search_distance")
            parameterDictionary.setValue(self.arr_mini_tribe_relationshipStatus[0], forKey: "mini_tribe_relationship_status")
            parameterDictionary.setValue(self.arr_mini_tribe_sexuality[0], forKey: "mini_tribe_sexuality")
            
            if txt_firstImpression.textColor == UIColor.lightGray {
                parameterDictionary.setValue("", forKey: "first_impression")
            }else{
                parameterDictionary.setValue(txt_firstImpression.text ?? "", forKey: "first_impression")
            }
            parameterDictionary.setValue("Mi", forKey: "distance_type")
            
            if comesFrom == "Edit"{
                parameterDictionary.setValue("edit", forKey: "type")
            }else{
                parameterDictionary.setValue("add", forKey: "type")
            }
            
            let arr_images = NSMutableArray()
            
            if comesFrom == "Edit"{
                for index in 0..<self.arr_editAsset.count{
                    let dict = arr_editAsset[index]
                    let id = DataManager.getVal(dict["gallery_id"]) as? String ?? ""
                   
                    if id == "abc_abhilasha"{
                        let str = DataManager.getVal(dict["name"]) as? String ?? ""
                        do {
                            let d = try Data(contentsOf: URL(string: str)!)
                            let img = UIImage(data: d)
                            
                            let img1 = img!.jpeg(.lowest)
                            let dataDict = NSMutableDictionary()
                            
                            dataDict.setObject("photos", forKey: "keyName" as NSCopying)
                            dataDict.setObject(img1 ?? Data(), forKey: "MyData" as NSCopying)
                            dataDict.setObject("png", forKey: "ext" as NSCopying)
                            arr_images.add(dataDict)
                            print(arr_images)
                        }catch{
                            print(error)
                        }
                    }
                }
            }else{
                
                for index in 0..<self.arr_assets.count {
                    let asset = arr_assets[index]
                    let img = basicFunctions.getAssetThumbnail(asset: asset)
                    let img1 = img.jpeg(.lowest)
//                    let vc = resizeImage1(image: img, targetSize: CGSize(width: 80, height: 80))
                    let dataDict = NSMutableDictionary()
                        
                    dataDict.setObject("photos", forKey: "keyName" as NSCopying)
                    dataDict.setObject(img1 ?? Data(), forKey: "MyData" as NSCopying)
                    dataDict.setObject("png", forKey: "ext" as NSCopying)
                    arr_images.add(dataDict)
                }
            }
            //For upload image
            let dataArr = NSMutableArray()
            let dataDict = NSMutableDictionary()
            dataDict.setObject("profile_image", forKey: "image" as NSCopying)
            dataDict.setObject(self.img_profilePic.image?.jpeg(.lowest), forKey: "imageData" as NSCopying)
            dataDict.setObject("png", forKey: "imagetype" as NSCopying)
            dataArr.add(dataDict)
            
            print(parameterDictionary)
            print(self.img_profilePic.image)
            print(self.img_profilePic.image?.pngData())
            let methodName = "update_form_one"
            
            DataManager.MultipleImageArrayAndSingleImage(parameterDictionary: parameterDictionary, methodName: methodName, dataArray: arr_images, CertificateArray: dataArr, success: {
                (responseData,error)-> Void in
                    
                    let status = DataManager.getVal(responseData?["status"]) as! String
                    let message = DataManager.getVal(responseData?["message"]) as! String
                     
                    if status == "1" {
                        
                        let data = DataManager.getVal(responseData?["data"]) as? [String:Any] ?? [:]
                        
                        Config().AppUserDefaults.setValue(DataManager.getVal(data["profile_image"]) as? String ?? "", forKey: "user_image")
                        Config().AppUserDefaults.setValue(DataManager.getVal(data["name"]) as? String ?? "", forKey: "user_name")
                        if UserUIimagString ?? "" == UserDefaults.standard.value(forKey: "user_image") as? String  {
                            self.view.makeToast(message)
                            DispatchQueue.main.asyncAfter(deadline: .now()+1.5, execute: {
                                let vc = self.storyboard?.instantiateViewController(identifier: "SetProfilestep2VC") as! SetProfilestep2VC
                                vc.comesFrom = self.comesFrom
                                vc.userData = self.userData
                                self.navigationController?.pushViewController(vc, animated: true)
                            })
                            
                        }else{
                            UserUIimagString = UserDefaults.standard.value(forKey: "user_image") as? String
                            let urll = URL(string: Config().baseImageUrl + UserUIimagString!)!
                            let dataimg = try! Data(contentsOf: urll)
                            UserUIimageData = UIImage(data: dataimg)!
                            self.view.makeToast(message)
                            DispatchQueue.main.asyncAfter(deadline: .now()+1.5, execute: {
                                let vc = self.storyboard?.instantiateViewController(identifier: "SetProfilestep2VC") as! SetProfilestep2VC
                                vc.comesFrom = self.comesFrom
                                vc.userData = self.userData
                                self.navigationController?.pushViewController(vc, animated: true)
                            })
                        }
                    }
                    else {
                        self.view.makeToast(message)
                    }
                    basicFunctions.stopLoading()
            })
        }
    }
    
    @IBAction func btnBack(_ sender: Any) {
        
        if self.comeFromLogInviewVC == false {
            
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
            self.navigationController?.popViewController(animated: true)
        }
        
    }

    @IBAction func btnfemale(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            genderview1.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            genderview1.layer.borderWidth = 1
            btnchk1.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_gender.add("Female")
        }
        else{
            genderview1.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            genderview1.layer.borderWidth = 1
            btnchk1.setImage(UIImage(named: "black circle"), for: .normal)
            arr_gender.remove("Female")
        }
    }
    @IBAction func btnmale(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            genderview2.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            genderview2.layer.borderWidth = 1.5
            btnchk2.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_gender.add("Male")
        }
        else{
            genderview2.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            genderview2.layer.borderWidth = 1
            btnchk2.setImage(UIImage(named: "black circle"), for: .normal)
            arr_gender.remove("Male")
        }
    }
    @IBAction func btntransgender(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            genderview3.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            genderview3.layer.borderWidth = 1.5
            btnchk3.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_gender.add("Transgender")
        }
        else{
            genderview3.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            genderview3.layer.borderWidth = 1
            btnchk3.setImage(UIImage(named: "black circle"), for: .normal)
            arr_gender.remove("Transgender")
        }
    }
    
    
    @IBAction func btnfluidgender(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            genderview4.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            genderview4.layer.borderWidth = 1.5
            btnchk4.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_gender.add("Gender Fluid")
        }
        else{
            genderview4.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            genderview4.layer.borderWidth = 1
            btnchk4.setImage(UIImage(named: "black circle"), for: .normal)
            arr_gender.remove("Gender Fluid")
        }
    }
    @IBAction func btnprefertosay(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            genderview5.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            genderview5.layer.borderWidth = 1.5
            btnchk5.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_gender.add("Prefer not to say")
        }
        else{
            genderview5.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            genderview5.layer.borderWidth = 1
            btnchk5.setImage(UIImage(named: "black circle"), for: .normal)
            arr_gender.remove("Prefer not to say")
        }
    }
    
    @IBAction func btnothergender(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            genderview6.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.7803921569, blue: 0.6039215686, alpha: 1)
            genderview6.layer.borderWidth = 1.5
            btnchk6.setImage(UIImage(named: "Icon awesome-check-circle"), for: .normal)
            arr_gender.add("Other")
        }
        else{
            genderview6.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            genderview6.layer.borderWidth = 1
            btnchk6.setImage(UIImage(named: "black circle"), for: .normal)
            arr_gender.remove("Other")
        }
    }
    
}
extension SetprofileVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if comesFrom == "Edit" {
            return arr_editAsset.count + 1
        }else{
            return arr_assets.count + 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "uploadimgcollcell", for: indexPath) as! uploadimgcollcell

        cell.userimg.layer.cornerRadius = 8
        
        if comesFrom == "Edit" {
            if indexPath.row == arr_editAsset.count {
                cell.userimg.image = UIImage(named: "Group 27152")
                cell.brncross.isHidden = true
            }else{
                let dict = arr_editAsset[indexPath.row]
                
                let addUrl = DataManager.getVal(dict["images"]) as? String ?? ""
                var strUrl = ""
                
                if addUrl != "" {
                    strUrl = "\(Config().baseImageUrl)\(addUrl)"
                }else{
                    strUrl = DataManager.getVal(dict["name"]) as? String ?? ""
                }
             
                do {
                    let d = try Data(contentsOf: URL(string: strUrl)!)
                        cell.userimg.image = UIImage(data: d)
                }catch{
                    print(error)
                }
                cell.brncross.isHidden = false
            }
        }else{
            if indexPath.row == arr_assets.count {
                cell.userimg.image = UIImage(named: "Group 27152")
                cell.brncross.isHidden = true
            }else{
                let asset = arr_assets[indexPath.row]
                let img = basicFunctions.getAssetThumbnail(asset: asset)
                cell.userimg.image = img
                cell.brncross.isHidden = false
            }
        }
        cell.brncross.tag = indexPath.row
        cell.brncross.addTarget(self, action: #selector(deleteAsset(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width/2.1, height: collectionView.frame.width/2.1);

       }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if comesFrom == "Edit"{
            if indexPath.row == arr_editAsset.count {
                addingPicssDp = "pics"
                
                let picker = AssetsPickerViewController()
                let config = AssetsPickerConfig()
                config.albumIsShowEmptyAlbum = false
                if comesFrom != "Edit"{
                    config.selectedAssets = self.arr_assets
                }else{
                    
                }

                let options = PHFetchOptions()
                options.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
                options.sortDescriptors = [NSSortDescriptor(key: "duration", ascending: true)]

                config.assetFetchOptions = [
                    .smartAlbum: options,
                    .album: options
                ]

                picker.pickerConfig = config
                picker.pickerDelegate = self
                present(picker, animated: true, completion: nil)
            }
        }else{
            if indexPath.row == arr_assets.count {
                addingPicssDp = "pics"
                
                let picker = AssetsPickerViewController()
                let config = AssetsPickerConfig()
                config.albumIsShowEmptyAlbum = false
                if comesFrom != "Edit"{
                    config.selectedAssets = self.arr_assets
                }else{
                }

                let options = PHFetchOptions()
                options.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
                options.sortDescriptors = [NSSortDescriptor(key: "duration", ascending: true)]

                config.assetFetchOptions = [
                    .smartAlbum: options,
                    .album: options
                ]

                picker.pickerConfig = config
                picker.pickerDelegate = self
                present(picker, animated: true, completion: nil)
            }
        }
    }
    
    
    @objc func deleteAsset(_ sender : UIButton){
       
        if comesFrom == "Edit" {
            if sender.tag < editAssetCount{
                let deleteAlert = UIAlertController(title: "Delete", message: "Are you sure you want to delete this image?", preferredStyle: UIAlertController.Style.alert)

                deleteAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                    let dict = self.arr_editAsset[sender.tag]
                    let id = DataManager.getVal(dict["id"]) as? String ?? ""
                    self.api_deleteImage(val: id, indexForArray: sender.tag)
                    print("deleteFromWeb")
                }))

                deleteAlert.addAction(UIAlertAction(title: Bundle.main.localizedString(forKey: "Cancel", value: nil, table: "Localizable"), style: .cancel, handler: { (action: UIAlertAction!) in
                }))
                self.present(deleteAlert, animated: true, completion: nil)
                
            }else{
                self.arr_editAsset.remove(at: sender.tag)
                
                if arr_editAsset.count + 1 > 4{
                    constraint_height_collectionVw.constant = (collectionView.frame.width/2.1 * 3) + 20
                }
                else if arr_editAsset.count + 1 > 2{
                    constraint_height_collectionVw.constant = (collectionView.frame.width/2.1 * 2) + 20
                }else{
                    constraint_height_collectionVw.constant = (collectionView.frame.width/2.1 * 1) + 20
                }
                
                self.collectionView.reloadData()
                print("deleteFromAssetsGallery")
            }
        }else{
            self.arr_assets.remove(at: sender.tag)
            if arr_assets.count + 1 > 4{
                constraint_height_collectionVw.constant = (collectionView.frame.width/2.1 * 3) + 20
            }
            else if arr_assets.count + 1 > 2{
                constraint_height_collectionVw.constant = (collectionView.frame.width/2.1 * 2) + 20
            }else{
                constraint_height_collectionVw.constant = (collectionView.frame.width/2.1 * 1) + 20
            }
            self.collectionView.reloadData()
        }
        
    }
    
    @objc func api_deleteImage(val: String, indexForArray : Int){
        self.view.endEditing(true)
            
        basicFunctions.presentLoader()

         
        
        let parameterDictionary = NSMutableDictionary()
        parameterDictionary.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
        parameterDictionary.setValue(Config().api_key, forKey: "api_key")
        parameterDictionary.setValue(val, forKey: "image_id")
        
        print(parameterDictionary)

        let methodName = "delete_image"
        
        DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""

            if status == "1" {
                self.arr_editAsset.remove(at: indexForArray)
                self.editAssetCount -= 1
                self.view.makeToast(message)
                
                if self.arr_editAsset.count + 1 > 4{
                    self.constraint_height_collectionVw.constant = (self.collectionView.frame.width/2.1 * 3) + 20
                }
                else if self.arr_editAsset.count + 1 > 2{
                    self.constraint_height_collectionVw.constant = (self.collectionView.frame.width/2.1 * 2) + 20
                }else{
                    self.constraint_height_collectionVw.constant = (self.collectionView.frame.width/2.1 * 1) + 20
                }
                self.collectionView.reloadData()
            }
            else {
                self.view.makeToast(message)
            }
            basicFunctions.stopLoading()
        }
    }
}


extension SetprofileVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_disFormat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! DistanceFormatTableViewCell
        cell.lbl_title.text = arr_disFormat[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedDistanceFormat = arr_disFormat[indexPath.row]
        self.lbl_distanceFormat.text = "Mi"
        
        tableView.isHidden = true
    }
}


extension SetprofileVC: AssetsPickerViewControllerDelegate {
    
    func assetsPickerCannotAccessPhotoLibrary(controller: AssetsPickerViewController) {}
    func assetsPickerDidCancel(controller: AssetsPickerViewController) {}
    func assetsPicker(controller: AssetsPickerViewController, didSelect asset: PHAsset, at indexPath: IndexPath) {}
    func assetsPicker(controller: AssetsPickerViewController, didDeselect asset: PHAsset, at indexPath: IndexPath) {}
    
    func assetsPicker(controller: AssetsPickerViewController, shouldDeselect asset: PHAsset, at indexPath: IndexPath) -> Bool {
        return true
    }
    
    func assetsPicker(controller: AssetsPickerViewController, shouldSelect asset: PHAsset, at indexPath: IndexPath) -> Bool {
       
        if addingPicssDp == "dp" {
            if controller.selectedAssets.count > 0 {
                controller.photoViewController.deselectAll()
            }
            return true
        }else{
            
             if comesFrom == "Edit"{
                 let totalAssets = self.arr_editAsset.count + controller.selectedAssets.count
                 if totalAssets >= 5 {
                     return false
                 }else{
                     return true
                 }
             }else{
                if controller.selectedAssets.count >= 5 {
                    return false
                }else{
                    return true
                }
             }
        }
    }
    
    func assetsPicker(controller: AssetsPickerViewController, selected assets: [PHAsset]) {
        
        if addingPicssDp == "dp"{
            profilePicAdded = true
            let img = basicFunctions.getAssetThumbnail(asset: assets[0])
            self.img_profilePic.image = img
        }else{
            
            if comesFrom == "Edit"{
                for i in 0..<assets.count {
                    
                    let options: PHContentEditingInputRequestOptions = PHContentEditingInputRequestOptions()
                        options.canHandleAdjustmentData = {(adjustmeta: PHAdjustmentData) -> Bool in
                            return true
                        }
                    assets[i].requestContentEditingInput(with: options, completionHandler: { (contentEditingInput, info) in
                       
                        let urlStr = contentEditingInput!.fullSizeImageURL?.absoluteString
                        let dict = ["name" :"\(urlStr ?? "")","gallery_id":"abc_abhilasha"]
                        self.arr_editAsset.append(dict)
                        
                        if self.arr_editAsset.count + 1 > 4 {
                            self.constraint_height_collectionVw.constant = (self.collectionView.frame.width/2.1 * 3) + 20
                        }
                        else if self.arr_editAsset.count + 1 > 2 {
                            self.constraint_height_collectionVw.constant = (self.collectionView.frame.width/2.1 * 2) + 20
                        }
                        else {
                            self.constraint_height_collectionVw.constant = (self.collectionView.frame.width/2.1 * 1) + 20
                        }
                        
                        self.collectionView.reloadData()
                    })
                }
            }else{
                arr_assets = assets
                if arr_assets.count + 1 > 4{
                    constraint_height_collectionVw.constant = (collectionView.frame.width/2.1 * 3) + 20
                }
                else if arr_assets.count + 1 > 2{
                    constraint_height_collectionVw.constant = (collectionView.frame.width/2.1 * 2) + 20
                }
                else {
                    constraint_height_collectionVw.constant = (collectionView.frame.width/2.1 * 1) + 20
                }
            }
            collectionView.reloadData()
        }
    }
}

extension SetprofileVC : UITextViewDelegate{
    //MARK:- Textview Delegates
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if txt_firstImpression.textColor == UIColor.lightGray {
            txt_firstImpression.text = ""
            txt_firstImpression.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if txt_firstImpression.text == "" {
            txt_firstImpression.text = "Share something that is unique and stands out. Something that makes users want to stop swiping and explore more about you!"
            txt_firstImpression.textColor = UIColor.lightGray
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if txt_firstImpression.text.count == 200 {
            self.view.makeToast("Text limit exceeded")
            return false
        }else{
            return txt_firstImpression.text.count + (text.count - range.length) <= 200
        }
    }
    
}
