//
//  MessageVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 29/06/21.
//

import UIKit
import SocketIO
import IQKeyboardManagerSwift
import SDWebImage
import Agrume
import MobileCoreServices
import GrowingTextView

class MessageSend: UITableViewCell{
    @IBOutlet weak var imgSend: UIImageView!
    @IBOutlet weak var imgSendBg: UIImageView!
    @IBOutlet weak var lblMessageSend: UILabel!
    @IBOutlet weak var  lblSendTime: UILabel!

}
class MessageRec: UITableViewCell{
    @IBOutlet weak var  imgRec: UIImageView!
    @IBOutlet weak var  imgRecBg: UIImageView!
    @IBOutlet weak var lblMessageRec: UILabel!
    @IBOutlet weak var lblRecTime: UILabel!
}

class MessageVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,GrowingTextViewDelegate {
    
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var BuyPremiumPlanPopUp: UIView!
    @IBOutlet weak var BuyPremiumPlanPopUpPopUpCornerRadius: UIView!
    @IBOutlet weak var BuyPremiumPlanPopUpPopUp_UpgradeBtn: UIButton!
    @IBOutlet weak var BuyPremiumPlanPopUpPopUp_TitleTextLbl: UILabel!
    
    @IBOutlet weak var optionView1: UIView!
    @IBOutlet weak var optionView1CornerRadius: UIView!
    @IBOutlet weak var alphaView_Continue: UIButton!
    @IBOutlet weak var alphaView_Cancel: UIButton!
    @IBOutlet weak var block_report_lbl: UILabel!
    @IBOutlet weak var block_report_Sublbl: UILabel!
    
    @IBOutlet weak var SnapsCountPopUp: UIView!
    @IBOutlet weak var SnapsCountPopUpCornerRadius: UIView!
    @IBOutlet weak var SnapsCountPopUp_CancelBtn: UIButton!
    
    @IBOutlet weak var HeaderView: MyView!
    @IBOutlet weak var UserImgView: UIImageView!
    @IBOutlet weak var UserNameLbl: UILabel!
    @IBOutlet weak var OnlineOfflineLbl: MyLabel!
    @IBOutlet weak var StatusLbl: UILabel!
    @IBOutlet weak var ChatTblView: UITableView!
    @IBOutlet weak var MessageTxtField: GrowingTextView!
    
    @IBOutlet weak var BgScrollView: UIScrollView!
    @IBOutlet weak var AttachmentButton: ResponsiveButton!
    @IBOutlet weak var AttachmentWidthConstraint: NSLayoutConstraint!//30
    @IBOutlet weak var MainScrollBackView: UIView!
    @IBOutlet weak var SendImage: UIImageView!
    @IBOutlet weak var chatUserImageBtn: UIButton!
    @IBOutlet weak var sendImageWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var storyGradientView: UIView!
    
    @IBOutlet weak var BottomView: MyView!
    @IBOutlet weak var BottomSpaceConstraint: NSLayoutConstraint!
    @IBOutlet weak var BottomViewHeightConstraint: NSLayoutConstraint!//60
    @IBOutlet weak var MessagetxtHeightConst: NSLayoutConstraint!
    
  
    var typeDirect = String()
    var snapsCount = String()
    var gradient = CAGradientLayer()
    var Come_chatUser_ID = String()
    var loginUser_ID = String()
    var MessageListArray = NSMutableArray()
    var ChatReceiverID = String()
    var businessId = String()
    var message_type = String()
    var image_array = [Any]()
    var file_extantion = String()
    var Come_user_profile_image = String()
    var newuserprofileid = String()
    var timer = Timer()
    var Come_userName = String()
    var provider_business_id = String()
    var mes:String!
    var mes1:String!
    var come_RoomID = String()
    var socketType = String()
    var comeFromProfile = String()
    var notitficatioData = [String:Any]()
    var isComeFromPushNotitfication = String()
    @IBOutlet weak var MessageV:UIView!
    @IBOutlet weak var MessageVConst:NSLayoutConstraint!
    @IBOutlet weak var messLbl:UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loginUser_ID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
        self.sendImageWidthConstraint.constant = 0
        print(businessId)
        self.timer.invalidate()
        MessageTxtField.delegate = self
//        IQKeyboardManager.shared.enableAutoToolbar = true
 //   SocketIoManager.one_to_one_sharedInstance.establishConnection()
   // SocketIoManager.one_to_one_sharedInstance.connectToServerWithRoom1(nickname: "joinroom")
       // MessageTxtField.delegate = self
       // MessageTxtField.addTarget(self, action: #selector(searchRecordsAsPerText(_ :)), for: .editingChanged)
        
    }
    

    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if MessageTxtField.text?.count == 50 {
            self.BottomViewHeightConstraint.constant = 60
            self.MessagetxtHeightConst.constant = 40
        }else if MessageTxtField.text!.count > 50{
            self.BottomViewHeightConstraint.constant = 90
            self.MessagetxtHeightConst.constant = 70
        }else if MessageTxtField.text!.count > 100{
            self.BottomViewHeightConstraint.constant = 120
            self.MessagetxtHeightConst.constant = 100
        }else if MessageTxtField.text!.count > 150{
            self.BottomViewHeightConstraint.constant = 150
            self.MessagetxtHeightConst.constant = 130
        }else{
            self.BottomViewHeightConstraint.constant = 60
            self.MessagetxtHeightConst.constant = 40
        }
    }
    

  
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        var dict = [String: Any]()
        dict = ["room": self.come_RoomID,"userid": self.loginUser_ID]
        RId = self.come_RoomID
        lid = self.loginUser_ID
        print(dict)
        var array = [Any]()
        array.append(dict)
        SocketIoManager.one_to_one_sharedInstance.socket.emit("login", dict)
        SocketIoManager.one_to_one_sharedInstance.socket.connect()
        SocketIoManager.one_to_one_sharedInstance.establishConnection()
       // DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            SocketIoManager.one_to_one_sharedInstance.connectToServerWithRoom(nickname: "joinroom")
       // }
        
    }
    func json(from object:Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        Config().AppUserDefaults.setValue("off", forKey: "chat")
      //  IQKeyboardManager.shared.enableAutoToolbar = true
       // self.timer.invalidate()
       // var dict = [String: Any]()//
       // dict = ["room": self.come_RoomID,"userid": self.loginUser_ID]
       // print(dict)
       // SocketIoManager.one_to_one_sharedInstance.socket.emit("logout", dict)
        SocketIoManager.one_to_one_sharedInstance.socket.disconnect()
        SocketIoManager.one_to_one_sharedInstance.removeAllHandlers()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Config().AppUserDefaults.setValue("on", forKey: "chat")
        if self.isComeFromPushNotitfication == "yes" {
            let comeRoomId = DataManager.getVal(self.notitficatioData["room"]) as? String ?? ""
            let senderId = DataManager.getVal(self.notitficatioData["sender_id"]) as? String ?? ""
            let senderImage = DataManager.getVal(self.notitficatioData["sender_image"]) as? String ?? ""
            let senderName = DataManager.getVal(self.notitficatioData["sender_name"]) as? String ?? ""
            let vibe = DataManager.getVal(self.notitficatioData["vibe"]) as? String ?? ""
            let snpCount = DataManager.getVal(self.notitficatioData["snaps_count"]) as? String ?? ""
            self.come_RoomID = comeRoomId
            self.Come_chatUser_ID = senderId
            self.Come_user_profile_image = "\(Config().baseImageUrl)\(senderImage)"
            
            self.Come_userName = senderName
            self.snapsCount = snpCount
            SELECT_VIBE = vibe
            
            print(senderImage)
        }
    
       
        chatStatus()
        self.storyGradientView.layer.cornerRadius = self.storyGradientView.frame.height/2
        
        
        BuyPremiumPlanPopUpPopUpCornerRadius.layer.cornerRadius = 8
        BuyPremiumPlanPopUpPopUp_UpgradeBtn.layer.cornerRadius = 8
        SnapsCountPopUpCornerRadius.layer.cornerRadius = 6
        SnapsCountPopUp_CancelBtn.layer.cornerRadius = 6
        
        //MessageTxtField.setLeftPaddingPoints(10)
        optionView1CornerRadius.layer.cornerRadius = 6
        alphaView_Continue.layer.cornerRadius = 6
        self.UserNameLbl.text = self.Come_userName
//        UserImgView.sd_setImage(with: URL(string: self.Come_user_profile_image), completed: nil)
        Config().setimage(image_url: self.Come_user_profile_image, image_name: UserImgView)
        UserImgView.layer.cornerRadius = UserImgView.frame.height/2
        loginUser_ID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""

//        HeaderView.layer.shadowColor = UIColor.red.cgColor
//        HeaderView.layer.shadowOpacity = 0.5
//        HeaderView.layer.shadowOffset = .zero
//        HeaderView.layer.shadowRadius = 5
//        self.StatusLbl.text = mes
        
        
        let Sender_nibClass = UINib(nibName: "SenderTableCell", bundle: nil)
        self.ChatTblView.register(Sender_nibClass, forCellReuseIdentifier: "SenderTableCell")
        
        let Reciver_nibClass = UINib(nibName: "ReciverTableCell", bundle: nil)
        self.ChatTblView.register(Reciver_nibClass, forCellReuseIdentifier: "ReciverTableCell")
        
        let ReciverImage_nibClass = UINib(nibName: "ReciverImageTableCell", bundle: nil)
        self.ChatTblView.register(ReciverImage_nibClass, forCellReuseIdentifier: "ReciverImageTableCell")
        
        let SenderImage_nibClass = UINib(nibName: "SenderImageTableCell", bundle: nil)
        self.ChatTblView.register(SenderImage_nibClass, forCellReuseIdentifier: "SenderImageTableCell")
        
        self.ChatTblView.rowHeight = UITableView.automaticDimension
        self.ChatTblView.dataSource = self
        self.ChatTblView.delegate = self
        
//        if UIDevice().userInterfaceIdiom == .phone {
//            switch UIScreen.main.nativeBounds.height {
//            case 1136:
//                print("iPhone 5 or 5S or 5C")
//                self.BottomSpaceConstraint.constant = 0
//            case 1334:
//                print("iPhone 6/6S/7/8")
//                self.BottomSpaceConstraint.constant = 0
//            case 1920, 2208:
//                print("iPhone 6+/6S+/7+/8+")
//                self.BottomSpaceConstraint.constant = 0
//            case 2436:
//                print("iPhone X/XS/11 Pro")
//                self.BottomSpaceConstraint.constant = 30
//            case 2688:
//                print("iPhone XS Max/11 Pro Max")
//                self.BottomSpaceConstraint.constant = 30
//            case 1792:
//                print("iPhone XR/ 11 ")
//                self.BottomSpaceConstraint.constant = 30
//            default:
//                print("Unknown")
//                self.BottomSpaceConstraint.constant = 30
//            }
//        }
        
        //        if DataManager.isConnectedToNetwork() == true{
        //            self.UserChat_API()
        //        }else{
        //            self.MessageListArray = DataManager.getVal(Config().AppUserDefaults.value(forKey: "ChatList")) as? [Any] ?? []
        //        }
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.new_showChatMessage(_:)), name: NSNotification.Name(rawValue: "new_message_coming"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.showChatMessage(_:)), name: NSNotification.Name(rawValue: "notificationNameStudent"), object: nil)
        
       //NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willTerminateNotification, object: nil)
        self.ChatTblView.keyboardDismissMode = .onDrag
        
                DispatchQueue.global(qos: .background).async {
                    DispatchQueue.main.async {
                        self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.ChatAPI), userInfo: nil, repeats: true)
                    }
                }
        self.sendBtn.isHidden = true
        self.AttachmentButton.isHidden = true
        self.UserChat_API()
        // Do any additional setup after loading the view.
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
    
//    @objc func willEnterForeground(notification: NSNotification) {
//        var dict = [String: Any]()
//        dict = ["role": "1","profile": self.loginUser_ID,"room": self.come_RoomID]
//        print(dict)
//        SocketIoManager.one_to_one_sharedInstance.socket.emit("logout", dict)
//        SocketIoManager.one_to_one_sharedInstance.socket.disconnect()
//    }
    
    //MARK:- keyboard Delegates
      @objc func showChatMessage(_ notification: NSNotification) {
          var dict = NSMutableArray()
          dict = notification.object as? NSMutableArray ?? []
          self.MessageListArray.removeAllObjects()
          
          self.MessageListArray.addObjects(from: dict as? [Any] ?? [])
//          self.MessageListArray.addObjects(from: dict as? [Any] ?? [])
          ChatTblView.reloadData()
          
          if self.MessageListArray.count > 0 {
              self.ChatTblView.scrollToRow(at: IndexPath(row: self.MessageListArray.count - 1, section: 0), at: .top, animated: false)
          }
      }
    
    @objc func new_showChatMessage(_ notification: NSNotification) {
        print("new message aaya")
        var dict = NSMutableDictionary()
        dict = notification.object as! NSMutableDictionary
        print(dict)
        
        self.MessageListArray.add(dict)
        self.ChatTblView.reloadData()
        self.scrollToBottom()
        self.sendBtn.isHidden = false
        self.AttachmentButton.isHidden = false
        self.sendBtn.isUserInteractionEnabled = true
        self.MessageV.isHidden = true
        self.MessageVConst.constant = 0
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "new_message_coming"), object: dict)
    }
    
    @objc func ChatAPI(){
       // SocketIoManager.one_to_one_sharedInstance.connectToServerWithRoom(nickname: "joinroom")
    }
    
    @IBAction func Confirm_Block(_ sender: Any) {
        if self.block_report_lbl.text == "Block Profile" {
            self.BlockAPI()
            self.optionView1.removeFromSuperview()
            self.UserChat_API()
        }else if self.block_report_lbl.text == "Delete Chat"{
            self.ChatMessageDeleteAPI(room: self.come_RoomID)
            self.optionView1.removeFromSuperview()
        }else if self.block_report_lbl.text == "Report Profile"{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReportPopUpVC") as! ReportPopUpVC
            vc.GetSwipeUserID = Int(self.Come_chatUser_ID) ?? 0
            vc.getUserName = self.Come_userName
            vc.GetAddress = ""
            vc.GetImageStr = self.Come_user_profile_image
            self.navigationController?.pushViewController(vc, animated: true)
            self.optionView1.removeFromSuperview()
        }
    }
    @IBAction func cancel_block(_ sender: Any) {
        self.optionView1.removeFromSuperview()
    }
    func sendDataToApiForPushNotification(message1: String){
        //self.pleaseWait()
       // self.HeaderView.showLoader()//
      //  self.MainScrollBackView.showLoader()

        let Dict = NSMutableDictionary()
        Dict.setValue(DataManager.getVal(self.loginUser_ID), forKey: "sender_id")
        let name1 = Config().AppUserDefaults.value(forKey:"user_name") as? String ?? ""
//        Dict.setValue(DataManager.getVal(""), forKey: "messgae")
        Dict.setValue(DataManager.getVal(Config().api_key), forKey: "api_key")
        Dict.setValue(DataManager.getVal(self.come_RoomID), forKey: "room")
        Dict.setValue(DataManager.getVal(self.Come_chatUser_ID), forKey: "receiver_id")
        Dict.setValue(DataManager.getVal(name1), forKey: "title")
        
        if SELECT_VIBE == ""
        {
            Dict.setValue(DataManager.getVal("Mini Tribes"), forKey: "vibe")
        }
        else{
            Dict.setValue(DataManager.getVal(SELECT_VIBE), forKey: "vibe")
        }
        
        Dict.setValue(DataManager.getVal(message1), forKey: "message")
        print(Dict)
        let methodName = "send_notification_receiver"

        DataManager.getAPIResponse(Dict,methodName: methodName, methodType: "POST") { (responseData,error) -> Void in

            DispatchQueue.main.async(execute: {

                let status = DataManager.getVal(responseData?.object(forKey: "status")) as? String ?? ""

                if status == "1" {
                   print("gya")
                }
            })
        }
    }
    func UserChat_API(){
        //self.pleaseWait()
       // self.HeaderView.showLoader()//
      //  self.MainScrollBackView.showLoader()

        let Dict = NSMutableDictionary()
        Dict.setValue(DataManager.getVal(self.loginUser_ID), forKey: "user_id")
//        Dict.setValue(DataManager.getVal(""), forKey: "messgae")
        let timeZone = TimeZone.current.identifier
        Dict.setValue(DataManager.getVal(timeZone), forKey: "timezone")
        Dict.setValue(DataManager.getVal(Config().api_key), forKey: "api_key")
        Dict.setValue(DataManager.getVal(self.come_RoomID), forKey: "room")
        
        if SELECT_VIBE == ""{
            Dict.setValue(DataManager.getVal ("Mini Tribes"), forKey: "vibe")
        }
        else{
            Dict.setValue(DataManager.getVal(SELECT_VIBE), forKey: "vibe")
        }
       

        print(Dict)
        let methodName = "get_old_messages_list"

        DataManager.getAPIResponse(Dict,methodName: methodName, methodType: "POST") { (responseData,error) -> Void in

            DispatchQueue.main.async(execute: {

                let status = DataManager.getVal(responseData?.object(forKey: "status")) as? String ?? ""

                if status == "1" {
                    let dict = DataManager.getVal(responseData?.object(forKey: "data")) as! NSDictionary
                    self.MessageListArray = DataManager.getVal(dict["messages"]) as! NSMutableArray
                    let directMessageStatus = DataManager.getVal(dict["direct_message_status"]) as? String ?? ""
                    let snapCount1 = DataManager.getVal(dict["snaps_count"]) as? String ?? ""
                    
                    if snapCount1 == "0" {
                        self.gradient.removeFromSuperlayer()
                        self.storyGradientView.layer.backgroundColor = UIColor.white.cgColor
                    }else{
                        self.storyGradientView.layer.cornerRadius = self.storyGradientView.frame.height/2
                        self.gradient.cornerRadius = self.storyGradientView.layer.cornerRadius
                        self.gradient.frame = self.storyGradientView.frame
                        self.gradient.colors = [UIColor(red: 0.42, green: 0.39, blue: 1.00, alpha: 1.00).cgColor,UIColor(red: 0.05, green: 0.23, blue: 0.66, alpha: 1.00).cgColor,UIColor(red: 0.10, green: 0.55, blue: 0.65, alpha: 1.00).cgColor,UIColor(red: 0.14, green: 0.90, blue: 0.71, alpha: 1.00).cgColor]
                        self.storyGradientView.layer.insertSublayer(self.gradient, at: 0)
                        self.gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
                        self.gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
                        self.gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.storyGradientView.frame.size.width, height: self.storyGradientView.frame.size.height)
                    }
                    if self.typeDirect == "direct" && directMessageStatus == "0" {
                       if self.MessageListArray.count == 1 {
                           let dict = DataManager.getVal(self.MessageListArray[0]) as! NSDictionary
                            if let senderId = DataManager.getVal(dict["sender_id"]) as? String {
                               if senderId == self.loginUser_ID {
                                    self.sendBtn.isHidden = true
                                    self.AttachmentButton.isHidden = true
                                   self.sendBtn.isUserInteractionEnabled = false
                                   self.MessageV.isHidden = false
                                    self.messLbl.text = "This user is not a match. You are only allowed to send 1 message until this user responds."
                                } else {
                                    self.sendBtn.isHidden = false
                                    self.AttachmentButton.isHidden = false
                                    self.sendBtn.isUserInteractionEnabled = true
                                    self.MessageV.isHidden = false
                                    self.messLbl.text = "This user is not a match and can only send you 1 message. If you reply, this user will be able to send you more messages."
                                }
                            }
                       }else if self.MessageListArray.count >= 1 {
                           self.sendBtn.isHidden = false
                           self.AttachmentButton.isHidden = false
                           self.sendBtn.isUserInteractionEnabled = true
                           self.MessageV.isHidden = true
                           self.MessageVConst.constant = 0
                       } else {
                           self.sendBtn.isHidden = false
                           self.AttachmentButton.isHidden = false
                           self.sendBtn.isUserInteractionEnabled = true
                           self.MessageV.isHidden = false
                           self.messLbl.text = "This user is not a match. You are only allowed to send 1 message until this user responds."
                       }
                        self.MessageVConst.constant = 80
                        
                    } else if self.typeDirect == "showMessage" {
                        self.sendBtn.isHidden = false
                        self.AttachmentButton.isHidden = false
                        self.sendBtn.isUserInteractionEnabled = true
                        self.MessageV.isHidden = false
                        self.MessageVConst.constant = 80
                        self.messLbl.text = "This user is not a match and can only send you 1 message. If you reply, this user will be able to send you more messages."
                    }
                    else{
                        if directMessageStatus == "1" {
                            self.sendBtn.isHidden = true
                            self.AttachmentButton.isHidden = true
                            self.sendBtn.isUserInteractionEnabled = false
                            self.MessageV.isHidden = false
                            self.MessageVConst.constant = 80
                            self.messLbl.text = "This user is not a match. You are only allowed to send 1 message until this user responds."
                        }else{
                            self.sendBtn.isHidden = false
                            self.AttachmentButton.isHidden = false
                            self.sendBtn.isUserInteractionEnabled = true
                            self.MessageV.isHidden = true
                            self.MessageVConst.constant = 0
                        }
                    }
                    
                    Config().AppUserDefaults.setValue(self.MessageListArray, forKey: "ChatList")
                    self.ChatTblView.reloadData()
                    self.ChatTblView.backgroundView = nil
                    if self.MessageListArray.count != 0{
                        self.scrollToBottom()
                    }
                }
                //self.clearAllNotice()
            })
        }
    }
    
//    func userChatStatus_API1(user_profileid: String){
//        let Dict = NSMutableDictionary()
//        Dict.setValue(DataManager.getVal(""), forKey: "userid")
//        Dict.setValue(DataManager.getVal(""), forKey: "userkey")
//        Dict.setValue(DataManager.getVal(""), forKey: "user_profile_id")
//        Dict.setValue(DataManager.getVal(""), forKey: "status")
//
//        let methodName = "userChatStatus"
//
//        DataManager.getAPIResponse(Dict,methodName: methodName, methodType: "POST") { (responseData,error) -> Void in
//
//            let status = DataManager.getVal(responseData?.object(forKey: "status")) as? String ?? ""
//            //let message = DataManager.getVal(responseData?.object(forKey: "message")) as? String ?? ""
//
//            if status == "1" {
//                if let dict = DataManager.getVal(responseData?.object(forKey: "values")) as? NSDictionary{
//                    let chat_status = DataManager.getVal(dict["chat_status"]) as? String ?? ""
//                    if chat_status == "1"{
//                        self.StatusLbl.text = self.mes
//                        self.OnlineOfflineLbl.isHidden = false
//                    }else{
//                        self.StatusLbl.text = self.mes1
//                        self.OnlineOfflineLbl.isHidden = true
//                    }
//                }
//            }
//        }
//    }
    
//    func userChatStatus_API(user_profileid: String){
//
//       // self.pleaseWait()
//
//        let Dict = NSMutableDictionary()
//        Dict.setValue(DataManager.getVal(self.loginUser_ID), forKey: "userid")
//        Dict.setValue(DataManager.getVal(Config().api_key), forKey: "api_key")
//        Dict.setValue(DataManager.getVal(""), forKey: "user_profile_id")
//        Dict.setValue(DataManager.getVal(""), forKey: "status")
//
//        let methodName = "userChatStatus"
//
//        DataManager.getAPIResponse(Dict,methodName: methodName, methodType: "POST") { (responseData,error) -> Void in
//
//            let status = DataManager.getVal(responseData?.object(forKey: "status")) as? String ?? ""
//            let message = DataManager.getVal(responseData?.object(forKey: "message")) as? String ?? ""
//
//            if status == "1" {
//                if let dict = DataManager.getVal(responseData?.object(forKey: "values")) as? NSDictionary{
//                    let chat_status = DataManager.getVal(dict["chat_status"]) as? String ?? ""
//                    if chat_status == "1"{
//                        self.StatusLbl.text = self.mes
//                        self.OnlineOfflineLbl.isHidden = false
//                    }else{
//                        self.StatusLbl.text = self.mes1
//                        self.OnlineOfflineLbl.isHidden = true
//                    }
//                }
//            }else{
//               // Config().error(message: message)
//            }
//          //  self.clearAllNotice()
//        }
//    }
    
//    @objc func ReportButtonAction(sender: UIButton){
//
//        var mes:String!
//        var mes1:String!
//        var mes2:String!
//        var mes3:String!
//        var mes4:String!
//
//        mes  = "Delete"
//        mes1 = "Cancel"
//        mes2 = "Please Select"
//        mes3 = "Block"
//        mes4 = "Block & Delete"
//
//            let actionSheetController = UIAlertController(title: mes2, message: "", preferredStyle: .actionSheet)
//
//            let cancelAction = UIAlertAction(title: mes1, style: .cancel) { action -> Void in
//            }
//            actionSheetController.addAction(cancelAction)
//
//            let takePictureAction = UIAlertAction(title: mes, style: .default) { action -> Void in
////                self.ChatMessageDeleteAPI(room: self.come_RoomID)
//            }
//            actionSheetController.addAction(takePictureAction)
//
//            let BlockAction = UIAlertAction(title: mes3, style: .destructive) { action -> Void in
////                self.BlockAPI()
//            }
//            actionSheetController.addAction(BlockAction)
//
//            let BlockanddeleteAction = UIAlertAction(title: mes4, style: .destructive) { action -> Void in
////                self.BlockAndDeleteAPI()
//            }
//            actionSheetController.addAction(BlockanddeleteAction)
//            actionSheetController.popoverPresentationController?.sourceView = sender as UIView
//
//            self.present(actionSheetController, animated: true, completion: nil)
//
//    }
    
    @IBAction func MediaButtonAction(_ sender: ResponsiveButton) {
        
        var mes:String!
        var mes1:String!
        var mes2:String!
        var mes3:String!
        var mes4:String!
        
            mes = "Document/File"
            mes1 = "Photo Library"
            mes2 = "Choose your source"
            mes3 = "Camera"
            mes4 = "Cancel"

        let Picker = UIImagePickerController()
        Picker.delegate = self
        
        let actionSheet = UIAlertController(title: nil, message: mes2, preferredStyle: UIAlertController.Style.actionSheet)
        actionSheet.modalPresentationStyle = .popover
        actionSheet.addAction(UIAlertAction(title: mes3, style: .default, handler: {(action:UIAlertAction) in
            
            Picker.sourceType = .camera
            self.present(Picker, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: mes1, style: .default, handler: {(action:UIAlertAction) in
            
            Picker.sourceType = .photoLibrary
            self.present(Picker, animated: true, completion: nil)
        }))
//        actionSheet.addAction(UIAlertAction(title: mes, style: .default, handler: {(action:UIAlertAction) in
//            let importMenu = UIDocumentMenuViewController(documentTypes: [String(kUTTypePDF),String(kUTTypeText),String(kUTTypeContent),String(kUTTypeItem),String(kUTTypeData)], in: .import)
//            importMenu.delegate = self
//            importMenu.modalPresentationStyle = .formSheet
//            self.present(importMenu, animated: true, completion: nil)
//
//        }))
        if let popoverPresentationController = actionSheet.popoverPresentationController {
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.sourceRect = sender.bounds
        }
        actionSheet.addAction(UIAlertAction(title: mes4, style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    @IBAction func optionBlockReport(_ sender: UIButton) {
               
            let actionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
                
            }
            actionSheetController.addAction(cancelAction)
        let viewProfile = UIAlertAction(title: "View Profile", style: .default) { action -> Void in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileController") as! ProfileController
            vc.swipeUserID = Int(self.Come_chatUser_ID)!
//            vc.picturesArray = self.picturesArray
            vc.vibeType = SELECT_VIBE
            self.navigationController?.pushViewController(vc, animated: true)
//                self.ChatMessageDeleteAPI(room: self.come_RoomID)
            }
            actionSheetController.addAction(viewProfile)
        let DeleteAction = UIAlertAction(title: "Delete Chat", style: .default) { action -> Void in
            self.block_report_lbl.text = "Delete Chat"
            self.block_report_Sublbl.text = "Are you sure you would like to Delete all chat?"
            self.alphaView_Continue.setTitle("Delete", for: .normal)
            self.optionView1.frame = self.view.frame
            self.optionView1.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            self.view.addSubview(self.optionView1)
                
            }
            actionSheetController.addAction(DeleteAction)
        let blockAction = UIAlertAction(title: "Block", style: .default) { action -> Void in
            self.block_report_lbl.text = "Block Profile"
            self.block_report_Sublbl.text = "Are you sure you would like to block this user?"
            self.alphaView_Continue.setTitle("Block", for: .normal)
            self.optionView1.frame = self.view.frame
            self.optionView1.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            self.view.addSubview(self.optionView1)
        }
        actionSheetController.addAction(blockAction)
        let reportAction = UIAlertAction(title: "Report", style: .default) { action -> Void in
            self.block_report_lbl.text = "Report Profile"
            self.block_report_Sublbl.text = "Are you sure you would like to Report this user?"
            self.alphaView_Continue.setTitle("Report", for: .normal)
            self.optionView1.frame = self.view.frame
            self.optionView1.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            self.view.addSubview(self.optionView1)
//                self.ChatMessageDeleteAPI(room: self.come_RoomID)
            }
            actionSheetController.addAction(reportAction)
//            let BlockAction = UIAlertAction(title: mes3, style: .destructive) { action -> Void in
//                self.BlockAPI()
//            }
//            actionSheetController.addAction(BlockAction)
            
//            let BlockanddeleteAction = UIAlertAction(title: mes4, style: .destructive) { action -> Void in
//                self.BlockAndDeleteAPI()
//            }
//            actionSheetController.addAction(BlockanddeleteAction)
        
            actionSheetController.popoverPresentationController?.sourceView = sender as UIView
            
            self.present(actionSheetController, animated: true, completion: nil)
    }
    
    @IBAction func SnapsCountBtnAction(_ sender: Any) {
        SnapsCountPopUp.removeFromSuperview()
    }
    
    @IBAction func showProfileDirect(_ sender: Any){
        
        let actionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
                    
                }
                actionSheetController.addAction(cancelAction)
            let nearto = UIAlertAction(title: "View profile picture", style: .default) { action -> Void in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ExpandedImageViewController") as! ExpandedImageViewController
         vc.urlStr = self.Come_user_profile_image
//                 vc.shouldPrefix = true
                self.navigationController?.pushViewController(vc, animated: true)
        //                self.ChatMessageDeleteAPI(room: self.come_RoomID)
                }
                actionSheetController.addAction(nearto)
            let mostlike = UIAlertAction(title: "View Journey", style: .default) { action -> Void in
            
                if self.snapsCount == "0" {
                    self.view.makeToast("This user has no recent Journey posts. To add to your Soul’s Journey, click the link in your profile.")
        //            self.view.makeToast("Story not found")
//                    self.SnapsCountPopUp.frame = self.view.frame
//                    self.SnapsCountPopUp.backgroundColor = UIColor.black.withAlphaComponent(0.4)
//                    self.view.addSubview(self.SnapsCountPopUp)
                }else{
                    let controller1 = SB_instaStory.instantiateViewController(identifier: "PresentStoryViewController") as! PresentStoryViewController
                    controller1.comeUserID = self.Come_chatUser_ID
                    controller1.modalPresentationStyle  = .fullScreen
                    self.navigationController?.present(controller1, animated: true, completion: nil)
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
        
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileController") as! ProfileController
//        vc.swipeUserID = Int(self.Come_chatUser_ID)!
////            vc.picturesArray = self.picturesArray
//        vc.vibeType = SELECT_VIBE
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func SendButtonAction(_ sender: ResponsiveButton) {
       
        self.view.endEditing(true)
//        let user_profile_id = DataManager.getVal(Config().AppUserDefaults.object(forKey: "user_profile_id")) as? String ?? ""
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "hh:mm"
        let dateString = formatter.string(from: now)
        
        if isBlank1(self.MessageTxtField) {
            if self.SendImage.image == nil{
            }else{
                self.ChatImgUploadAPI()
            }
        }else{
            if 0<(self.MessageTxtField.text?.count)!{
                self.message_type = "1"
                let now = Date()
                let formatter = DateFormatter()
                formatter.timeZone = TimeZone.current
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let dateString = formatter.string(from: now)
                self.sendDataToApiForPushNotification(message1: self.MessageTxtField.text ?? "")
                if self.socketType == "direct" {
                    if MessageListArray.count < 1 {
                        if SELECT_VIBE == ""
                        {
                            SocketIoManager.one_to_one_sharedInstance.sendMessage(message: self.MessageTxtField.text ?? "", withRoom: self.come_RoomID, withSender: self.loginUser_ID, type: self.socketType, vibe: "Mini Tribes", message_type: "1", withReciver: self.Come_chatUser_ID, mime_type: "", created_at: dateString)
                        }else{
                            SocketIoManager.one_to_one_sharedInstance.sendMessage(message: self.MessageTxtField.text ?? "", withRoom: self.come_RoomID, withSender: self.loginUser_ID, type: self.socketType, vibe: SELECT_VIBE, message_type: "1", withReciver: self.Come_chatUser_ID, mime_type: "", created_at: dateString)
                        }
                    } else {
                        if SELECT_VIBE == ""
                        {
                            SocketIoManager.one_to_one_sharedInstance.sendMessage(message: self.MessageTxtField.text ?? "", withRoom: self.come_RoomID, withSender: self.loginUser_ID, type: "", vibe: "Mini Tribes", message_type: "1", withReciver: self.Come_chatUser_ID, mime_type: "", created_at: dateString)
                        }else{
                            SocketIoManager.one_to_one_sharedInstance.sendMessage(message: self.MessageTxtField.text ?? "", withRoom: self.come_RoomID, withSender: self.loginUser_ID, type: self.socketType, vibe: SELECT_VIBE, message_type: "1", withReciver: self.Come_chatUser_ID, mime_type: "", created_at: dateString)
                        }
                    }
                    
                    
                    
                    
                }else{
                    
                    if SELECT_VIBE == ""
                    {
                        SocketIoManager.one_to_one_sharedInstance.sendMessage(message: self.MessageTxtField.text ?? "", withRoom: self.come_RoomID, withSender: self.loginUser_ID, type: "", vibe: "Mini Tribes", message_type: "1", withReciver: self.Come_chatUser_ID, mime_type: "", created_at: dateString)
                    }
                    else{
                        SocketIoManager.one_to_one_sharedInstance.sendMessage(message: self.MessageTxtField.text ?? "", withRoom: self.come_RoomID, withSender: self.loginUser_ID, type: "", vibe: SELECT_VIBE, message_type: "1", withReciver: self.Come_chatUser_ID, mime_type: "", created_at: dateString)
                    }
                    
                    
                }
                
                self.MessageTxtField.text = ""
                DispatchQueue.main.async {
                    self.ChatTblView.reloadData()
                }
                self.typeDirect = ""
                self.UserChat_API()
                if self.MessageListArray.count != 0{
                    self.ChatTblView.scrollToRow(at: IndexPath(row: self.MessageListArray.count - 1, section: 0), at: .bottom, animated: true)
                }
                
              //  self.MessageTxtField.text = ""
               
//                if 0<(self.MessageTxtField.text?.count)!{
//
//                                       let chatDict = NSMutableDictionary()
//                                       chatDict.setObject(String(self.loginUser_ID), forKey: "sender_id" as NSCopying)
//                                       chatDict.setObject(String(self.Come_chatUser_ID), forKey: "receiver_id" as NSCopying)
//                                       chatDict.setObject(self.MessageTxtField.text ?? "", forKey: "message" as NSCopying)
//                                       chatDict.setObject(dateString, forKey: "date_time" as NSCopying)
//                                       chatDict.setObject(self.come_RoomID, forKey: "room" as NSCopying)
//
//               //     self.MessageListArray.add(chatDict)
//                    self.MessageTxtField.text = ""
//                                       self.ChatTblView.reloadData()
//                                       let indexPath = IndexPath(row: self.MessageListArray.count-1, section: 0)
//                                       self.ChatTblView.scrollToRow(at: indexPath, at: .bottom, animated: true)
//
//
//                            }
               
//
               
//                DispatchQueue.main.async {
//                    self.ChatTblView.reloadData()
//                }
//                if self.MessageListArray.count != 0{
//                    self.ChatTblView.scrollToRow(at: IndexPath(row: self.MessageListArray.count - 1, section: 0), at: .bottom, animated: true)
//                }
            }
        }
    }
    
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.MessageListArray.count-1, section: 0)
            self.ChatTblView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.MessageListArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dict = DataManager.getVal(self.MessageListArray[indexPath.row]) as! NSDictionary
        let type = DataManager.getVal(dict["message_type"]) as? String ?? ""
        let sender_profile_id = DataManager.getVal(dict["sender_id"]) as? String ?? ""
        var message = DataManager.getVal(dict["message"]) as? String ?? ""
        let status = DataManager.getVal(dict["message_read_count"]) as? String ?? ""
        let fileType = DataManager.getVal(dict["mime_type"]) as? String ?? ""
        let time = DataManager.getVal(dict["date_time"]) as? String ?? ""
        let profileImage = DataManager.getVal(dict["profile_image"]) as? String ?? ""
        if self.loginUser_ID == sender_profile_id{
            if type == "1"{ //text message
                let cell = tableView.dequeueReusableCell(withIdentifier: "SenderTableCell", for: indexPath) as! SenderTableCell
                cell.TitleLbl.text = message
                cell.timelbl.text = time
                if status == "0"{
                    cell.ReadImg.image = UIImage(named: "Read")
                }else{
                    cell.ReadImg.image = UIImage(named: "Tick")
                }
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReciverImageTableCell", for: indexPath) as! ReciverImageTableCell
                
                if fileType == "png" || fileType == "jpg" || fileType == "jpeg"{
//                    cell.imgView.sd_setImage(with: URL(string: Config().baseImageUrl + message), placeholderImage: UIImage(named: "user"))
                    print(Config().baseImageUrl + message)
                    let img = message.replacingOccurrences(of: " ", with: "%20")
                    Config().setimage(image_url: Config().baseImageUrl + img, image_name: cell.imgView)
//                    cell.imgView.sd_setImage(with: URL(string: Config().baseImageUrl + message), completed: nil)
                //    Config().setimage(image_url: message, image_name: cell.imgView)
                }else{
                    cell.imgView.image = UIImage(named: "Document")
                }
                if status == "2"{
                    cell.ReadUnReadImgView.image = UIImage(named: "Read")
                }else{
                    cell.ReadUnReadImgView.image = UIImage(named: "Tick")
                }
                cell.timeLbl.text = time
                return cell
            }
            
        }else{
            if type == "1"{//text message
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReciverTableCell", for: indexPath) as! ReciverTableCell
                cell.TitleLbl.text = message
                cell.timelbl.text = time
//                cell.imgView.sd_setImage(with: URL(string: Config().baseImageUrl + profileImage), completed: nil)
                print(Config().baseImageUrl + message)
                let img = profileImage.replacingOccurrences(of: " ", with: "%20")
                if img != "" || img != nil {
                    Config().setimage(image_url: Config().baseImageUrl + img, image_name: cell.imgView)
                }else{
                    Config().setimage(image_url: self.Come_user_profile_image, image_name: cell.imgView)
                }
                
              //
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "SenderImageTableCell", for: indexPath) as! SenderImageTableCell
                let img = profileImage.replacingOccurrences(of: " ", with: "%20")
                //Config().setimage(image_url: self.Come_user_profile_image, image_name: cell.ProfileImgView)
                Config().setimage(image_url: Config().baseImageUrl + img, image_name: cell.ProfileImgView)
                if fileType == "png" || fileType == "jpg" || fileType == "jpeg"{
                    print(Config().baseImageUrl + message)
                    let img = message.replacingOccurrences(of: " ", with: "%20")
                Config().setimage(image_url: Config().baseImageUrl + img, image_name: cell.imgView)
                }else{
                    cell.imgView.image = UIImage(named: "Document")
                }
             //   Config().setimage(image_url: self.user_profile_image, image_name: cell.ProfileImgView)
                cell.timeLbl.text = time
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dict = DataManager.getVal(self.MessageListArray[indexPath.row]) as! NSDictionary
        let type = DataManager.getVal(dict["message_type"]) as? String ?? ""
        if type == "1"{
            print("text meesgae")
        }else{
            let profileImage = DataManager.getVal(dict["message"]) as? String ?? ""
            let img = profileImage.replacingOccurrences(of: " ", with: "%20")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ExpandedImageViewController") as! ExpandedImageViewController
             vc.urlStr = img
             vc.shouldPrefix = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func backBtnAction(_ sender: Any) {

        navigationController?.popViewController(animated: true)
    }
 }

extension MessageVC: UIDocumentMenuDelegate, UIDocumentPickerDelegate{
    /*func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
     var imageData = Data()
     do {
     imageData = try Data(contentsOf: url as URL)
     } catch {
     print("Unable to load data: \(error)")
     }
     self.file_extantion = url.pathExtension
     self.SendImage.isHidden = false
     self.SendImage.image = UIImage(named: "Document")
     
     let dict = ["image_data": imageData,"status":"doc"] as [String: Any]
     self.image_array.append(dict)
     }*/
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        var imageData = Data()
        
        do {
            imageData = try Data(contentsOf: url as URL)
        } catch {
            print("Unable to load data: \(error)")
        }
        self.file_extantion = url.pathExtension
        
        if self.file_extantion == "PDF" {
            let dict = ["image_data": imageData,"status":"doc"] as [String: Any]
            self.image_array.append(dict)
            self.SendImage.isHidden = false
            self.SendImage.image = UIImage(named: "Document")
            self.sendImageWidthConstraint.constant = 44
        }else if self.file_extantion == "pdf" {
            let dict = ["image_data": imageData,"status":"doc"] as [String: Any]
            self.image_array.append(dict)
            self.SendImage.isHidden = false
            self.SendImage.image = UIImage(named: "Document")
            self.sendImageWidthConstraint.constant = 44
        }else if self.file_extantion == "docx" {
            let dict = ["image_data": imageData,"status":"doc"] as [String: Any]
            self.image_array.append(dict)
            self.SendImage.isHidden = false
            self.SendImage.image = UIImage(named: "Document")
            self.sendImageWidthConstraint.constant = 44
        }else if self.file_extantion == "xls" {
            let dict = ["image_data": imageData,"status":"doc"] as [String: Any]
            self.image_array.append(dict)
            self.SendImage.isHidden = false
            self.SendImage.image = UIImage(named: "Document")
            self.sendImageWidthConstraint.constant = 44
        }else if self.file_extantion == "doc" {
            let dict = ["image_data": imageData,"status":"doc"] as [String: Any]
            self.image_array.append(dict)
            self.SendImage.isHidden = false
            self.SendImage.image = UIImage(named: "Document")
            self.sendImageWidthConstraint.constant = 44
        }else if self.file_extantion == "xlsx" {
            let dict = ["image_data": imageData,"status":"doc"] as [String: Any]
            self.image_array.append(dict)
            self.SendImage.isHidden = false
            self.SendImage.image = UIImage(named: "Document")
            self.sendImageWidthConstraint.constant = 44
        }else if self.file_extantion == "jpg" {
            let dict = ["image_data": imageData,"status":"doc"] as [String: Any]
            self.image_array.append(dict)
            self.SendImage.isHidden = false
            self.SendImage.image = UIImage(named: "Document")
            self.sendImageWidthConstraint.constant = 44
        }else if self.file_extantion == "exe" {
            let dict = ["image_data": imageData,"status":"doc"] as [String: Any]
            self.image_array.append(dict)
            self.SendImage.isHidden = false
            self.SendImage.image = UIImage(named: "Document")
            self.sendImageWidthConstraint.constant = 44
        }else {
           
        }
    }
    func documentMenu(_ documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        UINavigationBar.appearance().tintColor = UIColor.black
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], for: .normal)
        
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .overCurrentContext
        self.present(documentPicker, animated: true, completion: nil)
    }
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        /// Picker was cancelled! Duh 🤷🏻‍♀️
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true
                       , completion: {
                        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
                            self.SendImage.image = image
                            self.SendImage.isHidden = false
                            self.MessageTxtField.isHidden = true
                            let dict = ["image_data": image,"status":"image"] as [String: Any]
                            self.image_array.append(dict)
                            self.sendImageWidthConstraint.constant = 44
                        }else{
                            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
                                self.SendImage.image = image
                                self.SendImage.isHidden = false
                                self.MessageTxtField.isHidden = true
                                let dict = ["image_data": image,"status":"image"] as [String: Any]
                                self.image_array.append(dict)
                                self.sendImageWidthConstraint.constant = 44
                            }
                        }
                       })
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func isBlank (_ textfield:UITextField) -> Bool {
        
        let thetext = textfield.text
        let trimmedString = thetext!.trimmingCharacters(in: CharacterSet.whitespaces)
        if trimmedString.isEmpty {
            return true
        }
        return false
    }
    
    
    func isBlank1 (_ textfield:UITextView) -> Bool {
        
        let thetext = textfield.text
        let trimmedString = thetext!.trimmingCharacters(in: CharacterSet.whitespaces)
        if trimmedString.isEmpty {
            return true
        }
        return false
    }
    //MARK:- TextField Delegate
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.MessageTxtField.resignFirstResponder()
        return true
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let topBarHeight = UIApplication.shared.statusBarFrame.size.height + (self.navigationController?.navigationBar.frame.height ?? 0.0)
        print(topBarHeight)
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            
            return
        }
        self.MainScrollBackView.frame.origin.y = 0 - keyboardSize.height //+ topBarHeight
        print(self.MainScrollBackView.frame.origin.y)
        print(keyboardSize)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        let topBarHeight = UIApplication.shared.statusBarFrame.size.height + (self.navigationController?.navigationBar.frame.height ?? 0.0) - 80
        print(topBarHeight)
        self.MainScrollBackView.frame.origin.y = topBarHeight
    }
    //MARK:-Image Upload API
    func ChatImgUploadAPI(){
        
        basicFunctions.presentLoader()
        
        let Dict = NSMutableDictionary()
        Dict.setValue(DataManager.getVal(self.loginUser_ID), forKey: "userid")
        Dict.setValue(DataManager.getVal(Config().api_key), forKey: "api_key")
        Dict.setValue(DataManager.getVal(self.come_RoomID), forKey: "room")
        
        
        let dict = DataManager.getVal(self.image_array[0]) as! [String: Any]
        let status = DataManager.getVal(dict["status"]) as? String ?? ""
        
        //For upload image
        let dataArr = NSMutableArray()
        let dataDict = NSMutableDictionary()
        dataDict.setValue("chat_file", forKey: "chat_file")
        if status == "doc"{//document
            dataDict.setValue(DataManager.getVal(dict["image_data"]) as! Data, forKey: "document_data")
            dataDict.setValue(self.file_extantion, forKey: "ext")
        }else{//image
            //dataDict.setValue((DataManager.getVal(dict["image_data"]) as! UIImage).pngData()!, forKey: "document_data")
            dataDict.setValue(self.resizeImage(image: (DataManager.getVal(dict["image_data"]) as! UIImage), targetSize: CGSize(width: 1500, height: 1500)).pngData(), forKey: "document_data")
            
            dataDict.setValue("png", forKey: "ext")
        }
        dataArr.add(dataDict)
        print(dataArr)
        print(dataDict)
        
        let MethodName = "chat_file_upload"
        
        DataManager.UploadSingleDocumentFile(parameterDictionary: Dict, methodName: MethodName ,dataArray: dataArr){(responseData,error)-> Void in
            
            let status = DataManager.getVal(responseData?.object(forKey: "status")) as? String ?? ""
            let message = DataManager.getVal(responseData?.object(forKey: "message")) as? String ?? ""
            
            if status == "1" {
                self.image_array.removeAll()
                self.sendDataToApiForPushNotification(message1: "photo")
                let data = DataManager.getVal(responseData?.object(forKey: "data")) as? [String:Any]
                let chat_file = DataManager.getVal(data?["chat_file"]) as? String ?? ""
                let mime_type = DataManager.getVal(data?["mime_type"]) as? String ?? ""
//                let user_profile_id = DataManager.getVal(Config().AppUserDefaults.object(forKey: "user_profile_id")) as? String ?? ""
                self.SendImage.image = nil
                self.MessageTxtField.isHidden = false
                self.SendImage.isHidden = true
                
                self.message_type = "2"
                
                let now = Date()
                let formatter = DateFormatter()
                formatter.timeZone = TimeZone.current
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                
                let dateString = formatter.string(from: now)
                if self.socketType == "direct" {
                    if self.MessageListArray.count < 1 {
                        SocketIoManager.one_to_one_sharedInstance.sendMessage(message: chat_file, withRoom: self.come_RoomID, withSender: self.loginUser_ID, type: "", vibe: SELECT_VIBE, message_type: "2", withReciver: self.Come_chatUser_ID, mime_type: mime_type, created_at: dateString)
                    }
                } else {
                    SocketIoManager.one_to_one_sharedInstance.sendMessage(message: chat_file, withRoom: self.come_RoomID, withSender: self.loginUser_ID, type: self.socketType, vibe: SELECT_VIBE, message_type: "2", withReciver: self.Come_chatUser_ID, mime_type: mime_type, created_at: dateString)
                }
//                SocketIoManager.one_to_one_sharedInstance.sendMessage(message: chat_file, withRoom: self.come_RoomID, withSender: self.loginUser_ID, type: self.socketType, vibe: SELECT_VIBE, message_type: "2", withReciver: self.Come_chatUser_ID, mime_type: mime_type, created_at: dateString)

                
                self.MessageTxtField.text = ""
                                DispatchQueue.main.async {
                                    self.ChatTblView.reloadData()
                                }
                                 self.UserChat_API()
                                if self.MessageListArray.count != 0{
                                    self.ChatTblView.scrollToRow(at: IndexPath(row: self.MessageListArray.count - 1, section: 0), at: .bottom, animated: true)
                                }
                self.sendImageWidthConstraint.constant = 0
            }else{
            //    Config().error(message: message)
                self.sendImageWidthConstraint.constant = 0
            }
               basicFunctions.stopLoading()
        }
    }
    
    //MARK:- Delete All Message
    func ChatMessageDeleteAPI(room: String){
        
        //self.pleaseWait()
        
        let Dict = NSMutableDictionary()
        Dict.setValue(self.loginUser_ID, forKey: "user_id")
        Dict.setValue(Config().api_key, forKey: "api_key")
        Dict.setValue(self.come_RoomID, forKey: "room")
        
        if SELECT_VIBE == ""
        {
            Dict.setValue("Mini Tribes", forKey: "vibe")
        }
        else{
            Dict.setValue(SELECT_VIBE, forKey: "vibe")
        }
    
        let methodName = "delete_old_messages"
        
        DataManager.getAPIResponse(Dict,methodName: methodName, methodType: "POST") { (responseData,error) -> Void in
            
            let status = DataManager.getVal(responseData?.object(forKey: "status")) as? String ?? ""
            let message = DataManager.getVal(responseData?.object(forKey: "message")) as? String ?? ""
            
            if status == "1" {
                self.UserChat_API()
                self.view.makeToast(message)
            }else{
                self.view.makeToast(message)
            }
           // self.clearAllNotice()
        }
    }
    //MARK:- Get read status
    
    func chatStatus(){
            self.view.endEditing(true)
            let parameterDictionary = NSMutableDictionary()
            let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
           parameterDictionary.setValue("tribe123", forKey: "api_key")
           parameterDictionary.setValue(userID, forKey: "user_id")
        
           if SELECT_VIBE == ""
           {
               parameterDictionary.setValue("Mini Tribes", forKey: "vibe")
           }
        else{
            parameterDictionary.setValue(SELECT_VIBE, forKey: "vibe")
        }
            parameterDictionary.setValue(self.come_RoomID, forKey: "room")
           print(parameterDictionary)
            let methodName = "update_message_is_read_status"

            DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
                let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
                let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""

                if status == "1" {
                    print(responseData)
                    print("rr")
                }
                else {
//                     self.view.makeToast(message)
                }
            }
    }
    
    //MARK:- Delete All Message
    func BlockAPI(){
//            self.confirmBlockView.isHidden = true
            let tempVw = KolView()
            tempVw.menuoptionView.isHidden = true
            self.view.endEditing(true)
            let parameterDictionary = NSMutableDictionary()
            let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
           parameterDictionary.setValue("tribe123", forKey: "api_key")
           parameterDictionary.setValue(userID, forKey: "user_id")
           parameterDictionary.setValue(SELECT_VIBE, forKey: "vibe")
            parameterDictionary.setValue(self.Come_chatUser_ID, forKey: "block_user_id")
           print(parameterDictionary)
            let methodName = "user_block"

            DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
                let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
                let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""

                if status == "1" {
                    self.UserChat_API()
                    self.view.makeToast(message)
                    self.BottomViewHeightConstraint.constant = 0
//                    self.cardView.reloadData()
//                    self.getData(vibeType: self.CategorySelect)
                    print("rr")
                }
                else {
//                     self.view.makeToast(message)
                }
            }
    }
//    //MARK:- Delete And Block User
//    func BlockAndDeleteAPI(){
//
//      ///  self.pleaseWait()
//
//        let Dict = NSMutableDictionary()
//        Dict.setValue(DataManager.getVal(""), forKey: "userid")
//        Dict.setValue(DataManager.getVal(""), forKey: "user_profile_id")
//        Dict.setValue(DataManager.getVal(self.ChatReceiverID), forKey: "block_profile_id")
//        Dict.setValue(DataManager.getVal(self.come_RoomID), forKey: "room")
//        Dict.setValue(DataManager.getVal(self.businessId), forKey: "business_id")
//
//        let methodName = "deleteAndBlockUserThread"
//
//        DataManager.getAPIResponse(Dict,methodName: methodName, methodType: "POST") { (responseData,error) -> Void in
//
//            let status = DataManager.getVal(responseData?.object(forKey: "status")) as? String ?? ""
//            let message = DataManager.getVal(responseData?.object(forKey: "message")) as? String ?? ""
//
//            if status == "1" {
////                Config().success(message: message)
////                let vc = MessageListVC(nibName: "MessageListVC", bundle: nil)
////                self.RootViewWithSideManu(vc)
//            }else{
//
//            }
//           // self.clearAllNotice()
//        }
//    }
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
          let size = image.size

              let widthRatio  = targetSize.width  / size.width
              let heightRatio = targetSize.height / size.height

              // Figure out what our orientation is, and use that to form the rectangle
              var newSize: CGSize
              if(widthRatio > heightRatio) {
                  newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
              } else {
                  newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
              }

              // This is the rect that we've calculated out and this is what is actually used below
              let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

              // Actually do the resizing to the rect using the ImageContext stuff
              UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
              image.draw(in: rect)
              let newImage = UIGraphicsGetImageFromCurrentImageContext()
              UIGraphicsEndImageContext()

              return newImage!
      }
}


   

