//
//  MemberListVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 29/06/21.
//

import UIKit
class MemberListCell: UITableViewCell{
    
    @IBOutlet weak var lbl_userName: UILabel!
    @IBOutlet weak var img_disp: UIImageView!
    @IBOutlet weak var back_img:UIImageView!
}
class MemberListVC: UIViewController {

    @IBOutlet weak var searchview: UIView!
    @IBOutlet weak var membeeTableview: UITableView!
    @IBOutlet weak var txt_search: UITextField!
    
    var arrData = [[String:Any]]()
    var filteredData = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txt_search.setLeftPaddingPoints(10)
        self.navigationController?.isNavigationBarHidden = true
        
        searchview.layer.cornerRadius = 6
        searchview.layer.borderWidth = 1
        searchview.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        txt_search.addTarget(self, action: #selector(searchRecordsAsPerText(_ :)), for: .editingChanged)
        
        filteredData = arrData
        membeeTableview.delegate = self
        membeeTableview.dataSource = self
        membeeTableview.reloadData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func bachBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func searchRecordsAsPerText(_ textfield:UITextField) {
        filteredData.removeAll()
        if txt_search.text?.count != 0 {
            for anyObject in arrData {
                let dict = DataManager.getVal(anyObject) as? [String:Any] ?? [:]
                let range = (DataManager.getVal(dict["name"]) as? String ?? "").lowercased().range(of: txt_search.text ?? "", options: .caseInsensitive, range: nil,   locale: nil)
                if range != nil { filteredData.append(dict) }
            }
        } else { filteredData = arrData }
        membeeTableview.reloadData()
    }
}

extension MemberListVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredData.count == 0{
            let vw = basicFunctions.noDataAvailableWithImageNew(str: "No Members Found. Check Back Soon!", tbl: tableView)
            tableView.backgroundView  = vw
            return 0
        }else{
            tableView.backgroundView  = nil
            return filteredData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberListCell", for: indexPath) as! MemberListCell
        cell.img_disp.layer.cornerRadius = cell.img_disp.frame.size.width/2
        
        let dict = filteredData[indexPath.row]
        let snaps_count = DataManager.getVal(dict["snaps_count"]) as? String ?? ""
        if snaps_count == "0" {
            cell.back_img.isHidden = true
        }else{
            cell.back_img.isHidden = false
        }
        
        cell.lbl_userName.text = DataManager.getVal(dict["name"]) as? String ?? ""
//        cell.img_disp.sd_setImage(with: URL(string: "\(Config().baseImageUrl)\(DataManager.getVal(dict["profile_image"]) as? String ?? "")"), completed: nil)
        Config().setimage(image_url: "\(Config().baseImageUrl)\(DataManager.getVal(dict["profile_image"]) as? String ?? "")", image_name: cell.img_disp)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ImageClicked(_:)))
              cell.img_disp.isUserInteractionEnabled = true
              cell.img_disp.addGestureRecognizer(tap)
              tap.view?.tag = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict = filteredData[indexPath.row]
        let receiverId = Int(DataManager.getVal(dict["id"]) as? String ?? "") ?? 0
//        let senderId = Int(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "") ?? 0
//        let userName = DataManager.getVal(dict["name"]) as? String ?? ""
//        let profile = DataManager.getVal(dict["profile_image"]) as? String ?? ""
//        let snapc = DataManager.getVal(dict["snaps_count"]) as? String ?? ""
//        //snapCount
//        var roomId = ""
//
//        if receiverId < senderId {
//            roomId = "\(receiverId)-Mini Tribes-\(senderId)"
//        }else{
//            roomId = "\(senderId)-Mini Tribes-\(receiverId)"
//        }
//
//        let controller = storyboard?.instantiateViewController(withIdentifier: "MessageVC") as! MessageVC
//        controller.Come_chatUser_ID = "\(receiverId)"
//        controller.Come_userName = userName
//        controller.come_RoomID = roomId
//        controller.snapsCount = snapc
//        controller.Come_user_profile_image = "\(Config().baseImageUrl)" + "\(profile)"
//        self.navigationController?.pushViewController(controller, animated: true)

        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileController") as! ProfileController
        vc.swipeUserID = receiverId
        vc.vibeHide = "1"
        vc.isComingFromMiniTribe = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    @objc func ImageClicked(_ sender : UITapGestureRecognizer) {
        let dict = filteredData[sender.view!.tag]
        let snaps_count = DataManager.getVal(dict["snaps_count"]) as? String ?? ""
        if snaps_count == "0" {
            let dict = arrData[sender.view?.tag ?? -1]
               let tempurlStr = DataManager.getVal(dict["profile_image"]) as? String ?? ""
               
               let vc = self.storyboard?.instantiateViewController(withIdentifier: "ExpandedImageViewController") as! ExpandedImageViewController
               vc.shouldPrefix = true
               vc.urlStr = tempurlStr
               self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let actionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                    
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
                        
                    }
                    actionSheetController.addAction(cancelAction)
                let nearto = UIAlertAction(title: "View profile picture", style: .default) { action -> Void in
                    let dict = self.arrData[sender.view?.tag ?? -1]
                       let tempurlStr = DataManager.getVal(dict["profile_image"]) as? String ?? ""
                       
                       let vc = self.storyboard?.instantiateViewController(withIdentifier: "ExpandedImageViewController") as! ExpandedImageViewController
                    vc.shouldPrefix = true
                       vc.urlStr = tempurlStr
                       self.navigationController?.pushViewController(vc, animated: true)
                    }
                    actionSheetController.addAction(nearto)
                let mostlike = UIAlertAction(title: "View Journey", style: .default) { action -> Void in
                    
                    if snaps_count == "0" {
                        self.view.makeToast("This user has no recent Journey posts. To add to your Soul’s Journey, click the link in your profile.")
                    }else{
                        let id = DataManager.getVal(dict["id"]) as? String ?? ""
                        let vc1 = SB_instaStory.instantiateViewController(withIdentifier: "PresentStoryViewController") as! PresentStoryViewController
                        vc1.comerFromTab = "y"
                        vc1.Ty = "1"
                        vc1.userIDNew = id
                        vc1.modalPresentationStyle = .fullScreen
                        self.navigationController?.present(vc1, animated: true, completion: nil)
                    }
                }
            if snaps_count == "0" {
                
                mostlike.setValue(UIColor.lightGray, forKey: "titleTextColor")
            }else{
                mostlike.setValue(UIColor.systemBlue, forKey: "titleTextColor")
            }
                actionSheetController.addAction(mostlike)
                
                actionSheetController.popoverPresentationController?.sourceView = sender as? UIView
                    
                self.present(actionSheetController, animated: true, completion: nil)
        }
       }
    
}
