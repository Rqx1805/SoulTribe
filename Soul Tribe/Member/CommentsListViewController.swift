//
//  CommentsListViewController.swift
//  Soul Tribe
//
//  Created by mac-14 on 27/11/21.
//

import UIKit

class commentListCell : UITableViewCell{
    
    @IBOutlet weak var vw_background: UIView!
    @IBOutlet weak var lbl_msg: UILabel!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var img_disp: UIImageView!
    @IBOutlet weak var userImgRoundView: UIView!
    
    var gradient = CAGradientLayer()
}


class CommentsListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func btn_backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
     var arrData = [[String:Any]]()
     var postId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        api_call()
    }

    func api_call(){
        let paraDict = NSMutableDictionary()
        paraDict.setValue(Config().api_key, forKey: "api_key")
        paraDict.setValue(postId, forKey: "mini_tribe_post_id")
        paraDict.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
       // paraDict.setValue("25", forKey: "user_id")
        print(paraDict)
    
        let methodName = "get_mini_tribe_comment"
        DataManager.getAPIResponse(paraDict , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
            print(message)
            if status == "1" {
                self.arrData = DataManager.getVal(responseData?["data"]) as? [[String:Any]] ?? []
                
            }
            else {
                print(message)
            }
            
        self.tableView.reloadData()
        }
    }
    
}


extension CommentsListViewController: UITableViewDelegate,UITableViewDataSource{
    
    @objc func lastCommentLblLink(_ sender : UITapGestureRecognizer) {

        let cell = self.tableView.cellForRow(at: IndexPath(row: sender.view?.tag ?? -1, section: 0)) as! commentListCell
        let str = cell.lbl_msg.text?.detectedLinks
       
        
        if str?.count ?? 0 > 0 {
            
            if str![0].hasPrefix("https://") {
                
                let url = URL(string: str![0])

                if UIApplication.shared.canOpenURL(url!) {
                    if #available(iOS 10.0, *) {
                         UIApplication.shared.open(url!, options: [:], completionHandler: { (success) in

                         })
                    } else {
                        UIApplication.shared.openURL(url!)
                    }
                }
            
            }
            
            else{
                let str1 = "https://\(str![0])"
                let url = URL(string: str1)

                if UIApplication.shared.canOpenURL(url!) {
                    if #available(iOS 10.0, *) {
                         UIApplication.shared.open(url!, options: [:], completionHandler: { (success) in

                         })
                    } else {
                        UIApplication.shared.openURL(url!)
                    }
                }
            
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrData.count == 0{
            let vw = basicFunctions.noDataAvailableWithImageNew(str: "No Comments Available. Check Back Soon!", tbl: tableView)
            tableView.backgroundView  = vw
            return 0
        }else{
            tableView.backgroundView  = nil
            return arrData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! commentListCell
        cell.img_disp.layer.cornerRadius = cell.img_disp.frame.size.width/2
        cell.vw_background.layer.cornerRadius = 6
        
        let dict = arrData[indexPath.row]
        
        cell.lbl_name.text = DataManager.getVal(dict["name"]) as? String ?? ""
        cell.img_disp.sd_setImage(with: URL(string: "\(Config().baseImageUrl)\(DataManager.getVal(dict["profile_image"]) as? String ?? "")"), completed: nil)
        cell.lbl_msg.text = DataManager.getVal(dict["comment"]) as? String ?? ""
        
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(lastCommentLblLink(_:)))
         cell.lbl_msg.addGestureRecognizer(tap4)
          tap4.view?.tag = indexPath.row
        
        let temp = cell.lbl_msg.text?.detectedURLs
        if temp?.count ?? 0 > 0 {
            let str = cell.lbl_msg.text?.detectedLinks[0]
            let string_to_color = str
            let range = (cell.lbl_msg.text as? NSString ?? "").range(of: string_to_color ?? "")
            let attribute = NSMutableAttributedString.init(string: cell.lbl_msg.text ?? "")
            attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.link , range: range)
            cell.lbl_msg.attributedText = attribute
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(ImageClicked(_:)))
        cell.img_disp.isUserInteractionEnabled = true
        cell.img_disp.addGestureRecognizer(tap)
        tap.view?.tag = indexPath.row
        
        let snapCount = DataManager.getVal(dict["snaps_count"]) as? String ?? ""
        cell.userImgRoundView.layer.cornerRadius = cell.userImgRoundView.frame.width/2
        
        if snapCount == "0" {
            cell.gradient.removeFromSuperlayer()
        cell.userImgRoundView.layer.backgroundColor = UIColor.white.cgColor
        }else{
            cell.gradient.cornerRadius = cell.userImgRoundView.layer.cornerRadius
            cell.gradient.frame = cell.userImgRoundView.frame
            cell.gradient.colors = [UIColor(red: 0.42, green: 0.39, blue: 1.00, alpha: 1.00).cgColor,UIColor(red: 0.05, green: 0.23, blue: 0.66, alpha: 1.00).cgColor,UIColor(red: 0.10, green: 0.55, blue: 0.65, alpha: 1.00).cgColor,UIColor(red: 0.14, green: 0.90, blue: 0.71, alpha: 1.00).cgColor]
            cell.userImgRoundView.layer.insertSublayer(cell.gradient, at: 0)
            cell.gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
            cell.gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
            cell.gradient.frame = CGRect(x: 0.0, y: 0.0, width: cell.userImgRoundView.frame.size.width, height: cell.userImgRoundView.frame.size.height)
        }
        
        return cell
    }
    
    @objc func ImageClicked(_ sender : UITapGestureRecognizer) {
        let dict = arrData[sender.view?.tag ?? -1]
        
        let id = DataManager.getVal(dict["user_id"]) as? String ?? ""
        let snapCount = DataManager.getVal(dict["snaps_count"]) as? String ?? ""
        
        let actionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
                    
                }
                actionSheetController.addAction(cancelAction)
            let nearto = UIAlertAction(title: "View profile", style: .default) { action -> Void in
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileController") as! ProfileController
                vc.swipeUserID = Int(id) ?? 0
                self.navigationController?.pushViewController(vc, animated: true)
        //                self.ChatMessageDeleteAPI(room: self.come_RoomID)
                }
                actionSheetController.addAction(nearto)
            let mostlike = UIAlertAction(title: "View Journey", style: .default) { action -> Void in
                if snapCount == "0" {
                    self.view.makeToast("This user has no recent Journey posts. To add to your Soul’s Journey, click the link in your profile.")
//                    self.SnapsCountPopUp.frame = self.view.frame
//                    self.SnapsCountPopUp.backgroundColor = UIColor.black.withAlphaComponent(0.4)
//                    self.view.addSubview(self.SnapsCountPopUp)
                }else{
                    let vc1 = SB_instaStory.instantiateViewController(withIdentifier: "PresentStoryViewController") as! PresentStoryViewController
                    vc1.comeUserID = "\(id)"
                    vc1.modalPresentationStyle = .fullScreen
                    self.navigationController?.present(vc1, animated: true, completion: nil)
                }
                }
        if snapCount == "0" {
           
            mostlike.setValue(UIColor.lightGray, forKey: "titleTextColor")
        }else{
            mostlike.setValue(UIColor.systemBlue, forKey: "titleTextColor")
        }
                actionSheetController.addAction(mostlike)
            
                actionSheetController.popoverPresentationController?.sourceView = sender as? UIView
                
                self.present(actionSheetController, animated: true, completion: nil)
        
        
        
//        let tempurlStr = DataManager.getVal(dict["profile_image"]) as? String ?? ""
//        print(dict)
//        let id = DataManager.getVal(dict["user_id"]) as? String ?? ""
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileController") as! ProfileController
//        vc.swipeUserID = Int(id)!
//        vc.vibeType = SELECT_VIBE
//        self.navigationController?.pushViewController(vc, animated: true)
        
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ExpandedImageViewController") as! ExpandedImageViewController
//        vc.shouldPrefix = true
//        vc.urlStr = tempurlStr
//        self.navigationController?.pushViewController(vc, animated: true)
    }
}
