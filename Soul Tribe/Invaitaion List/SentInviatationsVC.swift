//
//  SentInviatationsVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 29/06/21.
//

import UIKit

class SentInviatationsVC: UIViewController {

    var miniTribeId = ""
    var arr_data = [[String:Any]]()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        api_call()
    }
    
    
    func api_call(){
        basicFunctions.presentLoader()
        
        let paraDict = NSMutableDictionary()
        paraDict.setValue(Config().api_key, forKey: "api_key")
        paraDict.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
        paraDict.setValue(miniTribeId, forKey: "mini_tribe_id")
        paraDict.setValue("sent", forKey: "type")
        
//        paraDict.setValue("25", forKey: "user_id")
        print(paraDict)

        let methodName = "get_invitations_my_mini_tribe"
        DataManager.getAPIResponse(paraDict , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
            print(message)
            if status == "1" {
                self.arr_data = DataManager.getVal(responseData?["data"]) as? [[String:Any]] ?? []
            }
            else {
                self.view.makeToast(message)
            }
            
        self.tableView.reloadData()
        basicFunctions.stopLoading()
        }
    }
}


extension SentInviatationsVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arr_data.count == 0{
            let vw = basicFunctions.noDataAvailableWithImageNew(str: "No Invitations Found. Check Back Soon!", tbl: tableView)
            tableView.backgroundView  = vw
            return 0
        }else{
            tableView.backgroundView  = nil
            return arr_data.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InvaitaionsendCell", for: indexPath) as! InvaitaionsendCell
      
        cell.imguser.layer.cornerRadius = cell.imguser.frame.size.width/2
        cell.imguser.contentMode = .scaleToFill
        
        let dict = arr_data[indexPath.row]
        cell.lblname.text = DataManager.getVal(dict["user_name"]) as? String ?? ""
       
        cell.imguser.sd_setImage(with: URL(string: "\(Config().baseImageUrl)\(DataManager.getVal(dict["user_profile_image"]) as? String ?? "")"), completed: nil)
        
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ImageClicked(_:)))
            cell.imguser.isUserInteractionEnabled = true
            cell.imguser.addGestureRecognizer(tap)
        tap.view?.tag = indexPath.row
            

        
        
        let stats = DataManager.getVal(dict["status"]) as? String ?? ""
        
        if stats == "1"{
            cell.lbl_status.text = "Accepted"
        }else if stats == "2"{
            cell.lbl_status.text = "Rejected"
        }else{
            cell.lbl_status.text = "Invited"
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 105
       }
 
    @objc func ImageClicked(_ sender : UITapGestureRecognizer) {
        let dict = arr_data[sender.view?.tag ?? -1]
           let tempurlStr = DataManager.getVal(dict["user_profile_image"]) as? String ?? ""
           
           let vc = self.storyboard?.instantiateViewController(withIdentifier: "ExpandedImageViewController") as! ExpandedImageViewController
        vc.shouldPrefix = true
           vc.urlStr = tempurlStr
           self.navigationController?.pushViewController(vc, animated: true)
       }
    
}
