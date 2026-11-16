//
//  MessageListVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 09/06/21.
//

import UIKit

class MessageListVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var requestBtn: UIButton!
    @IBOutlet weak var SnapsCountPopUp: UIView!
    @IBOutlet weak var SnapsCountPopUpCornerRadius: UIView!
    @IBOutlet weak var SnapsCountPopUp_CancelBtn: UIButton!
    
    @IBOutlet weak var messageListTableview: UITableView!
    @IBOutlet weak var searchview: UIView!
    @IBOutlet weak var txt_search: UITextField!
    
    var ChatroomID = String()
    var chatUSerImageUrl = String()
    var comeVIbeType = String()
    var senderID = String()
    var arr_data = [[String:Any]]()
    var requestListDisplay = false
    var match_data = NSArray()
    
    var filteredArr = [[String:Any]]()
    var typeMessageMatch = String()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SnapsCountPopUpCornerRadius.layer.cornerRadius = 6
        SnapsCountPopUp_CancelBtn.layer.cornerRadius = 6
        
        txt_search.setLeftPaddingPoints(10)
        filteredArr = arr_data
        txt_search.addTarget(self, action: #selector(searchRecordsAsPerText(_ :)), for: .editingChanged)
        searchview.layer.cornerRadius = 6
        searchview.layer.borderWidth = 1
        searchview.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        NotificationCenter.default.addObserver(self, selector: #selector(self.new_showChatMessage(_:)), name: NSNotification.Name(rawValue: "loadmessageNew"), object: nil)
        // Do any additional setup after loading the view.
    }
    
    @objc func new_showChatMessage(_ notification: NSNotification) {
        if self.typeMessageMatch.count == 0 {
            api_call(vibe: SELECT_VIBE)
        }else{
            if self.typeMessageMatch == "message" {
                api_call(vibe: SELECT_VIBE)
                requestBtn.isHidden = false
            }else{
                api_call2(vibe: SELECT_VIBE)
                requestBtn.isHidden = true
            }
        }
     }
    override func viewWillAppear(_ animated: Bool) {
        if self.typeMessageMatch.count == 0 {
            api_call(vibe: SELECT_VIBE)
        }else{
            if self.typeMessageMatch == "message" {
                api_call(vibe: SELECT_VIBE)
                requestBtn.isHidden = false
            }else{
                api_call2(vibe: SELECT_VIBE)
                requestBtn.isHidden = true
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
    }
    
    @objc func searchRecordsAsPerText(_ textfield:UITextField) {
        filteredArr.removeAll()
        if txt_search.text?.count != 0 {
            for anyObject in arr_data {
                let dict = DataManager.getVal(anyObject) as? [String:Any] ?? [:]
                let range = (DataManager.getVal(dict["name"]) as? String ?? "").lowercased().range(of: txt_search.text ?? "", options: .caseInsensitive, range: nil,   locale: nil)

                if range != nil { filteredArr.append(dict) }
            }
        } else { filteredArr = arr_data }
        messageListTableview.reloadData()
    }
    func api_call2(vibe: String){
        self.arr_data.removeAll()
        
        basicFunctions.presentLoader()

        let parameterDictionary = NSMutableDictionary()
        parameterDictionary.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
        if SELECT_VIBE == ""
        {
            parameterDictionary.setValue("Mini Tribes", forKey: "vibe")
        }
        else{
            parameterDictionary.setValue(SELECT_VIBE, forKey: "vibe")
        }
        parameterDictionary.setValue(Config().api_key, forKey: "api_key")
        print(parameterDictionary)

        let methodName = "get_matched_users_list"
        
        DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as! String
            let message  = DataManager.getVal(responseData?["message"]) as! String
            
            if status == "1" {
//                self.view.makeToast(message)
                self.match_data = DataManager.getVal(responseData?["data"]) as? NSArray ?? []
                self.messageListTableview.reloadData()
//                let dict = DataManager.getVal(responseData?["data"]) as? [String:Any] ?? [:]
//                self.arr_data = DataManager.getVal(dict["messages"]) as? [[String:Any]] ?? []
            }
            else {
                self.view.makeToast("Please select vibe", duration: 2.0, position: .bottom, title: nil, image: nil, style: ToastManager.shared.style, completion: nil)
            }
            
        }
        basicFunctions.stopLoading()
    }
    func addRedDotAtTabBarItemIndex(index: Int) {
        for subview in tabBarController!.tabBar.subviews {

            if let subview = subview as? UIView {

                if subview.tag == 1234 {
                    subview.removeFromSuperview()
                    break
                }
            }
        }

        let RedDotRadius: CGFloat = 5
        let RedDotDiameter = RedDotRadius * 2

        let TopMargin:CGFloat = 5

        let TabBarItemCount = CGFloat(self.tabBarController!.tabBar.items!.count)

        let screenSize = UIScreen.main.bounds
        let HalfItemWidth = (screenSize.width) / (TabBarItemCount * 2)

        let  xOffset = HalfItemWidth * CGFloat(index * 2 + 1)

        let imageHalfWidth: CGFloat = (self.tabBarController!.tabBar.items![index] as! UITabBarItem).selectedImage!.size.width / 2

        let redDot = UIView(frame: CGRect(x: xOffset + imageHalfWidth - 7, y: TopMargin, width: RedDotDiameter, height: RedDotDiameter))

        redDot.tag = 1234
        redDot.backgroundColor = UIColor(red: 22/255, green: 199/255, blue: 154/255, alpha: 1.0)
        redDot.layer.cornerRadius = RedDotRadius

            self.tabBarController?.tabBar.addSubview(redDot)

    }
    func api_call(vibe: String){
        self.arr_data.removeAll()
        
        basicFunctions.presentLoader()

        let parameterDictionary = NSMutableDictionary()
        let timeZone = TimeZone.current.identifier
        parameterDictionary.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
        if SELECT_VIBE == ""
        {
            parameterDictionary.setValue("Mini Tribes", forKey: "vibe")
        }
        else{
            parameterDictionary.setValue(SELECT_VIBE, forKey: "vibe")
        }
        parameterDictionary.setValue(timeZone, forKey: "timezone")
        parameterDictionary.setValue(Config().api_key, forKey: "api_key")
        print(parameterDictionary)

        let methodName = "get_messages_users_list"
        
        DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as! String
            let message  = DataManager.getVal(responseData?["message"]) as! String
           
            if status == "1" {
//                self.view.makeToast(message)
                let dict = DataManager.getVal(responseData?["data"]) as? [String:Any] ?? [:]
                let count = DataManager.getVal(dict["count"]) as? String
                self.arr_data = DataManager.getVal(dict["messages"]) as? [[String:Any]] ?? []
                let requestCount = DataManager.getVal(dict["messages_request"]) as? [[String:Any]] ?? []
                self.requestBtn.setTitle("\(requestCount.count) Message Requests", for: .normal)
                self.filteredArr = self.arr_data
                self.messageListTableview.reloadData()
                if count ?? "0" > "0" {
                    if let tabItems = self.tabBarController?.tabBar.items {
                        // In this case we want to modify the badge number of the third tab:
                        let userVibe = UserDefaults.standard.string(forKey: "userVibe")
                        print(userVibe)
                        if SELECT_VIBE == "" {
                            if userVibe == "Mini Tribes" {
                                let tabItem = tabItems[0]
                                tabItem.badgeValue?.removeAll()
                                self.addRedDotAtTabBarItemIndex(index: 0)
                            }else{
                                let tabItem = tabItems[0]
                                tabItem.badgeValue?.removeAll()
                                self.addRedDotAtTabBarItemIndex(index: 0)
                            }
                           
                        } else {
                            if userVibe == "Mini Tribes" {
                                let tabItem = tabItems[0]
                                tabItem.badgeValue?.removeAll()
                                self.addRedDotAtTabBarItemIndex(index: 0)
                            }else{
                                let tabItem = tabItems[1]
                                tabItem.badgeValue?.removeAll()
                                self.addRedDotAtTabBarItemIndex(index: 1)
                            }
                            
                        }
//                        let tabItem = tabItems[1]
//                        tabItem.badgeValue?.removeAll()
                        //tabItem.badgeValue = ""
                       
                    }
                }else{
                    if let tabItems = self.tabBarController?.tabBar.items {
                       // In this case we want to modify the badge number of the third tab:
                      
                        if SELECT_VIBE == "" {
                            let tabItem = tabItems[0]
                            tabItem.badgeValue?.removeAll()
                        }
                        else {
                            let tabItem = tabItems[1]
                            tabItem.badgeValue?.removeAll()
                        }
//                       let tabItem = tabItems[1]
//                       tabItem.badgeValue?.removeAll()
                   }
                }
               
            }
            else {
                self.view.makeToast("Please select vibe", duration: 2.0, position: .bottom, title: nil, image: nil, style: ToastManager.shared.style, completion: nil)
            }
        }
        basicFunctions.stopLoading()
    }
    @IBAction func SnapsCountBtnAction(_ sender: Any) {
        SnapsCountPopUp.removeFromSuperview()
    }
    @objc func ShowStoryBtn(_ sender: UIButton) {
        if self.filteredArr.count == 0 {
            
        }else{
            let dict = self.filteredArr[sender.tag]
            self.senderID = DataManager.getVal(dict["receiver_id"]) as? String ?? ""
            let snapsCount = DataManager.getVal(dict["snaps_count"]) as? String ?? ""
            let img = DataManager.getVal(dict["profile_image"]) as? String ?? ""
            
            let actionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                    
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
                        
                    }
                    actionSheetController.addAction(cancelAction)
                let nearto = UIAlertAction(title: "View profile picture", style: .default) { action -> Void in
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ExpandedImageViewController") as! ExpandedImageViewController
             vc.urlStr = img
                     vc.shouldPrefix = true
                    self.navigationController?.pushViewController(vc, animated: true)
            //                self.ChatMessageDeleteAPI(room: self.come_RoomID)
                    }
                    actionSheetController.addAction(nearto)
                let mostlike = UIAlertAction(title: "View Journey", style: .default) { action -> Void in
                
                    if snapsCount == "0" {
                        self.view.makeToast("This user has no recent Journey posts. To add to your Soul’s Journey, click the link in your profile.")
            //            self.view.makeToast("Story not found")
    //                    self.SnapsCountPopUp.frame = self.view.frame
    //                    self.SnapsCountPopUp.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    //                    self.view.addSubview(self.SnapsCountPopUp)
                    }else{
                        let controller1 = SB_instaStory.instantiateViewController(identifier: "PresentStoryViewController") as! PresentStoryViewController
                        controller1.comeUserID = self.senderID
                        controller1.modalPresentationStyle  = .fullScreen
                        self.navigationController?.present(controller1, animated: true, completion: nil)
                    }
                }
            if snapsCount == "0" {
                
                mostlike.setValue(UIColor.lightGray, forKey: "titleTextColor")
            }else{
                mostlike.setValue(UIColor.systemBlue, forKey: "titleTextColor")
            }
                    actionSheetController.addAction(mostlike)
                
                    actionSheetController.popoverPresentationController?.sourceView = sender as? UIView
                    
                    self.present(actionSheetController, animated: true, completion: nil)
         
        }
        
    }
    
    @IBAction func requestbtn(_ sender: Any) {
        let controller1 = storyboard?.instantiateViewController(identifier: "MessageRequestVC") as! MessageRequestVC
        controller1.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        controller1.willMove(toParent: self)
        self.view.addSubview(controller1.view)
        self.addChild(controller1)
        controller1.didMove(toParent: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.typeMessageMatch.count == 0 {
            if filteredArr.count == 0{
                var mes  = ""
                if SELECT_VIBE == "Mini Tribe" {
                    mes = "Make friendships and/or love connections today by adding Soul Love or Tribe by editing your profile Vibe selections."
                }else{
                    let userVibe = UserDefaults.standard.string(forKey: "userVibe")
                    if userVibe == "Mini Tribes" {
                        mes = "Make friendships and/or love connections today by adding Soul Love or Tribe by editing your profile Vibe selections."
                    }else{
                        mes = "Attraction in Process."
                    }
                    
                }
                let vw = basicFunctions.noDataAvailableWithImageNew(str: mes, tbl: tableView)
                tableView.backgroundView  = vw
                return 0
            }else{
                tableView.backgroundView  = nil
                    return filteredArr.count
            }
        }else{
            if self.typeMessageMatch == "message" {
                if filteredArr.count == 0{
                    var mes  = ""
                    if SELECT_VIBE == "Mini Tribe" {
                        mes = "Make friendships and/or love connections today by adding Soul Love or Tribe by editing your profile Vibe selections."
                    }else{
                        let userVibe = UserDefaults.standard.string(forKey: "userVibe")
                        if userVibe == "Mini Tribes" {
                            mes = "Make friendships and/or love connections today by adding Soul Love or Tribe by editing your profile Vibe selections."
                        }else{
                            mes = "Attraction in Process."
                        }
                    }
                    let vw = basicFunctions.noDataAvailableWithImageNew(str: mes, tbl: tableView)
                    tableView.backgroundView  = vw
                    return 0
                }else{
                    tableView.backgroundView  = nil
                        return filteredArr.count
                }
            }else{
                if self.match_data.count == 0{
                    var mes  = ""
                    if SELECT_VIBE == "Mini Tribe" {
                        mes = "Make friendships and/or love connections today by adding Soul Love or Tribe by editing your profile Vibe selections."
                    }else{
                        let userVibe = UserDefaults.standard.string(forKey: "userVibe")
                        if userVibe == "Mini Tribes" {
                            mes = "Make friendships and/or love connections today by adding Soul Love or Tribe by editing your profile Vibe selections."
                        }else{
                            mes = "Attraction in Process."
                        }
                    }
                    let vw = basicFunctions.noDataAvailableWithImageNew(str: mes, tbl: tableView)
                    tableView.backgroundView  = vw
                    return 0
                }else{
                    tableView.backgroundView  = nil
                        return match_data.count
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MessageListCell
        cell.cornorview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.cornorview.layer.shadowOpacity = 0.4
        cell.cornorview.layer.shadowOffset = .zero
        cell.cornorview.layer.shadowRadius = 4
        cell.cornorview.layer.cornerRadius = 12
        cell.messageImg.isHidden = true
        cell.img_profile.layer.cornerRadius = cell.img_profile.frame.size.width/2
        cell.newMsgStatusIndicator.layer.cornerRadius = cell.newMsgStatusIndicator.frame.width/2
        
        if self.typeMessageMatch.count == 0 {
            let dict = filteredArr[indexPath.row]
            print(dict)
            self.ChatroomID = DataManager.getVal(dict["room"]) as? String ?? ""
            cell.lbl_name.text = DataManager.getVal(dict["name"]) as? String ?? ""
            cell.lbl_time.text = DataManager.getVal(dict["date_time"]) as? String ?? ""
            cell.lbl_msg.text = DataManager.getVal(dict["message"]) as? String ?? ""
            self.senderID = DataManager.getVal(dict["receiver_id"]) as? String ?? ""
            self.chatUSerImageUrl = "\(Config().baseImageUrl)\(DataManager.getVal(dict["profile_image"]) as? String ?? "")"
            cell.img_profile.sd_setImage(with: URL(string: self.chatUSerImageUrl), completed: nil)
            let msg = DataManager.getVal(dict["message"]) as? String ?? ""
            if msg.contains(".png") || msg.contains(".jpg") || msg.contains(".jpeg") {
                print("re")
                cell.messageImg.isHidden = false
                cell.messageImg.sd_setImage(with: URL(string: Config().baseImageUrl + msg), placeholderImage: #imageLiteral(resourceName: "default_image"), options: .refreshCached) { (image, error, cachesType, url) in
                }
                cell.lbl_msg.text = ""
            }else{
                cell.messageImg.isHidden = true
            }
        
            let readStatus = DataManager.getVal(dict["message_read_count"]) as? String ?? ""
            if readStatus == "0" {
                cell.newMsgStatusIndicator.isHidden = true
                cell.cornorview.backgroundColor = UIColor.white
                cell.lbl_msg.font = UIFont(name: "OpenSans-Regular", size: 12)
                cell.lbl_msg.textColor = UIColor(red: 0.60, green: 0.61, blue: 0.62, alpha: 1.00)
            }else{
                cell.newMsgStatusIndicator.isHidden = false
                cell.cornorview.backgroundColor = UIColor(red: 0.32, green: 0.36, blue: 0.47, alpha: 0.2)
                cell.lbl_msg.font = UIFont(name: "OpenSans-Semibold", size: 12)
                cell.lbl_msg.textColor = UIColor.black
            }
            let tap = UITapGestureRecognizer(target: self, action: #selector(ImageClicked(_:)))
                  cell.img_profile.isUserInteractionEnabled = true
                  cell.img_profile.addGestureRecognizer(tap)
            tap.view?.tag = indexPath.row
            
            cell.showStoryBtn.tag = indexPath.row
            cell.showStoryBtn.addTarget(self, action: #selector(ShowStoryBtn), for: .touchUpInside)
            let snaps_count = DataManager.getVal(dict["snaps_count"]) as? String ?? ""
            if snaps_count == "1" {
                cell.back_img.isHidden = false
            }else{
                cell.back_img.isHidden = true
            }
            cell.message_icon.isHidden = true
            return cell
            
        }else{
            
            if self.typeMessageMatch == "message" {
                let dict = filteredArr[indexPath.row]
                print(dict)
                self.ChatroomID = DataManager.getVal(dict["room"]) as? String ?? ""
                cell.lbl_name.text = DataManager.getVal(dict["name"]) as? String ?? ""
                cell.lbl_time.text = DataManager.getVal(dict["date_time"]) as? String ?? ""
                cell.lbl_msg.text = DataManager.getVal(dict["message"]) as? String ?? ""
                self.senderID = DataManager.getVal(dict["receiver_id"]) as? String ?? ""
                self.chatUSerImageUrl = "\(Config().baseImageUrl)\(DataManager.getVal(dict["profile_image"]) as? String ?? "")"
                cell.img_profile.sd_setImage(with: URL(string: self.chatUSerImageUrl), completed: nil)
                let msg = DataManager.getVal(dict["message"]) as? String ?? ""
                if msg.contains(".png") {
                    print("re")
                    cell.messageImg.isHidden = false
                    cell.messageImg.sd_setImage(with: URL(string: Config().baseImageUrl + msg), placeholderImage: #imageLiteral(resourceName: "default_image"), options: .refreshCached) { (image, error, cachesType, url) in
                    }
                    cell.lbl_msg.text = ""
                }else{
                    cell.messageImg.isHidden = true
                }
            
                let readStatus = DataManager.getVal(dict["message_read_count"]) as? String ?? ""
                if readStatus == "0" {
                    cell.newMsgStatusIndicator.isHidden = true
                    cell.cornorview.backgroundColor = UIColor.white
                    cell.lbl_msg.font = UIFont(name: "OpenSans-Regular", size: 12)
                    cell.lbl_msg.textColor = UIColor(red: 0.60, green: 0.61, blue: 0.62, alpha: 1.00)
                }else{
                    cell.newMsgStatusIndicator.isHidden = false
                    cell.cornorview.backgroundColor = UIColor(red: 0.32, green: 0.36, blue: 0.47, alpha: 0.2)
                    cell.lbl_msg.font = UIFont(name: "OpenSans-Semibold", size: 12)
                    cell.lbl_msg.textColor = UIColor.black
                }
                let tap = UITapGestureRecognizer(target: self, action: #selector(ImageClicked(_:)))
                      cell.img_profile.isUserInteractionEnabled = true
                      cell.img_profile.addGestureRecognizer(tap)
                tap.view?.tag = indexPath.row
                
                cell.showStoryBtn.tag = indexPath.row
                cell.showStoryBtn.addTarget(self, action: #selector(ShowStoryBtn), for: .touchUpInside)
                let snaps_count = DataManager.getVal(dict["snaps_count"]) as? String ?? ""
                if snaps_count == "1" {
                    cell.back_img.isHidden = false
                }else{
                    cell.back_img.isHidden = true
                }
                cell.message_icon.isHidden = true
                return cell
            }else{
                cell.newMsgStatusIndicator.isHidden = true
                let dict = self.match_data.object(at: indexPath.row) as? NSDictionary ?? [:]
                self.ChatroomID = DataManager.getVal(dict["room"]) as? String ?? ""
                cell.lbl_name.text = DataManager.getVal(dict["name"]) as? String ?? ""
                cell.lbl_time.text = DataManager.getVal(dict["date_time"]) as? String ?? ""
                cell.lbl_msg.text = DataManager.getVal(dict["message"]) as? String ?? ""
                self.senderID = DataManager.getVal(dict["receiver_id"]) as? String ?? ""
                self.chatUSerImageUrl = "\(Config().baseImageUrl)\(DataManager.getVal(dict["profile_image"]) as? String ?? "")"
                cell.img_profile.sd_setImage(with: URL(string: self.chatUSerImageUrl), completed: nil)
                let msg = DataManager.getVal(dict["message"]) as? String ?? ""
                if msg.contains(".png") {
                    print("re")
                    cell.messageImg.isHidden = false
                    cell.messageImg.sd_setImage(with: URL(string: Config().baseImageUrl + msg), placeholderImage: #imageLiteral(resourceName: "default_image"), options: .refreshCached) { (image, error, cachesType, url) in
                    }
                    cell.lbl_msg.text = ""
                }else{
                    cell.messageImg.isHidden = false
                }
                cell.message_icon.isHidden = false
                let tap = UITapGestureRecognizer(target: self, action: #selector(ImageClicked(_:)))
                      cell.img_profile.isUserInteractionEnabled = true
                      cell.img_profile.addGestureRecognizer(tap)
                tap.view?.tag = indexPath.row
                
                cell.showStoryBtn.tag = indexPath.row
                cell.showStoryBtn.addTarget(self, action: #selector(ShowStoryBtn), for: .touchUpInside)
                let snaps_count = DataManager.getVal(dict["snaps_count"]) as? String ?? ""
                if snaps_count == "1" {
                    cell.back_img.isHidden = false
                }else{
                    cell.back_img.isHidden = true
                }
                return cell
            }
        }
      
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.row == 0{
        
        if self.typeMessageMatch.count == 0 {
            let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
            let dict = filteredArr[indexPath.row]
                let id1 = DataManager.getVal(dict["receiver_id"]) as? String ?? ""
                let id2 = DataManager.getVal(dict["sender_id"]) as? String ?? ""
                if userID == id1 {
                    self.senderID = DataManager.getVal(dict["sender_id"]) as? String ?? ""
                }else if userID == id2 {
                    self.senderID = DataManager.getVal(dict["receiver_id"]) as? String ?? ""
                }
            self.ChatroomID = DataManager.getVal(dict["room"]) as? String ?? ""
            let userName = DataManager.getVal(dict["name"]) as? String ?? ""
            let snapCount = DataManager.getVal(dict["snaps_count"]) as? String ?? ""
            let profileImage = "\(Config().baseImageUrl)\(DataManager.getVal(dict["profile_image"]) as? String ?? "")"
                let controller = storyboard?.instantiateViewController(withIdentifier: "MessageVC") as! MessageVC
            controller.Come_chatUser_ID = self.senderID
            controller.Come_userName = userName
            controller.come_RoomID = self.ChatroomID
            controller.Come_user_profile_image = profileImage
            controller.snapsCount = snapCount
            self.navigationController?.pushViewController(controller, animated: true)
        }else{
            if self.typeMessageMatch == "message" {
                let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
                let dict = filteredArr[indexPath.row]
                    let id1 = DataManager.getVal(dict["receiver_id"]) as? String ?? ""
                    let id2 = DataManager.getVal(dict["sender_id"]) as? String ?? ""
                    if userID == id1 {
                        self.senderID = DataManager.getVal(dict["sender_id"]) as? String ?? ""
                    }else if userID == id2 {
                        self.senderID = DataManager.getVal(dict["receiver_id"]) as? String ?? ""
                    }
                self.ChatroomID = DataManager.getVal(dict["room"]) as? String ?? ""
                let userName = DataManager.getVal(dict["name"]) as? String ?? ""
                let snapCount = DataManager.getVal(dict["snaps_count"]) as? String ?? ""
                let profileImage = "\(Config().baseImageUrl)\(DataManager.getVal(dict["profile_image"]) as? String ?? "")"
                    let controller = storyboard?.instantiateViewController(withIdentifier: "MessageVC") as! MessageVC
                controller.Come_chatUser_ID = self.senderID
                controller.Come_userName = userName
                controller.come_RoomID = self.ChatroomID
                controller.Come_user_profile_image = profileImage
                controller.snapsCount = snapCount
                self.navigationController?.pushViewController(controller, animated: true)
            }else{
                let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
                let dict = self.match_data.object(at: indexPath.row) as? NSDictionary ?? [:]
               
                    let id1 = DataManager.getVal(dict["friend_user_id"]) as? String ?? ""
                    let id2 = DataManager.getVal(dict["user_id"]) as? String ?? ""
                    if userID == id1 {
                        self.senderID = DataManager.getVal(dict["user_id"]) as? String ?? ""
                    }else if userID == id2 {
                        self.senderID = DataManager.getVal(dict["friend_user_id"]) as? String ?? ""
                    }
                var roomIdR = ""
                let senderIdR = Int(self.senderID)!
                let userIdR = Int(userID)!
                if senderIdR < userIdR {
                    if SELECT_VIBE == ""
                    {
                        roomIdR = "\(senderIdR)-\("Mini Tribes")-\(userID)"
                    }
                    else{
                        roomIdR = "\(senderIdR)-\(SELECT_VIBE)-\(userID)"
                    }
                    
                }else{
                    if SELECT_VIBE == ""
                    {
                        roomIdR = "\(userID)-\("Mini Tribes")-\(senderIdR)"
                    }
                    else{
                        roomIdR = "\(userID)-\(SELECT_VIBE)-\(senderIdR)"
                    }
                    
                   }
                
                self.ChatroomID = DataManager.getVal(dict["room"]) as? String ?? ""
                let userName = DataManager.getVal(dict["name"]) as? String ?? ""
                let snapCount = DataManager.getVal(dict["snaps_count"]) as? String ?? ""
                let profileImage = "\(Config().baseImageUrl)\(DataManager.getVal(dict["profile_image"]) as? String ?? "")"
                    let controller = storyboard?.instantiateViewController(withIdentifier: "MessageVC") as! MessageVC
                controller.typeDirect = ""
                controller.Come_chatUser_ID = self.senderID
                controller.Come_userName = userName
                controller.come_RoomID = roomIdR
                controller.Come_user_profile_image = profileImage
                controller.snapsCount = snapCount
                self.navigationController?.pushViewController(controller, animated: true)
            }
        }
//        }
    }
    
    
    @objc func ImageClicked(_ sender : UITapGestureRecognizer) {
        let dict = filteredArr[sender.view?.tag ?? -1]
            let tempurlStr = DataManager.getVal(dict["profile_image"]) as? String ?? ""
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ExpandedImageViewController") as! ExpandedImageViewController
        vc.shouldPrefix = true
            vc.urlStr = tempurlStr
            self.navigationController?.pushViewController(vc, animated: true)
        }
}
