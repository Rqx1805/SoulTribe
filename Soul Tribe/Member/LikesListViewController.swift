//
//  LikesListViewController.swift
//  Soul Tribe
//
//  Created by mac-14 on 27/11/21.
//

import UIKit

class LikesListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
   
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
    
    @IBAction func btn_backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    func api_call(){
        let paraDict = NSMutableDictionary()
        paraDict.setValue(Config().api_key, forKey: "api_key")
        paraDict.setValue(postId, forKey: "mini_tribe_post_id")
        paraDict.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
       // paraDict.setValue("25", forKey: "user_id")
        print(paraDict)
        
        let methodName = "get_mini_tribe_like"
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


extension LikesListViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrData.count == 0{
            let vw = basicFunctions.noDataAvailableWithImageNew(str: "No Likes Available. Check Back Soon!", tbl: tableView)
            tableView.backgroundView  = vw
            return 0
        }else{
            tableView.backgroundView  = nil
            return arrData.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MemberListCell
        cell.img_disp.layer.cornerRadius = cell.img_disp.frame.size.width/2
        
        let dict = arrData[indexPath.row]
        
        cell.lbl_userName.text = DataManager.getVal(dict["name"]) as? String ?? ""
        cell.img_disp.sd_setImage(with: URL(string: "\(Config().baseImageUrl)\(DataManager.getVal(dict["profile_image"]) as? String ?? "")"), completed: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ImageClicked(_:)))
              cell.img_disp.isUserInteractionEnabled = true
              cell.img_disp.addGestureRecognizer(tap)
              
        tap.view?.tag = indexPath.row


        
        
        return cell
    }
    
    @objc func ImageClicked(_ sender : UITapGestureRecognizer) {
        let dict = arrData[sender.view?.tag ?? -1]
           let tempurlStr = DataManager.getVal(dict["profile_image"]) as? String ?? ""
           
           let vc = self.storyboard?.instantiateViewController(withIdentifier: "ExpandedImageViewController") as! ExpandedImageViewController
        vc.shouldPrefix = true
           vc.urlStr = tempurlStr
           self.navigationController?.pushViewController(vc, animated: true)
       }
    
}
