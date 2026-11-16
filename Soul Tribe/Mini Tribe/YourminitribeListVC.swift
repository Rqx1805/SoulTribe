//
//  YourminitribeListVC.swift
//  Soul Tribe
//
//  Created by MAC-28 on 02/08/21.
//

import UIKit
class YourminitribeListcell: UITableViewCell{
    
//    @IBOutlet weak var btn_status: UIButton!
    @IBOutlet weak var lbl_membersCount: UIButton!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var img_disp: UIImageView!
    @IBOutlet weak var newPostStatus_Lbl: UILabel!
}

class YourminitribeListVC: UIViewController {
    @IBOutlet weak var searchview: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var txt_search: UITextField!
    @IBOutlet weak var tableview: UITableView!
    
    @IBAction func btn_backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var btn_back: UIButton!
    
    var arr_data = [[String:Any]]()
    var filteredArr = [[String:Any]]()
    
    var comesFrom = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        txt_search.setLeftPaddingPoints(10)
        searchview.layer.cornerRadius = 6
        searchview.layer.borderWidth = 1
        searchview.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        
        tableview.delegate = self
        tableview.dataSource = self
        
        txt_search.addTarget(self, action: #selector(searchRecordsAsPerText(_ :)), for: .editingChanged)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if comesFrom == "MyMiniTribes" {
            btn_back.setTitle(" My Mini Tribes", for: .normal)
            api_call2()
        }else{
            btn_back.setTitle(" Mini Tribes", for: .normal)
            api_call2()
        }
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
        tableview.reloadData()
    }
    
    func api_call(){
        let paraDict = NSMutableDictionary()
        paraDict.setValue(Config().api_key, forKey: "api_key")
      paraDict.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
      //  paraDict.setValue("25", forKey: "user_id")
        print(paraDict)
        
        let methodName = "get_my_mini_tribe"
        DataManager.getAPIResponse(paraDict , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
            print(message)
            if status == "1" {
                self.arr_data = DataManager.getVal(responseData?["data"]) as? [[String:Any]] ?? []
                self.filteredArr = self.arr_data
            }
            else {
                print(message)
            }
            
        self.tableview.reloadData()
        }
    }
    
    
    func api_call2(){
        let paraDict = NSMutableDictionary()
        paraDict.setValue(Config().api_key, forKey: "api_key")
      paraDict.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")

//        paraDict.setValue("25", forKey: "user_id")
        print(paraDict)
        
        let methodName = "get_joined_mini_tribe"
        DataManager.getAPIResponse(paraDict , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
            print(message)
            if status == "1" {
                self.arr_data = DataManager.getVal(responseData?["data"]) as? [[String:Any]] ?? []
                self.filteredArr = self.arr_data
            }
            else {
                print(message)
            }
            
        self.tableview.reloadData()
        }
    }
}

extension YourminitribeListVC: UITableViewDelegate,UITableViewDataSource {
    
    
    @objc func ImageClicked1(_ sender : UITapGestureRecognizer) {
        let dict = filteredArr[sender.view?.tag ?? -1]
        
        let vc = self.storyboard?.instantiateViewController(identifier: "MiniTribeJoinVC") as! MiniTribeJoinVC
        vc.miniTribeId = DataManager.getVal(dict["mini_tribe_id"]) as? String ?? ""
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredArr.count == 0{
            let vw = basicFunctions.noDataAvailableWithImageNew(str: "No Mini Tribes found. Create a tribe or visit the Mini Tribes page to get started!", tbl: tableView)
            tableView.backgroundView  = vw
            return 0
        }else{
            tableView.backgroundView  = nil
            return filteredArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YourminitribeListcell", for: indexPath) as! YourminitribeListcell
        
        cell.img_disp.layer.cornerRadius = cell.img_disp.frame.size.width/2
        cell.img_disp.contentMode = .scaleToFill
        
        let dict = filteredArr[indexPath.row]
        cell.lbl_name.text = DataManager.getVal(dict["name"]) as? String ?? ""
        cell.newPostStatus_Lbl.layer.cornerRadius = cell.newPostStatus_Lbl.frame.width/2
        cell.newPostStatus_Lbl.clipsToBounds = true
        let newpostStatus = DataManager.getVal(dict["recent_status"]) as? String ?? ""
        if newpostStatus == "0" {
            cell.newPostStatus_Lbl.isHidden = true
        }else{
            cell.newPostStatus_Lbl.isHidden = false
        }
        let membersCount = DataManager.getVal(dict["members_count"]) as? String ?? ""
        if membersCount == "1" {
            cell.lbl_membersCount.setTitle("\(DataManager.getVal(dict["members_count"]) as? String ?? "") Member", for: .normal)
        }else{
            cell.lbl_membersCount.setTitle("\(DataManager.getVal(dict["members_count"]) as? String ?? "") Members", for: .normal)
        }
//        cell.img_disp.sd_setImage(with: URL(string: "\(Config().baseImageUrl)\(DataManager.getVal(dict["image"]) as? String ?? "")"), completed: nil)
        Config().setimage(image_url: "\(Config().baseImageUrl)\(DataManager.getVal(dict["image"]) as? String ?? "")", image_name: cell.img_disp)
//        let tap = UITapGestureRecognizer(target: self, action: #selector(ImageClicked(_:)))
//             cell.img_disp.isUserInteractionEnabled = true
//             cell.img_disp.addGestureRecognizer(tap)
//        tap.view?.tag = indexPath.row
             
        cell.lbl_membersCount.tag = indexPath.row
        cell.lbl_membersCount.addTarget(self, action: #selector(getMemberList(_:)), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ImageClicked1(_:)))
        cell.img_disp.isUserInteractionEnabled = true
        cell.img_disp.addGestureRecognizer(tap)
        tap.view?.tag = indexPath.row
//        cell.btn_status.layer.cornerRadius = cell.btn_status.frame.size.width/2
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict = filteredArr[indexPath.row]
        let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
        let Joindid = DataManager.getVal(dict["user_id"]) as? String ?? ""
        
        let vc = self.storyboard?.instantiateViewController(identifier: "TribefullDeatilsVC") as! TribefullDeatilsVC
        if userID == Joindid {
            vc.comesFromMyMiniAndMiniTribe = "MyMiniTribes"
        }
        vc.miniTribeId = DataManager.getVal(dict["id"]) as? String ?? ""
        vc.miniTribeListing = DataManager.getVal(dict["user_id"]) as? String ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func getMemberList (_ sender:UIButton){
        let dict = filteredArr[sender.tag]
        let arr_list = DataManager.getVal(dict["members_list"]) as? [[String:Any]] ?? []
        
        let vc = self.storyboard?.instantiateViewController(identifier: "MemberListVC") as! MemberListVC
        vc.arrData = arr_list
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
//    @objc func ImageClicked(_ sender : UITapGestureRecognizer) {
//        let dict = filteredArr[sender.view?.tag ?? -1]
//            let tempurlStr = DataManager.getVal(dict["image"]) as? String ?? ""
//
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ExpandedImageViewController") as! ExpandedImageViewController
//            vc.urlStr = tempurlStr
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
}
