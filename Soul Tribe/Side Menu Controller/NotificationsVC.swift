//
//  NotificationsVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 11/06/21.
//

import UIKit

class NotificationsCell: UITableViewCell{
    @IBOutlet weak var btnstatus: UIButton!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var img: UIImageView!
}
class NotificationsVC: UIViewController {
    var leftDrawerTransition:DrawerTransition!
    var left = LeftMenuViewController()
    @IBOutlet weak var headerview: UIView!
    @IBOutlet weak var notificationTableView: UITableView!

    var notificationArray = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
        headerview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        headerview.layer.shadowOpacity = 0.5
        headerview.layer.shadowOffset = .zero
        headerview.layer.shadowRadius = 5
        getNotificationVC()
    }
    
    @objc func ImageClicked1(_ sender : UITapGestureRecognizer) {
        let dict = self.notificationArray[sender.view?.tag ?? -1]
           let tempurlStr = DataManager.getVal(dict["sender_profile_image"]) as? String ?? ""
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ExpandedImageViewController") as! ExpandedImageViewController
                 vc.urlStr = tempurlStr
                 vc.shouldPrefix = true
                self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getNotificationVC() {
        self.view.endEditing(true)
        let parameterDictionary = NSMutableDictionary()
        let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
       parameterDictionary.setValue("tribe123", forKey: "api_key")
       parameterDictionary.setValue(userID, forKey: "user_id")
       print(parameterDictionary)
        let methodName = "get_notifications_list"

        DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""

            if status == "1" {
                self.notificationArray = DataManager.getVal(responseData?["data"]) as! [NSDictionary]
                self.notificationTableView.reloadData()
                
            }
            else {
//                 self.view.makeToast(message)
            }
        }
    }
    func deleteNotification(notificationId: Int) {
        self.view.endEditing(true)
        let parameterDictionary = NSMutableDictionary()
        let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
       parameterDictionary.setValue("tribe123", forKey: "api_key")
       parameterDictionary.setValue(userID, forKey: "user_id")
        parameterDictionary.setValue(notificationId, forKey: "notification_id")
       print(parameterDictionary)
        let methodName = "delete_notification"

        DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""

            if status == "1" {
                self.getNotificationVC()
            }
            else {
//                 self.view.makeToast(message)
            }
        }
    }
    
    @IBAction func backbtnaction(_ sender:UIButton) {
        navigationController?.popViewController(animated: true)
        
        //self.slideMenuController()?.toggleLeft()
    }
    
    @IBAction func btngosetting(_ sender:UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "NotificationSettingVC") as! NotificationSettingVC
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
extension NotificationsVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if notificationArray.count == 0{
            let vw = basicFunctions.noDataAvailableWithImageNew(str: "No new notifications. Check back soon!", tbl: tableView)
            tableView.backgroundView  = vw
            tableView.separatorStyle = .none
            return 0
        }else{
            tableView.backgroundView  = nil
            tableView.separatorStyle = .singleLine
            return notificationArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationsCell", for: indexPath) as! NotificationsCell
        cell.btnstatus.layer.cornerRadius = 3
        var dict = NSDictionary()
        dict = self.notificationArray[indexPath.row]
        cell.dateLbl.text = dict.value(forKey: "date") as? String
        cell.messageLbl.text = dict.value(forKey: "message") as? String
        cell.nameLbl.text = dict.value(forKey: "title") as? String
        Config().setimage(image_url: "\(Config().baseImageUrl)" + "\(dict.value(forKey: "sender_profile_image") as? String ?? "")", image_name: cell.img)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ImageClicked1(_:)))
        cell.img.isUserInteractionEnabled = true
        cell.img.addGestureRecognizer(tap)
        tap.view?.tag = indexPath.row
        
        let showBlue = DataManager.getVal(dict["status"]) as? String ?? ""
        if showBlue == "0" {
            cell.btnstatus.isHidden = false
        }else{
            cell.btnstatus.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var dict = NSDictionary()
        dict = self.notificationArray[indexPath.row]
        let type = dict.value(forKey: "type") as? String ?? ""
        let title = dict.value(forKey: "title") as? String ?? ""
        
        if type == "like" {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "WhoLikedMeVC") as! WhoLikedMeVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else if type == "mini_tribe_invitation" {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MeetUpInvitaionVC") as! MeetUpInvitaionVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else if type == "mini_tribe_post" {
//            if title == "New Comment" {
//                let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
//                let Joindid = DataManager.getVal(dict["other_id"]) as? String ?? ""
//
//                let vc = self.storyboard?.instantiateViewController(identifier: "TribefullDeatilsVC") as! TribefullDeatilsVC
//                if userID == Joindid {
//                    vc.comesFromMyMiniAndMiniTribe = "MyMiniTribes"
//                }
//                vc.miniTribeId = DataManager.getVal(dict["other_id"]) as? String ?? ""
//               // vc.miniTribeListing = DataManager.getVal(dict["user_id"]) as? String ?? ""
//                self.navigationController?.pushViewController(vc, animated: true)
//            }else{
//                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MeetUpInvitaionVC") as! MeetUpInvitaionVC
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
            //harsh
            if title != "Meetup Invitation" {
                
                let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
                let Joindid = DataManager.getVal(dict["other_id"]) as? String ?? ""
                let mini_tribe_post_id = DataManager.getVal(dict["mini_tribe_post_id"]) as? String ?? ""
                let vc = self.storyboard?.instantiateViewController(identifier: "TribefullDeatilsVC") as! TribefullDeatilsVC
                vc.other_id = mini_tribe_post_id
                if userID == Joindid {
                    vc.comesFromMyMiniAndMiniTribe = "MyMiniTribes"
                }
                vc.miniTribeId = DataManager.getVal(dict["other_id"]) as? String ?? ""
               // vc.miniTribeListing = DataManager.getVal(dict["user_id"]) as? String ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MeetUpInvitaionVC") as! MeetUpInvitaionVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
           
        }else if type == "matched" {
           //
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MessageTabVC") as! MessageTabVC
            vc.isComeFromPushNotitfication = "yes"
            UserDefaults.standard.setValue("1", forKey: "changeTabNew")
            self.navigationController?.pushViewController(vc, animated: true)
            NotificationCenter.default.post(name: Notification.Name("loadmessageNew"), object: nil)
        }else if type == "Ads Accepted"{
            
        }
        else{
            let vc = SB_instaStory.instantiateViewController(withIdentifier: "AddStoryVC") as! AddStoryVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
         return true
    }
      func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
          
          let contextItem = UIContextualAction(style: .destructive, title: "") {  (contextualAction, view, boolValue) in
              let deleteAlert = UIAlertController(title:  "Delete", message: "Are you sure you want to delete notification?", preferredStyle: UIAlertController.Style.alert)

              deleteAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [self] (action: UIAlertAction!) in
                  
                  var dict = NSDictionary()
                  dict = self.notificationArray[indexPath.row]
                  let notificationID = dict.value(forKey: "id") as? Int ?? 0
                  deleteNotification(notificationId: notificationID)
                  
                 
                  
//                  let dict = DataManager.getVal(self.arr_data[indexPath.row]) as? [String:Any] ?? [:]
//                  let id = DataManager.getVal(dict["id"]) as? String ?? ""
//                  self.api_deleteNotification(id: id, indexRow:indexPath.row)
              }))

              deleteAlert.addAction(UIAlertAction(title:  "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
              }))
              self.present(deleteAlert, animated: true, completion: nil)
          }
          contextItem.backgroundColor = UIColor(red: 0.52, green: 0.61, blue: 0.83, alpha: 1.00)
          contextItem.image = UIImage(named: "deleteNotifi")
          let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])

          return swipeActions
      }
}
