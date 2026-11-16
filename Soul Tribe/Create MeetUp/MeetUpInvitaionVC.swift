//
//  MeetUpInvitaionVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 29/06/21.
//

import UIKit
//MARK:- MeetUpInvitaioncell
class MeetUpInvitaioncell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var imguser: UIImageView!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lblcreate: UILabel!
    @IBOutlet weak var btncircle: UIButton!
    @IBOutlet weak var lbldate: UILabel!
    @IBOutlet weak var lbltime: UILabel!
    @IBOutlet weak var lbllocation: UILabel!
    @IBOutlet weak var btngoing: UIButton!
    @IBOutlet weak var btnnotsure: UIButton!
    @IBOutlet weak var btnnotgoing: UIButton!
    @IBOutlet weak var lblgoing: UILabel!
    @IBOutlet weak var lblnotgoing: UILabel!
    @IBOutlet weak var lblmightgoing: UILabel!
    @IBOutlet weak var viewcornor: UIView!
    @IBOutlet weak var picturesCollectionViewGoing1: UICollectionView!
    @IBOutlet weak var picturesCollectionViewNotGoing1: UICollectionView!
    @IBOutlet weak var picturesCollectionViewMightGoing1: UICollectionView!
    
    var arr_Going = [[String:Any]]()
    var arr_NotGoing = [[String:Any]]()
    var arr_MightGo = [[String:Any]]()
    
    @IBOutlet weak var picturesCollectionViewGoingWidthConstranit1: NSLayoutConstraint!
    @IBOutlet weak var picturesCollectionViewNotGoingWidthConstranit1: NSLayoutConstraint!
    @IBOutlet weak var picturesCollectionViewMightGoingWidthConstranit1: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        picturesCollectionViewGoing1.register(UINib(nibName: "CustomOnlyPicturesCell", bundle: nil), forCellWithReuseIdentifier: "CustomOnlyPicturesCell")
        picturesCollectionViewNotGoing1.register(UINib(nibName: "CustomOnlyPicturesCell", bundle: nil), forCellWithReuseIdentifier: "CustomOnlyPicturesCell")
        picturesCollectionViewMightGoing1.register(UINib(nibName: "CustomOnlyPicturesCell", bundle: nil), forCellWithReuseIdentifier: "CustomOnlyPicturesCell")
        
    }
       
        
            func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                
                if collectionView == self.picturesCollectionViewGoing1 {
                    if self.arr_Going.count > 4 {
                        return 4
                    }else{
                        return self.arr_Going.count
                    }
                    
                }else if collectionView == self.picturesCollectionViewNotGoing1 {
                    if self.arr_NotGoing.count > 4 {
                        return 4
                    }else{
                        return self.arr_NotGoing.count
                    }
                }else {
                    if self.arr_MightGo.count > 4 {
                        return 4
                    }else{
                        return self.arr_MightGo.count
                    }
                }
            }
            
            func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                if collectionView == self.picturesCollectionViewGoing1 {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomOnlyPicturesCell", for: indexPath) as! CustomOnlyPicturesCell
                    
        //            if indexPath.row == 0 {
        //                cell.imgleadingConstraint.constant = 0
        //            }else{
        //                cell.imgleadingConstraint.constant = -15
        //            }
                    if indexPath.row == 3 {
                        cell.img.image = UIImage(named: "")
                        cell.img.backgroundColor = UIColor.lightGray
                        cell.countlbl.text = "\(self.arr_Going.count - 3)"
                        cell.countlbl.isHidden = false
                    }else{
                        let dict = self.arr_Going[indexPath.row]
                        let imag = "\(Config().baseImageUrl)" + "\(DataManager.getVal(dict["profile_image"]) as? String ?? "")"
                        Config().setimage(image_url: imag, image_name: cell.img)
                        cell.countlbl.isHidden = true
                    }
                    
                    return cell
                }else if collectionView == self.picturesCollectionViewNotGoing1 {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomOnlyPicturesCell", for: indexPath) as! CustomOnlyPicturesCell
        //            let dict = arr_NotGoing[indexPath.row]
        //            let imag = "\(Config().baseImageUrl)" + "\(DataManager.getVal(dict["profile_image"]) as? String ?? "")"
        //            Config().setimage(image_url: imag, image_name: cell.img)
        //            if indexPath.row == 0 {
        //                cell.imgleadingConstraint.constant = 0
        //            }else{
        //                cell.imgleadingConstraint.constant = -15
        //            }
                    if indexPath.row == 3 {
                        cell.img.image = UIImage(named: "")
                        cell.img.backgroundColor = UIColor.lightGray
                        cell.countlbl.text = "\(self.arr_NotGoing.count - 3)"
                        cell.countlbl.isHidden = false
                    }else{
                        let dict = self.arr_NotGoing[indexPath.row]
                        let imag = "\(Config().baseImageUrl)" + "\(DataManager.getVal(dict["profile_image"]) as? String ?? "")"
                        Config().setimage(image_url: imag, image_name: cell.img)
                        cell.countlbl.isHidden = true
                    }
                  
                    return cell
                }else{
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomOnlyPicturesCell", for: indexPath) as! CustomOnlyPicturesCell
        //            let dict = arr_MightGo[indexPath.row]
        //            let imag = "\(Config().baseImageUrl)" + "\(DataManager.getVal(dict["profile_image"]) as? String ?? "")"
        //            Config().setimage(image_url: imag, image_name: cell.img)
        //            if indexPath.row == 0 {
        //                cell.imgleadingConstraint.constant = 0
        //            }else{
        //                cell.imgleadingConstraint.constant = -15
        //            }
                    if indexPath.row == 3 {
                        cell.img.image = UIImage(named: "")
                        cell.img.backgroundColor = UIColor.lightGray
                        cell.countlbl.text = "\(self.arr_MightGo.count - 3)"
                        cell.countlbl.isHidden = false
                    }else{
                        let dict = self.arr_MightGo[indexPath.row]
                        let imag = "\(Config().baseImageUrl)" + "\(DataManager.getVal(dict["profile_image"]) as? String ?? "")"
                        Config().setimage(image_url: imag, image_name: cell.img)
                        cell.countlbl.isHidden = true
                    }
                
                    return cell
                }
            }
            
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                if indexPath.row == 0 {
                    return CGSize(width: 30, height: 30)
                }else{
                    return CGSize(width: 30, height: 30)
                }
            }
        

    }


//MARK:- MeetUpInvitaionVC

class MeetUpInvitaionVC: UIViewController {
    
    //MARK:- IBOutlet
    @IBOutlet weak var btnback: UIView!
    @IBOutlet weak var headerview: UIView!
    @IBOutlet weak var meetUpInvitationTableView: UITableView!
    
    
    
    
    //MARK:- variables
    
    var ApiDataArr = NSMutableArray()
    var ApiDict = NSMutableDictionary()
    var profileImageString = String()
    
    

    //MARK:-
    override func viewDidLoad() {
        super.viewDidLoad()
        getdata()
        // Do any additional setup after loading the view.
        headerview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        headerview.layer.shadowOpacity = 0.5
        headerview.layer.shadowOffset = .zero
        headerview.layer.shadowRadius = 5
       
    }
    //MARK:- backBtnAction
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)

    }
    //MARK:- apiManager
    
    func getdata(){
        basicFunctions.presentLoader()
        let paraDict = NSMutableDictionary()
        paraDict.setValue(Config().api_key, forKey: "api_key")
        paraDict.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
        let methodName = "get_mini_tribe_meetup_invitation_list"
        DataManager.getAPIResponse(paraDict , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
             let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
             let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
                print(message)
            
             if status == "1" {
                print(DataManager.getVal(responseData?["data"]) as? [String:Any] ?? [:])
                self.ApiDataArr = DataManager.getVal(responseData?["data"]) as? NSMutableArray ?? []
             }
             else {
                print(message)
             }
            self.meetUpInvitationTableView.reloadData()
            basicFunctions.stopLoading()
        }
    }
    
    
    //MARK:- goingSelection
    @objc func goingSelection(_ sender : UIButton){
        print("goingSelected")
 
        let dict = ApiDataArr[sender.tag] as? NSMutableDictionary ?? [:]
        api_updateStatus(id: "1", meetupId: DataManager.getVal(dict["mini_tribe_id"]) as? String ?? "", miniTribeId: DataManager.getVal(dict["mini_tribe_meetup_id"]) as? String ?? "")
    }
    //MARK:- NotSureSelection
    
    @objc func NotSureSelection(_ sender : UIButton){
        print("NotSureSelected")
        let dict = ApiDataArr[sender.tag] as? NSMutableDictionary ?? [:]
        api_updateStatus(id: "3", meetupId: DataManager.getVal(dict["mini_tribe_id"]) as? String ?? "", miniTribeId: DataManager.getVal(dict["mini_tribe_meetup_id"]) as? String ?? "")
    }
    
    //MARK:- NotGoingSelection
    
    @objc func NotGoingSelection(_ sender : UIButton){
        print("NotGoingSelected")
        let dict = ApiDataArr[sender.tag] as? NSMutableDictionary ?? [:]
        api_updateStatus(id: "2", meetupId: DataManager.getVal(dict["mini_tribe_id"]) as? String ?? "", miniTribeId: DataManager.getVal(dict["mini_tribe_meetup_id"]) as? String ?? "")
    }
    
    
    func api_updateStatus(id:String, meetupId: String, miniTribeId : String){
        
        basicFunctions.presentLoader()
        self.view.endEditing(true)
        
        let paraDict = NSMutableDictionary()
        paraDict.setValue(Config().api_key, forKey: "api_key")
        paraDict.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
        paraDict.setValue(meetupId, forKey: "mini_tribe_id")
        paraDict.setValue(miniTribeId, forKey: "mini_tribe_meetup_id")
        paraDict.setValue(id, forKey: "status")
        paraDict.setValue("meetup", forKey: "type")
        
        print(paraDict)
 
        let methodName = "meetup_status_change"
        DataManager.getAPIResponse(paraDict , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
             let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
             let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
                print(message)
             if status == "1" {
                self.getdata()
             }
             else {
                print(message)
             }
            basicFunctions.stopLoading()
        }
    }
}

extension MeetUpInvitaionVC: UITableViewDelegate,UITableViewDataSource{
    //MARK:- tableViewDataSourceMethods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ApiDataArr.count == 0{
            let vw = basicFunctions.noDataAvailableWithImageNew1(str: "No Invitations Found. Check Back Soon!", tbl: tableView)
            tableView.backgroundView  = vw
            return 0
        }else{
            tableView.backgroundView  = nil
            return ApiDataArr.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MeetUpInvitaioncell", for: indexPath) as! MeetUpInvitaioncell
        cell.viewcornor.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.viewcornor.layer.shadowOpacity = 0.5
        cell.viewcornor.layer.shadowOffset = .zero
        cell.viewcornor.layer.shadowRadius = 8
        cell.viewcornor.layer.cornerRadius = 10
        
        cell.btngoing.layer.cornerRadius = 5
        cell.btngoing.layer.borderWidth = 0.8
        cell.btngoing.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        cell.btnnotsure.layer.cornerRadius = 5
        cell.btnnotsure.layer.borderWidth = 0.8
        cell.btnnotsure.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        cell.btnnotgoing.layer.cornerRadius = 5
        cell.btnnotgoing.layer.borderWidth = 0.8
        cell.btnnotgoing.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
       
        
        let apidata = ApiDataArr[indexPath.row]
        ApiDict = apidata as? NSMutableDictionary ?? [:]
    
        cell.lbldate.text = self.ApiDict["meetup_date"] as? String ?? ""
        cell.lbltime.text = self.ApiDict["meetup_time"] as? String ?? ""
        cell.lbllocation.text = self.ApiDict["meetup_location"] as? String ?? ""
        cell.lblgoing.text = "\(self.ApiDict["meetup_going_members"] as? Int ?? 0) People Are Going"
        cell.lblnotgoing.text = "\(self.ApiDict["meetup_not_going_members"] as? Int ?? 0) People Are Not Going"
        cell.lblmightgoing.text = "\(self.ApiDict["meetup_might_go_members"] as? Int ?? 0) People Might Go"
        cell.lblcreate.text = "Created By \(self.ApiDict["user_name"] as? String ?? "")"
        cell.lblname.text = self.ApiDict["meetup_topic"] as? String ?? ""
        cell.self.arr_Going = DataManager.getVal(self.ApiDict["meetup_going_members_list"]) as? [[String:Any]] ?? []
        cell.self.arr_MightGo = DataManager.getVal(self.ApiDict["meetup_might_go_list"]) as? [[String:Any]] ?? []
        cell.self.arr_NotGoing = DataManager.getVal(self.ApiDict["meetup_not_going_members_list"]) as? [[String:Any]] ?? []
        
        let meetupStatus = DataManager.getVal(self.ApiDict["meetup_status"]) as? String ?? ""
        
        if meetupStatus == "1"{
            cell.btngoing.backgroundColor = UIColor(red: 0.05, green: 0.23, blue: 0.66, alpha: 0.2)
            cell.btnnotsure.backgroundColor = UIColor.white
            cell.btnnotgoing.backgroundColor = UIColor.white
        }else if meetupStatus == "2"{
            cell.btngoing.backgroundColor = UIColor.white
            cell.btnnotsure.backgroundColor = UIColor.white
            cell.btnnotgoing.backgroundColor = UIColor(red: 0.05, green: 0.23, blue: 0.66, alpha: 0.2)
        }else if meetupStatus == "3"{
            cell.btngoing.backgroundColor = UIColor.white
            cell.btnnotsure.backgroundColor = UIColor(red: 0.05, green: 0.23, blue: 0.66, alpha: 0.2)
            cell.btnnotgoing.backgroundColor = UIColor.white
        }else{
            cell.btngoing.backgroundColor = UIColor.white
            cell.btnnotsure.backgroundColor = UIColor.white
            cell.btnnotgoing.backgroundColor = UIColor.white
        }
        
        cell.btngoing.tag = indexPath.row
        cell.btnnotgoing.tag = indexPath.row
        cell.btnnotsure.tag = indexPath.row
    
        cell.btngoing.addTarget(self, action: #selector(goingSelection(_:)), for: .touchUpInside)
        cell.btnnotsure.addTarget(self, action: #selector(NotSureSelection(_:)), for: .touchUpInside)
        cell.btnnotgoing.addTarget(self, action: #selector(NotGoingSelection(_:)), for: .touchUpInside)
        
       // self.profileImageString = self.profileDict.value(forKey: "profile_image") as? String ?? ""
       // self.imgprofile.sd_setImage(with: URL(string: Config().baseImageUrl + self.profileImageString), completed: nil)
        
        cell.imguser.sd_setImage(with: URL(string: "\(Config().baseImageUrl)\(DataManager.getVal(ApiDict["meetup_image"]) as? String ?? "")"), completed: nil)
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ImageClicked(_:)))
              cell.imguser.isUserInteractionEnabled = true
              cell.imguser.addGestureRecognizer(tap)
        tap.view?.tag = indexPath.row
        
        if cell.self.arr_Going.count > 4 {
            cell.self.picturesCollectionViewGoingWidthConstranit1.constant = CGFloat(30 * 4)
        }else{
            cell.self.picturesCollectionViewGoingWidthConstranit1.constant = CGFloat(30 * cell.self.arr_Going.count)
        }
        if cell.self.arr_NotGoing.count > 4 {
            cell.self.picturesCollectionViewNotGoingWidthConstranit1.constant = CGFloat(30 * 4)
        }else{
            cell.self.picturesCollectionViewNotGoingWidthConstranit1.constant = CGFloat(30 * cell.self.arr_NotGoing.count)
        }
        if cell.self.arr_MightGo.count > 4 {
            cell.self.picturesCollectionViewMightGoingWidthConstranit1.constant = CGFloat(30 * 4)
        }else{
            cell.self.picturesCollectionViewMightGoingWidthConstranit1.constant = CGFloat(30 * cell.self.arr_MightGo.count)
        }
        cell.self.picturesCollectionViewGoing1.reloadData()
        cell.self.picturesCollectionViewNotGoing1.reloadData()
        cell.self.picturesCollectionViewMightGoing1.reloadData()

        
        
        return cell
    }
    //MARK:- tableViewDelegateMethods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(identifier: "MeetUpDetailVC") as! MeetUpDetailVC
        vc.meetupId = DataManager.getVal(self.ApiDict["mini_tribe_meetup_id"]) as? String ?? ""
        vc.miniTribeId = DataManager.getVal(self.ApiDict["mini_tribe_id"]) as? String ?? ""
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func ImageClicked(_ sender : UITapGestureRecognizer) {
        let dict = ApiDataArr[sender.view?.tag ?? -1] as? NSMutableDictionary ?? [:]
           let tempurlStr = DataManager.getVal(dict["meetup_image"]) as? String ?? ""
           
           let vc = self.storyboard?.instantiateViewController(withIdentifier: "ExpandedImageViewController") as! ExpandedImageViewController
           vc.shouldPrefix = true
           vc.urlStr = tempurlStr
           self.navigationController?.pushViewController(vc, animated: true)
       }
    
}


