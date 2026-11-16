//
//  TribefullDeatilsVC.swift
//  Soul Tribe
//
//  Created by MAC-28 on 22/07/21.
//

import UIKit
import GrowingTextView
var selecteIndexpathForReferesh = IndexPath(row: 0, section: 0)
class Tribefulltblcell: UITableViewCell,GrowingTextViewDelegate{
   
    @IBOutlet weak var btn_show: UIButton!
    @IBOutlet weak var lbl_line: UILabel!
    @IBOutlet weak var constraint_top_vwCommentMake: NSLayoutConstraint!
    @IBOutlet weak var lbl_lastCommentUsername: UILabel!
    @IBOutlet weak var img_lastCommentUser: UIImageView!
    
    @IBOutlet weak var readmoreButtonBottom_Constant: NSLayoutConstraint!
    
    @IBOutlet weak var readMorebtn: UIButton!
    
    @IBOutlet weak var lbl_lastCommentUserComment: UILabel!
    @IBOutlet weak var vw_lastMsg: UIView!
    
    @IBOutlet weak var btn_sendComment: UIButton!
    
    @IBOutlet weak var userImgRoundView: UIView!
    @IBOutlet weak var lastCommentImgRoundView: UIView!
    
    @IBOutlet weak var img_user: UIImageView!    
    @IBOutlet weak var txt_comment: GrowingTextView!
    @IBOutlet weak var img_comment_user: UIImageView!
    @IBOutlet weak var vw_comment: UIView!
    @IBOutlet weak var btn_shareMain: UIButton!
    @IBOutlet weak var btn_commentMain: UIButton!
    @IBOutlet weak var lbl_likeMain: UILabel!
    @IBOutlet weak var btn_likeMain: UIButton!
    @IBOutlet weak var lbl_commentCount: UILabel!
    @IBOutlet weak var btn_comment: UIButton!
    @IBOutlet weak var lbl_likeCount: UILabel!
    @IBOutlet weak var btn_like: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lbl_description: UILabel!
    @IBOutlet weak var lbl_dateTime: UILabel!
    @IBOutlet weak var lbl_name: UILabel!
    
    @IBOutlet weak var mainStackView: UIStackView!
    
    @IBOutlet weak var stackView1: UIStackView!
    @IBOutlet weak var stackView1_View: UIView!
    @IBOutlet weak var stackView1_ImgView: UIImageView!
    @IBOutlet weak var stackView1_Btn: UIButton!
    
    @IBOutlet weak var stackView2: UIStackView!
    @IBOutlet weak var stackView2_widthConstant: NSLayoutConstraint!
    
    @IBOutlet weak var stackView2_View1: UIView!
    @IBOutlet weak var stackView2_ImgView1: UIImageView!
    @IBOutlet weak var stackView2_Btn1: UIButton!
    
    @IBOutlet weak var stackView2_View2: UIView!
    @IBOutlet weak var stackView2_ImgView2: UIImageView!
    @IBOutlet weak var stackView2_Btn2: UIButton!
    
    @IBOutlet weak var readMoreLblComment: UILabel!
    
    @IBOutlet weak var pgControl: UIPageControl!
    @IBOutlet weak var StackViewHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var MessagetxtHeightConst: NSLayoutConstraint!
    var gradient1 = CAGradientLayer()
    var lastCommentGradient1 = CAGradientLayer()
    var mainVC : TribefullDeatilsVC?
    var arr_imgs = [[String:Any]]()
    
    
    override func awakeFromNib() {
        //txt_comment.setLeftPaddingPoints(10)
        txt_comment.delegate = self
//        collectionView.delegate = self
//        collectionView.dataSource = self
        
//        let customLayout = UICollectionViewFlowLayout()
//        customLayout.itemSize = CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
//        customLayout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
//        customLayout.minimumInteritemSpacing = 0
//        customLayout.minimumLineSpacing = 0
//        customLayout.scrollDirection = .horizontal
//        collectionView.collectionViewLayout = customLayout
        
//        pgControl.hidesForSinglePage = true
        
    }
    func textViewDidChangeSelection(_ textView: UITextView) {
        if txt_comment.text?.count == 50 {
            self.MessagetxtHeightConst.constant = 40
        }else if txt_comment.text!.count > 50{
            self.MessagetxtHeightConst.constant = 70
        }else if txt_comment.text!.count > 100{
            self.MessagetxtHeightConst.constant = 100
        }else if txt_comment.text!.count > 150{
            self.MessagetxtHeightConst.constant = 130
        }else{
            self.MessagetxtHeightConst.constant = 40
        }
    }
    

//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return arr_imgs.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Tribefullcollcell", for: indexPath) as! Tribefullcollcell
//        let dict = arr_imgs[indexPath.row]
////        cell.img_disp.sd_setImage(with: URL(string: "\(Config().baseImageUrl)\(DataManager.getVal(dict["images"]) as? String ?? "")"), completed: nil)
//        Config().setimage(image_url: "\(Config().baseImageUrl)\(DataManager.getVal(dict["images"]) as? String ?? "")", image_name: cell.img_disp)
//        return cell
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height-10)
//    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let dict = arr_imgs[indexPath.row]
//        let img = DataManager.getVal(dict["images"]) as? String ?? ""
//        let vc = mainVC?.storyboard?.instantiateViewController(withIdentifier: "ExpandedImageViewController") as! ExpandedImageViewController
//         vc.urlStr = img
//         vc.shouldPrefix = true
//        mainVC?.navigationController?.pushViewController(vc, animated: true)
//    }
    
//    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//
//        if pgControl.currentPage == indexPath.row {
//            guard let visible = collectionView.visibleCells.first else { return }
//            guard let index = collectionView.indexPath(for: visible)?.row else { return }
//            pgControl.currentPage = index
//        }
//    }
}

class Tribefulltblcell3: UITableViewCell{
    @IBOutlet weak var AdsImageView: UIImageView!
    @IBOutlet weak var AdsLbl: UILabel!
    @IBOutlet weak var lbllink: UILabel!
}

class Tribefulltblcell2: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,GrowingTextViewDelegate{
    
    @IBOutlet weak var meetupImg: UIImageView!
    @IBOutlet weak var meetupName: UILabel!
    @IBOutlet weak var MeetupSubName: UILabel!
    
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userAdd: UILabel!
    
    var arr_Going = [[String:Any]]()
    var arr_NotGoing = [[String:Any]]()
    var arr_MightGo = [[String:Any]]()
    var cellDict = [String: Any]()
    
    @IBOutlet weak var picturesCollectionViewGoing: UICollectionView!
    @IBOutlet weak var picturesCollectionViewNotGoing: UICollectionView!
    @IBOutlet weak var picturesCollectionViewMightGoing: UICollectionView!
    @IBOutlet weak var picturesCollectionViewGoingWidthConstranit: NSLayoutConstraint!
    @IBOutlet weak var picturesCollectionViewNotGoingWidthConstranit: NSLayoutConstraint!
    @IBOutlet weak var picturesCollectionViewMightGoingWidthConstranit: NSLayoutConstraint!
    @IBOutlet weak var lblGoing: UILabel!
    @IBOutlet weak var lblNotGoing: UILabel!
    @IBOutlet weak var lblMightGo: UILabel!
    @IBOutlet weak var btngoing: UIButton!
    @IBOutlet weak var btnmightgo: UIButton!
    @IBOutlet weak var btnnotgoing: UIButton!
    
    @IBOutlet weak var meetupDate: UILabel!
    @IBOutlet weak var meetupTimeLbl: UILabel!
    @IBOutlet weak var meetupAddLbl: UILabel!
    @IBOutlet weak var meetupTime_AmPm: UILabel!
    @IBOutlet weak var ReadMoreBtn: UIButton!
    @IBOutlet weak var desCriptionLabel: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var CommentBtn: UIButton!
    @IBOutlet weak var numberOfLikeLbl: UILabel!
    
    @IBOutlet weak var writeCommentTextField: GrowingTextView!
    @IBOutlet weak var writeComment_img: UIImageView!
    @IBOutlet weak var lastCommentViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var lastComment_img: UIImageView!
    
    @IBOutlet weak var lastCommentView: UIView!
    @IBOutlet weak var writeCommentViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var lastComment_commentmessage: UILabel!
    @IBOutlet weak var latComment_nameLbl: UILabel!
    
    @IBOutlet weak var readMoreLblComment: UILabel!
    
    @IBOutlet weak var userImgRoundView: UIView!
    @IBOutlet weak var lastCommentImgRoundView: UIView!
    
    @IBOutlet weak var allowShareBtn: UIButton!
    @IBOutlet weak var allowCommentBtn: UIButton!
    @IBOutlet weak var allowLikeBtn: UIButton!
    @IBOutlet weak var sendMessageBtn: UIButton!
    @IBOutlet weak var MessagetxtHeightConst: NSLayoutConstraint!
    @IBAction func allowShareBtnAction(_ sender: Any) {
    }
    @IBAction func allowCommentBtnAction(_ sender: Any) {
        
    }
    @IBAction func allowLikeBtnAction(_ sender: Any) {
        
    }
    @IBAction func ReadMoreBtnAction(_ sender: Any) {
        
    }
    @IBAction func numberOfCommentBtnAction(_ sender: Any) {
    }
    @IBAction func sendMessageBtn_Action(_ sender: Any) {
    }
    @IBOutlet weak var numberOfCommentLbl: UILabel!
    @IBAction func likeBtnAction(_ sender: Any) {
    }
    var mainVC : TribefullDeatilsVC?
    var gradient = CAGradientLayer()
    var lastCommentGradient = CAGradientLayer()
    
    override func awakeFromNib() {
       // writeCommentTextField.setLeftPaddingPoints(10)
        writeCommentTextField.delegate = self
        picturesCollectionViewGoing.register(UINib(nibName: "CustomOnlyPicturesCell", bundle: nil), forCellWithReuseIdentifier: "CustomOnlyPicturesCell")
        picturesCollectionViewNotGoing.register(UINib(nibName: "CustomOnlyPicturesCell", bundle: nil), forCellWithReuseIdentifier: "CustomOnlyPicturesCell")
        picturesCollectionViewMightGoing.register(UINib(nibName: "CustomOnlyPicturesCell", bundle: nil), forCellWithReuseIdentifier: "CustomOnlyPicturesCell")
        
        
        picturesCollectionViewGoing.delegate = self
        picturesCollectionViewGoing.dataSource = self
        picturesCollectionViewGoing.reloadData()
        
        
        picturesCollectionViewNotGoing.delegate = self
        picturesCollectionViewNotGoing.dataSource = self
        picturesCollectionViewNotGoing.reloadData()
        
        
        picturesCollectionViewMightGoing.delegate = self
        picturesCollectionViewMightGoing.dataSource = self
        picturesCollectionViewMightGoing.reloadData()
//        collectionView.delegate = self
//        collectionView.dataSource = self
//
//        let customLayout = UICollectionViewFlowLayout()
//        customLayout.itemSize = CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
//        customLayout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
//        customLayout.minimumInteritemSpacing = 0
//        customLayout.minimumLineSpacing = 0
//        customLayout.scrollDirection = .horizontal
//        collectionView.collectionViewLayout = customLayout
//
//        pgControl.hidesForSinglePage = true
                
        
    }
    func textViewDidChangeSelection(_ textView: UITextView) {
        if writeCommentTextField.text?.count == 50 {
            self.MessagetxtHeightConst.constant = 40
        }else if writeCommentTextField.text!.count > 50{
            self.MessagetxtHeightConst.constant = 70
        }else if writeCommentTextField.text!.count > 100{
            self.MessagetxtHeightConst.constant = 100
        }else if writeCommentTextField.text!.count > 150{
            self.MessagetxtHeightConst.constant = 130
        }else{
            self.MessagetxtHeightConst.constant = 40
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.picturesCollectionViewGoing {
            if self.arr_Going.count > 4 {
                return 4
            }else{
                return self.arr_Going.count
            }
            
        }else if collectionView == self.picturesCollectionViewNotGoing {
            if self.arr_NotGoing.count > 4 {
                return 4
            }else{
                return self.arr_NotGoing.count
            }
        }else{
            if self.arr_MightGo.count > 4 {
                return 4
            }else{
                return self.arr_MightGo.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.picturesCollectionViewGoing {
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
        }else if collectionView == self.picturesCollectionViewNotGoing {
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

class Tribefullcollcell: UICollectionViewCell{
    
    @IBOutlet weak var img_disp: UIImageView!
}
class TribefullDeatilsVC: UIViewController,refereshApi,refereshApi1 {
    func refresh1(data: String) {
        api_call()
    }
    func refresh(data: String) {
        api_call()
    }
    var expandedIndexSet : IndexSet = []
    var expandedIndexSetForLastComment : IndexSet = []
    @IBOutlet weak var searchview: UIView!
    
    @IBOutlet weak var DeletePostViewPopUp: UIView!
    @IBOutlet weak var DeletePostViewPopUpCornerRadius: UIView!
    @IBOutlet weak var popUpView_ContinueBtn: UIButton!
    @IBOutlet weak var popUpView_CancelBtn: UIButton!
    var ccc = "0"
    @IBOutlet weak var ShowNewinviteStatus: UILabel!
    
    @IBOutlet weak var img_disp: UIImageView!
    @IBOutlet weak var tableview: UITableView!
    var adsrighturl = ""
    @IBAction func btn_createMeetupAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "CreateMeetUpVC") as! CreateMeetUpVC
        vc.getminitribelistUserId = self.miniTribeListing
        vc.delegate = self
        vc.ShareWithMiniTribeId = self.currentMiniTribeID
        vc.ShareWithMiniTribeName = self.lbl_titleheading.text ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBOutlet weak var txt_shareYourPerspective: UITextField!
    @IBOutlet weak var txt_search: UITextField!
    @IBOutlet weak var lbl_heading: UIButton!
    @IBOutlet weak var lbl_titleheading: UILabel!
    @IBOutlet weak var btnInvite: UIButton!
    
    @IBAction func btn_backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btn_sharePerspective(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "CreatePostVC") as! CreatePostVC
        vc.user_Img = DataManager.getVal(dict["image"]) as? String ?? ""
        vc.userName = DataManager.getVal(dict["name"]) as? String ?? ""
        vc.miniTribeId = DataManager.getVal(dict["id"]) as? String ?? ""
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    var currentMiniTribeID = String()
    var comesFromMyMiniAndMiniTribe = String()
    var deletePostId = String()
    var miniTribeId = ""
    var dict : [String:Any] = [:]
    var arr_postData = [[String:Any]]()
    var filteredData = [[String:Any]]()
    var miniTribeListing = String()
    
    var notitficatioData = [String:Any]()
    var isComeFromPushNotitfication = String()
    var other_id = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        selecteIndexpathForReferesh = IndexPath(row: 0, section: 0)
        tableview.rowHeight = UITableView.automaticDimension
        btnInvite.isHidden = true
        btnInvite.layer.cornerRadius = btnInvite.frame.width/2
        ShowNewinviteStatus.layer.cornerRadius = 4.5
        
        DeletePostViewPopUpCornerRadius.layer.cornerRadius = 8
        popUpView_ContinueBtn.layer.cornerRadius = 6
        popUpView_CancelBtn.layer.cornerRadius = 6
        popUpView_CancelBtn.layer.borderColor = UIColor.lightGray.cgColor
        popUpView_CancelBtn.layer.borderWidth = 0.5
        
        txt_shareYourPerspective.setLeftPaddingPoints(10)
        txt_search.setLeftPaddingPoints(10)
        txt_search.addTarget(self, action: #selector(searchRecordsAsPerText(_ :)), for: .editingChanged)
        
        searchview.layer.cornerRadius = 6
        searchview.layer.borderWidth = 1
        searchview.layer.borderColor = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.9176470588, alpha: 1)
        txt_shareYourPerspective.layer.cornerRadius = 5
        
        filteredData = arr_postData
        api_call()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
    }
    
    @IBAction func btninvite(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "InviatationsVC") as! InviatationsVC
        vc.miniTribeId = self.miniTribeId
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func searchRecordsAsPerText(_ textfield:UITextField) {
        filteredData.removeAll()
        if txt_search.text?.count != 0 {
            for anyObject in arr_postData {
                let dict = DataManager.getVal(anyObject) as? [String:Any] ?? [:]
                let range = (DataManager.getVal(dict["user_name"]) as? String ?? "").lowercased().range(of: txt_search.text ?? "", options: .caseInsensitive, range: nil,   locale: nil)

                if range != nil { filteredData.append(dict) }
            }
        } else { filteredData = arr_postData }
        tableview.reloadData()
    }
    
    func api_call(){
        basicFunctions.presentLoader()
        let paraDict = NSMutableDictionary()
        let timeZone = TimeZone.current.identifier
        paraDict.setValue(Config().api_key, forKey: "api_key")
//        paraDict.setValue("25", forKey: "user_id")
        paraDict.setValue(timeZone, forKey: "timezone")
        let loginUser = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
        paraDict.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
        
        print(paraDict)
        var methodName = ""
        let minitribeId = DataManager.getVal(self.notitficatioData["mini_tribe_id"]) as? String ?? ""
        let miniTribeUSerId = DataManager.getVal(self.notitficatioData["user_id"]) as? String ?? ""
        if self.isComeFromPushNotitfication == "yes" {
            paraDict.setValue(minitribeId, forKey: "mini_tribe_id")
            if loginUser == miniTribeUSerId {
                methodName = "get_detail_my_mini_tribe"
                self.btnInvite.isHidden = false
                self.ShowNewinviteStatus.isHidden = false
            }else{
                methodName = "get_detail_mini_tribe"
                self.btnInvite.isHidden = true
                self.ShowNewinviteStatus.isHidden = true
            }
        }else{
            paraDict.setValue(miniTribeId, forKey: "mini_tribe_id")
            if self.comesFromMyMiniAndMiniTribe == "MyMiniTribes" {
                methodName = "get_detail_my_mini_tribe"
                self.btnInvite.isHidden = false
                self.ShowNewinviteStatus.isHidden = false
            }else{
                methodName = "get_detail_mini_tribe"
                self.btnInvite.isHidden = true
                self.ShowNewinviteStatus.isHidden = true
            }
        }
        print(paraDict)
        DataManager.getAPIResponse(paraDict , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
            print(message)
            if status == "1" {
                self.dict = DataManager.getVal(responseData?["data"]) as? [String:Any] ?? [:]
                print(self.dict)
                self.setupData()
            }
            else {
                self.view.makeToast(message)
            }
//        self.tableview.reloadData()
        basicFunctions.stopLoading()
        }
    }
    
    func api_callNew(tag:Int!){
        basicFunctions.presentLoader()
        let paraDict = NSMutableDictionary()
        let timeZone = TimeZone.current.identifier
        paraDict.setValue(Config().api_key, forKey: "api_key")
//        paraDict.setValue("25", forKey: "user_id")
        paraDict.setValue(timeZone, forKey: "timezone")
        let loginUser = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
        paraDict.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
        
        print(paraDict)
        var methodName = ""
        let minitribeId = DataManager.getVal(self.notitficatioData["mini_tribe_id"]) as? String ?? ""
        let miniTribeUSerId = DataManager.getVal(self.notitficatioData["user_id"]) as? String ?? ""
        if self.isComeFromPushNotitfication == "yes" {
            paraDict.setValue(minitribeId, forKey: "mini_tribe_id")
            if loginUser == miniTribeUSerId {
                methodName = "get_detail_my_mini_tribe"
                self.btnInvite.isHidden = false
                self.ShowNewinviteStatus.isHidden = false
            }else{
                methodName = "get_detail_mini_tribe"
                self.btnInvite.isHidden = true
                self.ShowNewinviteStatus.isHidden = true
            }
        }else{
            paraDict.setValue(miniTribeId, forKey: "mini_tribe_id")
            if self.comesFromMyMiniAndMiniTribe == "MyMiniTribes" {
                methodName = "get_detail_my_mini_tribe"
                self.btnInvite.isHidden = false
                self.ShowNewinviteStatus.isHidden = false
            }else{
                methodName = "get_detail_mini_tribe"
                self.btnInvite.isHidden = true
                self.ShowNewinviteStatus.isHidden = true
            }
        }
        print(paraDict)
        DataManager.getAPIResponse(paraDict , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
            print(message)
            if status == "1" {
                self.dict = DataManager.getVal(responseData?["data"]) as? [String:Any] ?? [:]
                print(self.dict)
                self.setupDataNew(index: tag)
            }
            else {
                self.view.makeToast(message)
            }
//        self.tableview.reloadData()
        basicFunctions.stopLoading()
        }
    }
    
    func setupData(){
        self.img_disp.sd_setImage(with: URL(string:  "\(Config().baseImageUrl)\(DataManager.getVal(dict["image"]) as? String ?? "")"), completed: nil)
        self.img_disp.layer.cornerRadius = self.img_disp.frame.size.width/2
        self.lbl_heading.setTitle(DataManager.getVal(dict["name"]) as? String ?? "", for: .normal)
        self.lbl_titleheading.text = DataManager.getVal(dict["name"]) as? String ?? ""
        self.arr_postData = DataManager.getVal(dict["miniTribePostData"]) as? [[String:Any]] ?? []
        print(self.arr_postData)
        self.currentMiniTribeID = DataManager.getVal(dict["id"]) as? String ?? ""
        self.filteredData = self.arr_postData
    //    invites_count
        let invitecount = DataManager.getVal(dict["invites_count"]) as? String ?? ""
        
        if self.comesFromMyMiniAndMiniTribe == "MyMiniTribes" {
            if invitecount == "0" {
                self.ShowNewinviteStatus.isHidden = true
            }else{
                self.ShowNewinviteStatus.isHidden = false
            }
        }
        
        if ccc == "1" {
            self.tableview.reloadData()
            if self.filteredData.count != 0 {
                print(selecteIndexpathForReferesh)
                self.tableview.scrollToRow(at: selecteIndexpathForReferesh, at: .top, animated: false)
            }
            ccc = "0"
        }else{
            self.tableview.reloadData()
           
            if self.filteredData.count != 0 {
                print(selecteIndexpathForReferesh)
                self.tableview.scrollToRow(at: selecteIndexpathForReferesh, at: .top, animated: false)
            }
            
            let neotid = Int(self.other_id) ?? 0
            if neotid == 0 {
                if self.filteredData.count != 0 {
                    let index = IndexPath(row: 0, section: 0)
                    self.tableview.scrollToRow(at: index, at: .none, animated: false)
                }
               
            }else{
                for (index, element) in arr_postData.enumerated() {
                  print("Item \(index): \(element)")
                    var dictn = NSDictionary()
                    dictn = self.arr_postData[index] as NSDictionary
                    let id = dictn.value(forKey: "id") as? Int ?? 0
                    let newid = String(id)
                    if newid == other_id {
                        if self.filteredData.count != 0 {
                        let index = IndexPath(row: index, section: 0)
                        self.tableview.scrollToRow(at: index, at: .none, animated: false)
                        }
                        break
                    }
                }
            }

        }
        
               
    }
    
    func setupDataNew(index:Int!){
        self.img_disp.sd_setImage(with: URL(string:  "\(Config().baseImageUrl)\(DataManager.getVal(dict["image"]) as? String ?? "")"), completed: nil)
        self.img_disp.layer.cornerRadius = self.img_disp.frame.size.width/2
        self.lbl_heading.setTitle(DataManager.getVal(dict["name"]) as? String ?? "", for: .normal)
        self.lbl_titleheading.text = DataManager.getVal(dict["name"]) as? String ?? ""
        self.arr_postData = DataManager.getVal(dict["miniTribePostData"]) as? [[String:Any]] ?? []
        print(self.arr_postData)
        self.currentMiniTribeID = DataManager.getVal(dict["id"]) as? String ?? ""
        self.filteredData = self.arr_postData
    //    invites_count
        let invitecount = DataManager.getVal(dict["invites_count"]) as? String ?? ""
        
        if self.comesFromMyMiniAndMiniTribe == "MyMiniTribes" {
            if invitecount == "0" {
                self.ShowNewinviteStatus.isHidden = true
            }else{
                self.ShowNewinviteStatus.isHidden = false
            }
        }
        
      //  self.tableview.reloadData()
        if self.filteredData.count != 0 {
            print(selecteIndexpathForReferesh)
            let indexnew = IndexPath(row: index, section: 0)
            self.tableview.reloadRows(at: [indexnew], with: .automatic)
           // self.tableview.scrollToRow(at: selecteIndexpathForReferesh, at: .none, animated: false)
            
        }
    }
    
    @IBAction func popUpDelete_Post(_ sender: UIButton) {
        DeletePostViewPopUp.removeFromSuperview()
        self.deletePostApi(id: self.deletePostId)
    }
    @IBAction func popUpCancel_Post(_ sender: UIButton) {
        DeletePostViewPopUp.removeFromSuperview()
    }
}


extension TribefullDeatilsVC: UITableViewDelegate,UITableViewDataSource{
    
    @objc func ReadMorebtnclicked(_ sender : UIButton) {
        
//        let cell = exploreMeetupTableView.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! ExploreMeetUpcell
        if(expandedIndexSet.contains(sender.tag)){
                  expandedIndexSet.remove(sender.tag)
              }else{
                  expandedIndexSet.insert(sender.tag)
              }
              let index = IndexPath(row: sender.tag, section: 0)
              self.tableview.reloadRows(at: [index], with: .automatic)
        
//        let cell = self.exploreMeetupTableView!.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as? ExploreMeetUpcell
//
//        if cell!.readMoreBtn.currentTitle == "Read More" {
//            cell?.readMoreBtn.setTitle("Show Less", for: .normal)
//            cell?.lbldetails.numberOfLines = 0
//        }else{
//            cell?.readMoreBtn.setTitle("Read More", for: .normal)
//            cell?.lbldetails.numberOfLines = 1
//        }
////                if(cell!.fixedHeightCon.priority == UILayoutPriority(rawValue: 250)){
////                    cell!.readMoreBtn.setTitle("Read More", for: UIControl.State.normal)
////                    cell!.fixedHeightCon.priority = UILayoutPriority(rawValue: 750)
////                    cell!.graterHeightCon.priority = UILayoutPriority(rawValue: 250)
////                }else{
////                    cell!.readMoreBtn.setTitle("Show Less", for: UIControl.State.normal)
////                    cell!.fixedHeightCon.priority = UILayoutPriority(rawValue: 250)
////                    cell!.graterHeightCon.priority = UILayoutPriority(rawValue: 750)
////                }
//        let indexPath = IndexPath(item: sender.tag, section: 0)
//        self.exploreMeetupTableView.reloadRows(at: [indexPath], with: .fade)
            }
    
    @objc func linkLblClicked(_ sender : UITapGestureRecognizer) {

        let cell = self.tableview.cellForRow(at: IndexPath(row: sender.view?.tag ?? -1, section: 0)) as! Tribefulltblcell
        
        
        let str = cell.lbl_description.text?.detectedLinks
       
        
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
//        let temp = cell.lbl_description.text?.detectedURLs
//
//        if temp?.count ?? 0 > 0 {
//            let str = cell.lbl_description.text?.detectedURLs[0]
//
//
//        }
    }
    @objc func vw_lastMsgView(_ sender : UITapGestureRecognizer) {
        if(expandedIndexSetForLastComment.contains(sender.view?.tag ?? -1)){
            expandedIndexSetForLastComment.remove(sender.view?.tag ?? -1)
              }else{
                  expandedIndexSetForLastComment.insert(sender.view?.tag ?? -1)
              }
              let index = IndexPath(row: sender.view?.tag ?? -1, section: 0)
              self.tableview.reloadRows(at: [index], with: .automatic)
    }
    @objc func vw_lastMsgView1(_ sender : UITapGestureRecognizer) {
        if(expandedIndexSetForLastComment.contains(sender.view?.tag ?? -1)){
            expandedIndexSetForLastComment.remove(sender.view?.tag ?? -1)
              }else{
                  expandedIndexSetForLastComment.insert(sender.view?.tag ?? -1)
              }
              let index = IndexPath(row: sender.view?.tag ?? -1, section: 0)
              self.tableview.reloadRows(at: [index], with: .automatic)
        
    }
    @objc func lastCommentLblLink(_ sender : UITapGestureRecognizer) {

        let cell = self.tableview.cellForRow(at: IndexPath(row: sender.view?.tag ?? -1, section: 0)) as! Tribefulltblcell

        let str = cell.lbl_lastCommentUserComment.text?.detectedLinks
       
        
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
    
    @objc func linkLblClicked1(_ sender : UITapGestureRecognizer) {

        let cell = self.tableview.cellForRow(at: IndexPath(row: sender.view?.tag ?? -1, section: 0)) as! Tribefulltblcell2
        let str = cell.desCriptionLabel.text?.detectedLinks
       
        
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
       
    @objc func lastCommentLblLink1(_ sender : UITapGestureRecognizer) {

        let cell = self.tableview.cellForRow(at: IndexPath(row: sender.view?.tag ?? -1, section: 0)) as! Tribefulltblcell2
        let str = cell.lastComment_commentmessage.text?.detectedLinks
       
        
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
    
    @objc func BtnGoingAction(_ sender: UIButton){
        
        selecteIndexpathForReferesh = IndexPath(row: sender.tag, section: 0)
        let cell = self.tableview.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! Tribefulltblcell2
        
        let dict = filteredData[sender.tag]
        let miniTribeId = DataManager.getVal(dict["mini_tribe_id"]) as? String ?? ""
        let id = DataManager.getVal(dict["id"]) as? String ?? ""
        print(dict)
        basicFunctions.presentLoader()
        self.view.endEditing(true)

        let paraDict = NSMutableDictionary()
        paraDict.setValue(Config().api_key, forKey: "api_key")
        paraDict.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
        paraDict.setValue(miniTribeId , forKey: "mini_tribe_id")
        paraDict.setValue(id , forKey: "mini_tribe_meetup_id")
        paraDict.setValue("1", forKey: "status")
        paraDict.setValue("meetup", forKey: "type")

        let methodName = "meetup_status_change"
        DataManager.getAPIResponse(paraDict , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
             let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
             let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
                print(message)
             if status == "1" {
                 self.api_call()
                 cell.btngoing.backgroundColor = UIColor(red: 0.05, green: 0.23, blue: 0.66, alpha: 0.2)
                 cell.btnmightgo.backgroundColor = UIColor.white
                 cell.btnnotgoing.backgroundColor = UIColor.white
             }
             else {
                print(message)
             }
            basicFunctions.stopLoading()
        }
    }
    @objc func BtnNotGoingAction(_ sender: UIButton){
        
        selecteIndexpathForReferesh = IndexPath(row: sender.tag, section: 0)
        let cell = self.tableview.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! Tribefulltblcell2
        let dict = filteredData[sender.tag]
        let miniTribeId = DataManager.getVal(dict["mini_tribe_id"]) as? String ?? ""
        let id = DataManager.getVal(dict["id"]) as? String ?? ""
        print(dict)
        basicFunctions.presentLoader()
        self.view.endEditing(true)

        let paraDict = NSMutableDictionary()
        paraDict.setValue(Config().api_key, forKey: "api_key")
        paraDict.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
        paraDict.setValue(miniTribeId , forKey: "mini_tribe_id")
        paraDict.setValue(id , forKey: "mini_tribe_meetup_id")
        paraDict.setValue("2", forKey: "status")
        paraDict.setValue("meetup", forKey: "type")

        let methodName = "meetup_status_change"
        DataManager.getAPIResponse(paraDict , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
             let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
             let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
                print(message)
             if status == "1" {
                 self.api_call()
                 cell.btngoing.backgroundColor = UIColor.white
                 cell.btnmightgo.backgroundColor = UIColor.white
                 cell.btnnotgoing.backgroundColor = UIColor(red: 0.05, green: 0.23, blue: 0.66, alpha: 0.2)
             }
             else {
                print(message)
             }
            basicFunctions.stopLoading()
        }
    }
    
    @objc func moreImageShow(_ sender: UIButton){
        
        let cell = self.tableview.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! Tribefulltblcell
        if cell.arr_imgs.count  == 1 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "ExpandedImageViewController") as! ExpandedImageViewController
            let dict = cell.arr_imgs[0]
            let img = DataManager.getVal(dict["images"]) as? String ?? ""
            vc.urlStr = img
            vc.shouldPrefix = true
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = storyboard?.instantiateViewController(withIdentifier: "showMoreImagesVC") as! showMoreImagesVC
            vc.arrImg = cell.arr_imgs
            self.navigationController?.pushViewController(vc, animated: true)
        }
       
        
        
    }
    
    @objc func BtnMightGoAction(_ sender: UIButton){
        
        selecteIndexpathForReferesh = IndexPath(row: sender.tag, section: 0)
        let cell = self.tableview.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! Tribefulltblcell2
        let dict = filteredData[sender.tag]
        let miniTribeId = DataManager.getVal(dict["mini_tribe_id"]) as? String ?? ""
        let id = DataManager.getVal(dict["id"]) as? String ?? ""
        print(dict)
        basicFunctions.presentLoader()
        self.view.endEditing(true)

        let paraDict = NSMutableDictionary()
        paraDict.setValue(Config().api_key, forKey: "api_key")
        paraDict.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
        paraDict.setValue(miniTribeId , forKey: "mini_tribe_id")
        paraDict.setValue(id , forKey: "mini_tribe_meetup_id")
        paraDict.setValue("3", forKey: "status")
        paraDict.setValue("meetup", forKey: "type")

        let methodName = "meetup_status_change"
        DataManager.getAPIResponse(paraDict , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
             let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
             let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
                print(message)
             if status == "1" {
                 self.api_call()
                 cell.btngoing.backgroundColor = UIColor.white
                 cell.btnmightgo.backgroundColor = UIColor(red: 0.05, green: 0.23, blue: 0.66, alpha: 0.2)
                 cell.btnnotgoing.backgroundColor = UIColor.white
             }
             else {
                print(message)
             }
            basicFunctions.stopLoading()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredData.count == 0{
            let vw = basicFunctions.noDataAvailableWithImageNew(str: "No Posts Found. Check Back Soon!", tbl: tableView)
            tableView.backgroundView  = vw
            return 0
        }else{
            tableView.backgroundView  = nil
            return filteredData.count
        }
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 791.0
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dict = filteredData[indexPath.row]
        let cellType = DataManager.getVal(dict["type"]) as? String ?? ""
        if cellType == "meetup" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Tribefulltblcell2", for: indexPath) as! Tribefulltblcell2
            cell.writeCommentTextField.layer.cornerRadius = 6
            cell.lastCommentView.layer.cornerRadius = 6
            cell.userImg.layer.cornerRadius = cell.userImg.frame.width/2
            cell.userName.text = DataManager.getVal(dict["user_name"]) as? String ?? ""
            Config().setimage(image_url: "\(Config().baseImageUrl)" + "\(DataManager.getVal(dict["user_image"]) as? String ?? "")", image_name: cell.userImg)
            let LogInusrImg = UserDefaults.standard.value(forKey: "user_image") as? String ?? ""
            Config().setimage(image_url: "\(Config().baseImageUrl)" + "\(LogInusrImg)", image_name: cell.writeComment_img)
            cell.userAdd.text = DataManager.getVal(dict["updated_at"]) as? String ?? ""
            
            cell.meetupName.text = DataManager.getVal(dict["meetup_topic"]) as? String ?? ""
            cell.meetupDate.text = DataManager.getVal(dict["meetup_date"]) as? String ?? ""
            cell.meetupAddLbl.text = DataManager.getVal(dict["meetup_location"]) as? String ?? ""
            cell.meetupTimeLbl.text = DataManager.getVal(dict["meetup_time"]) as? String ?? ""
            cell.meetupTime_AmPm.text = DataManager.getVal(dict["meetup_period"]) as? String ?? ""
            Config().setimage(image_url: "\(Config().baseImageUrl)" + "\(DataManager.getVal(dict["meetup_image"]) as? String ?? "")", image_name: cell.meetupImg)
            cell.desCriptionLabel.text = DataManager.getVal(dict["meetup_description"]) as? String ?? ""
            cell.numberOfLikeLbl.text = DataManager.getVal(dict["minitribePostLikeCount"]) as? String ?? ""
            cell.numberOfCommentLbl.text = DataManager.getVal(dict["minitribePostCommentCount"]) as? String ?? ""
            
            let newstatus = DataManager.getVal(dict["ads_status"]) as? String ?? ""
            
            if newstatus == "0"{
                
             }
          else{
              let cell1 = tableView.dequeueReusableCell(withIdentifier: "Tribefulltblcell3", for: indexPath) as! Tribefulltblcell3
            
           // let tap = UITapGestureRecognizer(target: self, action: #selector(adsViewIMgClick(_:)))
              cell1.AdsImageView.isUserInteractionEnabled = true
           // cell1.AdsImageView.addGestureRecognizer(tap)
              cell1.lbllink.text = DataManager.getVal(dict["link"]) as? String ?? ""
              cell1.AdsLbl.text = DataManager.getVal(dict["description"]) as? String ?? ""
              cell1.AdsImageView.sd_setImage(with: URL(string: "\(Config().baseImageUrl)\(DataManager.getVal(dict["image"]) as? String ?? "")"), completed: nil)
          }
           // tap.view?.tag = indexPath.row
            
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(ImageClicked(_:)))
            cell.userImg.isUserInteractionEnabled = true
            cell.userImg.addGestureRecognizer(tap)
            tap.view?.tag = indexPath.row
            
            let lastMsgPresent = DataManager.getVal(dict["last_comment"]) as? String ?? ""
            if lastMsgPresent == "" {
                cell.lastCommentView.isHidden = true
                cell.lastCommentViewHeightConstraint.constant = 0
//                cell.lbl_line.isHidden = true
                cell.writeCommentViewTopConstraint.constant = 0
                cell.latComment_nameLbl.text = ""
                cell.lastComment_commentmessage.text = ""
            }else{
                cell.lastCommentView.isHidden = false
//                cell.lbl_line.isHidden = false
                cell.writeCommentViewTopConstraint.constant = 10
                cell.lastCommentViewHeightConstraint.constant = 60

//                cell.img_lastCommentUser.sd_setImage(with: URL(string: "\(Config().baseImageUrl)\(DataManager.getVal(dict["last_user_profile_image"]) as? String ?? "")"), completed: nil)
                Config().setimage(image_url: "\(Config().baseImageUrl)\(DataManager.getVal(dict["last_user_profile_image"]) as? String ?? "")", image_name: cell.lastComment_img)
                
                print(dict)
                let id = DataManager.getVal(dict["user_id"]) as? String ?? ""
                let tap = UITapGestureRecognizer(target: self, action: #selector(ImageClicked1(_:)))
                cell.lastComment_img.isUserInteractionEnabled = true
                cell.lastComment_img.addGestureRecognizer(tap)
                tap.view?.tag = indexPath.row
                
                cell.latComment_nameLbl.text = DataManager.getVal(dict["last_user_name"]) as? String ?? ""
                cell.lastComment_commentmessage.text = DataManager.getVal(dict["last_comment"]) as? String ?? ""
                
            }
            cell.likeBtn.tag = indexPath.row
            cell.CommentBtn.tag = indexPath.row
            
            cell.allowLikeBtn.tag = indexPath.row
            cell.allowShareBtn.tag = indexPath.row
            cell.sendMessageBtn.tag = indexPath.row
            
            cell.likeBtn.addTarget(self, action: #selector(displayLikesList(_:)), for: .touchUpInside)
            cell.CommentBtn.addTarget(self, action: #selector(displayCommentsList(_:)), for: .touchUpInside)
            
            cell.allowLikeBtn.addTarget(self, action: #selector(likeClicked(_:)), for: .touchUpInside)
            cell.allowShareBtn.addTarget(self, action: #selector(shareClicked(_:)), for: .touchUpInside)
            cell.sendMessageBtn.addTarget(self, action: #selector(commentClicked1(_:)), for: .touchUpInside)
            
            let snapCount = DataManager.getVal(dict["snaps_count"]) as? String ?? ""
            let lastUserSnapCount = DataManager.getVal(dict["last_user_snaps_count"]) as? String ?? ""
            cell.userImgRoundView.layer.cornerRadius = cell.userImgRoundView.frame.width/2
            cell.lastCommentImgRoundView.layer.cornerRadius = cell.lastCommentImgRoundView.frame.width/2
            
            if lastUserSnapCount == "0" {
                cell.lastCommentGradient.removeFromSuperlayer()
            cell.lastCommentImgRoundView.layer.backgroundColor = UIColor.white.cgColor
            }else{
                cell.lastCommentGradient.cornerRadius = cell.lastCommentImgRoundView.layer.cornerRadius
                cell.lastCommentGradient.frame = cell.lastCommentImgRoundView.frame
                cell.lastCommentGradient.colors = [UIColor(red: 0.42, green: 0.39, blue: 1.00, alpha: 1.00).cgColor,UIColor(red: 0.05, green: 0.23, blue: 0.66, alpha: 1.00).cgColor,UIColor(red: 0.10, green: 0.55, blue: 0.65, alpha: 1.00).cgColor,UIColor(red: 0.14, green: 0.90, blue: 0.71, alpha: 1.00).cgColor]
                cell.lastCommentImgRoundView.layer.insertSublayer(cell.lastCommentGradient, at: 0)
                cell.lastCommentGradient.startPoint = CGPoint(x: 0.0, y: 1.0)
                cell.lastCommentGradient.endPoint = CGPoint(x: 1.0, y: 1.0)
                cell.lastCommentGradient.frame = CGRect(x: 0.0, y: 0.0, width: cell.lastCommentImgRoundView.frame.size.width, height: cell.lastCommentImgRoundView.frame.size.height)
            }
            
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
            let liked_status = DataManager.getVal(dict["liked_status"]) as? String ?? ""
            if liked_status == "0" {
                cell.allowLikeBtn.setImage(UIImage(named: "Icon ionic-md-thumbs-up-1"), for: .normal)
            }else{
                cell.allowLikeBtn.setImage(UIImage(named: "Icon ionic-md-thumbs-up-2"), for: .normal)
            }
            cell.arr_Going = DataManager.getVal(dict["meetup_going_members_list"]) as? [[String:Any]] ?? []
            cell.arr_MightGo = DataManager.getVal(dict["meetup_might_go_list"]) as? [[String:Any]] ?? []
            cell.arr_NotGoing = DataManager.getVal(dict["meetup_not_going_members_list"]) as? [[String:Any]] ?? []
            if cell.arr_Going.count == 1 {
                cell.lblGoing.text = "1 person is Going"
            }else{
                cell.lblGoing.text = "\(dict["meetup_going_members"] as? Int ?? 0) People Are Going"
            }
            if cell.arr_NotGoing.count == 1 {
                cell.lblNotGoing.text = "1 person is not Going"
            }else{
                cell.lblNotGoing.text = "\(dict["meetup_not_going_members"] as? Int ?? 0) People Are not Going"
            }
            if cell.arr_MightGo.count == 1 {
                cell.lblMightGo.text = "1 person might Go"
            }else{
                cell.lblMightGo.text = "\(dict["meetup_might_go_members"] as? Int ?? 0) People might Go"
            }
            
            
           let meetupStatus = DataManager.getVal(dict["meetup_status"]) as? String ?? ""
            
            cell.btnmightgo.layer.cornerRadius = 6
            cell.btnmightgo.layer.borderWidth = 0.7
            cell.btnmightgo.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            cell.btnmightgo.backgroundColor = UIColor.white
            
            cell.btnnotgoing.layer.cornerRadius = 6
            cell.btnnotgoing.layer.borderWidth = 0.7
            cell.btnnotgoing.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            cell.btnnotgoing.backgroundColor = UIColor.white
            
            cell.btngoing.layer.cornerRadius = 6
            cell.btngoing.layer.borderWidth = 0.7
            cell.btngoing.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            cell.btngoing.backgroundColor = UIColor.white
           
           if meetupStatus == "1"{
               cell.btngoing.backgroundColor = UIColor(red: 0.05, green: 0.23, blue: 0.66, alpha: 0.2)
               cell.btnmightgo.backgroundColor = UIColor.white
               cell.btnnotgoing.backgroundColor = UIColor.white
           }else if meetupStatus == "2"{
               cell.btngoing.backgroundColor = UIColor.white
               cell.btnmightgo.backgroundColor = UIColor.white
               cell.btnnotgoing.backgroundColor = UIColor(red: 0.05, green: 0.23, blue: 0.66, alpha: 0.2)
           }else if meetupStatus == "3"{
               cell.btngoing.backgroundColor = UIColor.white
               cell.btnmightgo.backgroundColor = UIColor(red: 0.05, green: 0.23, blue: 0.66, alpha: 0.2)
               cell.btnnotgoing.backgroundColor = UIColor.white
           }else{
               cell.btngoing.backgroundColor = UIColor.white
               cell.btnmightgo.backgroundColor = UIColor.white
               cell.btnnotgoing.backgroundColor = UIColor.white
           }
            if cell.arr_Going.count > 4 {
                cell.picturesCollectionViewGoingWidthConstranit.constant = CGFloat(30 * 4)
            }else{
                cell.picturesCollectionViewGoingWidthConstranit.constant = CGFloat(30 * cell.arr_Going.count)
            }
            if cell.arr_NotGoing.count > 4 {
                cell.picturesCollectionViewNotGoingWidthConstranit.constant = CGFloat(30 * 4)
            }else{
                cell.picturesCollectionViewNotGoingWidthConstranit.constant = CGFloat(30 * cell.arr_NotGoing.count)
            }
            if cell.arr_MightGo.count > 4 {
                cell.picturesCollectionViewMightGoingWidthConstranit.constant = CGFloat(30 * 4)
            }else{
                cell.picturesCollectionViewMightGoingWidthConstranit.constant = CGFloat(30 * cell.arr_MightGo.count)
            }
            
            print(cell.desCriptionLabel.text)
            let newstr = cell.desCriptionLabel.text
            let finalstr = newstr?.components(separatedBy: CharacterSet.symbols).joined()       
            cell.desCriptionLabel.text = finalstr
            let temp = cell.desCriptionLabel.text?.detectedURLs
            if temp?.count ?? 0 > 0 {
                let str = cell.desCriptionLabel.text?.detectedLinks[0]
                let string_to_color = str
                let range = (cell.desCriptionLabel.text as? NSString ?? "").range(of: string_to_color ?? "")
                let attribute = NSMutableAttributedString.init(string: cell.desCriptionLabel.text ?? "")
                attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.link , range: range)
                cell.desCriptionLabel.attributedText = attribute
            }
            let temp1 = cell.lastComment_commentmessage.text?.detectedURLs
            if temp1?.count ?? 0 > 0 {
                let str = cell.lastComment_commentmessage.text?.detectedLinks[0]
                
                let string_to_color = str
                let range = (cell.lastComment_commentmessage.text as? NSString ?? "").range(of: string_to_color ?? "")
                let attribute = NSMutableAttributedString.init(string: cell.lastComment_commentmessage.text ?? "")
                attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.link , range: range)
                cell.lastComment_commentmessage.attributedText = attribute
            }
            
            let tap3 = UITapGestureRecognizer(target: self, action: #selector(linkLblClicked1(_:)))
             cell.desCriptionLabel.addGestureRecognizer(tap3)
              tap3.view?.tag = indexPath.row
              
              let tap4 = UITapGestureRecognizer(target: self, action: #selector(lastCommentLblLink1(_:)))
               cell.lastComment_commentmessage.addGestureRecognizer(tap4)
                tap4.view?.tag = indexPath.row
            
            if lastMsgPresent.count >= 120 {
                cell.readMoreLblComment.isHidden = false
            }else{
                cell.readMoreLblComment.isHidden = true
            }
            
            let tapLAstCommentView = UITapGestureRecognizer(target: self, action: #selector(vw_lastMsgView1(_:)))
             cell.lastComment_commentmessage.addGestureRecognizer(tapLAstCommentView)
            tapLAstCommentView.view?.tag = indexPath.row
            
            if expandedIndexSetForLastComment.contains(indexPath.row) {
                        cell.lastComment_commentmessage.numberOfLines = 0
                cell.readMoreLblComment.text = "Read Less"
                    } else {
                        cell.lastComment_commentmessage.numberOfLines = 2
                        cell.readMoreLblComment.text = "Read More"
                    }
            
            cell.btngoing.tag = indexPath.row
            cell.btnnotgoing.tag = indexPath.row
            cell.btnmightgo.tag = indexPath.row
            cell.btngoing.addTarget(self, action: #selector(BtnGoingAction(_:)), for: .touchUpInside)
            cell.btnnotgoing.addTarget(self, action: #selector(BtnNotGoingAction(_:)), for: .touchUpInside)
            cell.btnmightgo.addTarget(self, action: #selector(BtnMightGoAction(_:)), for: .touchUpInside)
            
//            cell.cellDict = dict
            cell.picturesCollectionViewGoing.reloadData()
            cell.picturesCollectionViewNotGoing.reloadData()
            cell.picturesCollectionViewMightGoing.reloadData()
            
            return cell
        }
    else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Tribefulltblcell", for: indexPath) as! Tribefulltblcell
            cell.txt_comment.layer.cornerRadius = 6
            cell.img_user.layer.cornerRadius = cell.img_user.frame.size.width/2
            cell.img_lastCommentUser.layer.cornerRadius = cell.img_lastCommentUser.frame.size.width/2
            cell.vw_lastMsg.layer.cornerRadius = 6
            
            cell.img_user.sd_setImage(with: URL(string: "\(Config().baseImageUrl)\(DataManager.getVal(dict["user_image"]) as? String ?? "")"), completed: nil)
           
            let tap = UITapGestureRecognizer(target: self, action: #selector(ImageClicked(_:)))
            cell.img_user.isUserInteractionEnabled = true
            cell.img_user.addGestureRecognizer(tap)
            tap.view?.tag = indexPath.row
            
            cell.lbl_name.text = DataManager.getVal(dict["user_name"]) as? String ?? ""
            cell.lbl_dateTime.text = DataManager.getVal(dict["date_time"]) as? String ?? ""
            cell.lbl_description.text = DataManager.getVal(dict["perspective"]) as? String ?? ""
        
        
          let newstatus = DataManager.getVal(dict["ads_status"]) as? String ?? ""
        
          if newstatus == "0" || newstatus == ""{
              
           }else{
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "Tribefulltblcell3", for: indexPath) as! Tribefulltblcell3
          
         // let tap = UITapGestureRecognizer(target: self, action: #selector(adsViewIMgClick(_:)))
            cell1.AdsImageView.isUserInteractionEnabled = true
         // cell1.AdsImageView.addGestureRecognizer(tap)
            cell1.lbllink.text = DataManager.getVal(dict["description"]) as? String ?? ""
            cell1.AdsLbl.text = DataManager.getVal(dict["title"]) as? String ?? ""
            cell1.AdsImageView.sd_setImage(with: URL(string: "\(Config().baseImageUrl)\(DataManager.getVal(dict["image"]) as? String ?? "")"), completed: nil)
            return cell1
        }
        
        
          
       // tap.view?.tag = indexPath.row
            
            //MARK:- Check link in UILabal
            
            print(cell.lbl_description.text?.detectedLinks)
            
            let temp = cell.lbl_description.text?.detectedURLs
            if temp?.count ?? 0 > 0 {
                let str = cell.lbl_description.text?.detectedLinks[0]
                let string_to_color = str
                let range = (cell.lbl_description.text as? NSString ?? "").range(of: string_to_color ?? "")
                let attribute = NSMutableAttributedString.init(string: cell.lbl_description.text ?? "")
                attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.link , range: range)
                cell.lbl_description.attributedText = attribute
            }
            let temp1 = cell.lbl_lastCommentUserComment.text?.detectedURLs
            if temp1?.count ?? 0 > 0 {
                let str = cell.lbl_lastCommentUserComment.text?.detectedLinks[0]
                let string_to_color = str
                let range = (cell.lbl_lastCommentUserComment.text as? NSString ?? "").range(of: string_to_color ?? "")
                let attribute = NSMutableAttributedString.init(string: cell.lbl_lastCommentUserComment.text ?? "")
                attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.link , range: range)
                cell.lbl_lastCommentUserComment.attributedText = attribute
            }
            cell.readMorebtn.titleLabel?.font =  UIFont(name: "OpenSans-SemiBold", size: 12) ?? UIFont.systemFont(ofSize: 12)
            cell.readMorebtn.tag = indexPath.row
            cell.readMorebtn.addTarget(self, action: #selector(ReadMorebtnclicked(_ :)), for: .touchUpInside)
            if cell.lbl_description.text?.count ?? 0 <= 40 {
                cell.readMorebtn.isHidden = true
                cell.readmoreButtonBottom_Constant.constant = 0
            }
            else if cell.lbl_description.text?.count ?? 0 <= 100 {
                cell.readMorebtn.isHidden = false
                cell.readmoreButtonBottom_Constant.constant = 30
            
            }else if cell.lbl_description.text?.count ?? 0 <= 150 {
                cell.readMorebtn.isHidden = false
                cell.readmoreButtonBottom_Constant.constant = 45
            
            }else if cell.lbl_description.text?.count ?? 0 <= 200 {
                cell.readMorebtn.isHidden = false
                cell.readmoreButtonBottom_Constant.constant = 60
            
            }
             else{
                cell.readMorebtn.isHidden = true
                cell.readmoreButtonBottom_Constant.constant = 0
            }
            if expandedIndexSet.contains(indexPath.row) {
                        cell.lbl_description.numberOfLines = 0
                        cell.readMorebtn.setTitle("Read Less", for: .normal)
                    } else {
                        cell.lbl_description.numberOfLines = 5
                        cell.readMorebtn.setTitle("Read More", for: .normal)
                    }
            
          let tap3 = UITapGestureRecognizer(target: self, action: #selector(linkLblClicked(_:)))
           cell.lbl_description.addGestureRecognizer(tap3)
            tap3.view?.tag = indexPath.row
            
            let tap4 = UITapGestureRecognizer(target: self, action: #selector(lastCommentLblLink(_:)))
             cell.lbl_lastCommentUserComment.addGestureRecognizer(tap4)
              tap4.view?.tag = indexPath.row
            let lastMsgPresent = DataManager.getVal(dict["last_comment"]) as? String ?? ""
            if lastMsgPresent.count <= 10 {
                cell.readMoreLblComment.isHidden = true
            }else if lastMsgPresent.count <= 20 {
                cell.readMoreLblComment.isHidden = true
            }
            else if lastMsgPresent.count <= 110 {
                cell.readMoreLblComment.isHidden = false
            }else{
                cell.readMoreLblComment.isHidden = true
            }
            
            let tapLastCommentView = UITapGestureRecognizer(target: self, action: #selector(vw_lastMsgView(_:)))
             cell.vw_lastMsg.addGestureRecognizer(tapLastCommentView)
            tapLastCommentView.view?.tag = indexPath.row
            
            if expandedIndexSetForLastComment.contains(indexPath.row) {
                        cell.lbl_lastCommentUserComment.numberOfLines = 0
                cell.readMoreLblComment.text = "Read Less"
                    } else {
                        cell.lbl_lastCommentUserComment.numberOfLines = 2
                        cell.readMoreLblComment.text = "Read More"
                    }
            
            cell.lbl_likeCount.text = DataManager.getVal(dict["minitribePostLikeCount"]) as? String ?? ""
            cell.lbl_commentCount.text = DataManager.getVal(dict["minitribePostCommentCount"]) as? String ?? ""
            let LogInusrImg = UserDefaults.standard.value(forKey: "user_image") as? String ?? ""
            Config().setimage(image_url: "\(Config().baseImageUrl)\(LogInusrImg)", image_name: cell.img_comment_user)
            
            cell.txt_comment.text = ""

           

            if lastMsgPresent == "" {
                cell.vw_lastMsg.isHidden = true
                cell.lbl_line.isHidden = true
                cell.constraint_top_vwCommentMake.constant = -90
                cell.lbl_lastCommentUsername.text = ""
                cell.lbl_lastCommentUserComment.text = ""
            }else{
                cell.vw_lastMsg.isHidden = false
                cell.lbl_line.isHidden = false
                cell.constraint_top_vwCommentMake.constant = 10

                cell.img_lastCommentUser.sd_setImage(with: URL(string: "\(Config().baseImageUrl)\(DataManager.getVal(dict["last_user_profile_image"]) as? String ?? "")"), completed: nil)
                
                print(dict)
                let id = DataManager.getVal(dict["user_id"]) as? String ?? ""
                let tap = UITapGestureRecognizer(target: self, action: #selector(ImageClicked1(_:)))
                cell.img_lastCommentUser.isUserInteractionEnabled = true
                cell.img_lastCommentUser.addGestureRecognizer(tap)
                tap.view?.tag = indexPath.row

                cell.lbl_lastCommentUsername.text = DataManager.getVal(dict["last_user_name"]) as? String ?? ""
                cell.lbl_lastCommentUserComment.text = DataManager.getVal(dict["last_comment"]) as? String ?? ""
                
            }

            cell.btn_like.tag = indexPath.row
            cell.btn_comment.tag = indexPath.row
            
            cell.btn_like.addTarget(self, action: #selector(displayLikesList(_:)), for: .touchUpInside)
            cell.btn_comment.addTarget(self, action: #selector(displayCommentsList(_:)), for: .touchUpInside)
            
            cell.btn_likeMain.tag = indexPath.row
            cell.btn_commentMain.tag = indexPath.row
            cell.btn_shareMain.tag = indexPath.row
            cell.btn_sendComment.tag = indexPath.row
            
            let isLiked = DataManager.getVal(dict["liked_status"]) as? String ?? ""
                
            if isLiked == "1"{
                cell.btn_likeMain.isSelected = true
                cell.lbl_likeMain.text = "Liked"
                cell.lbl_likeMain.textColor = UIColor.systemIndigo
               
            }else{
                cell.lbl_likeMain.text = "Like"
                cell.btn_likeMain.isSelected = false
                cell.lbl_likeMain.textColor = UIColor(red: 0.45, green: 0.44, blue: 0.44, alpha: 1.00)
            }
            
            cell.btn_likeMain.addTarget(self, action: #selector(likeClicked(_:)), for: .touchUpInside)
            cell.btn_shareMain.addTarget(self, action: #selector(shareClicked(_:)), for: .touchUpInside)
            cell.btn_sendComment.addTarget(self, action: #selector(commentClicked(_:)), for: .touchUpInside)
            
            cell.arr_imgs = DataManager.getVal(dict["images"]) as? [[String:Any]] ?? []
            cell.pgControl.numberOfPages = cell.arr_imgs.count
            
            if cell.arr_imgs.count > 0 {
                cell.StackViewHeightConstant.constant = 200
                cell.mainStackView.isHidden = false
            }else{
                cell.StackViewHeightConstant.constant = 0
                cell.mainStackView.isHidden = true
            }
            cell.stackView1.layer.cornerRadius = 8
            cell.stackView2_View1.layer.cornerRadius = 8
            cell.stackView2_View2.layer.cornerRadius = 8
            if cell.arr_imgs.count == 1 {
                cell.stackView2.isHidden = true
                let dict = cell.arr_imgs[0] as? NSDictionary ?? [:]
                let img1 = dict.value(forKey: "images") as? String ?? ""
                Config().setimage(image_url: Config().baseImageUrl + img1, image_name: cell.stackView1_ImgView)
            }else{
                if cell.arr_imgs.count == 2 {
                    cell.stackView2.isHidden = false
                    cell.stackView2_View2.isHidden = true
                    cell.stackView2_widthConstant.constant = cell.mainStackView.frame.width/2 + 16

                    let dict = cell.arr_imgs[0] as? NSDictionary ?? [:]
                    let img1 = dict.value(forKey: "images") as? String ?? ""
                    Config().setimage(image_url: Config().baseImageUrl + img1, image_name: cell.stackView1_ImgView)
                    
                    let dict1 = cell.arr_imgs[1] as? NSDictionary ?? [:]
                    let img2 = dict1.value(forKey: "images") as? String ?? ""
                    Config().setimage(image_url: Config().baseImageUrl + img2, image_name: cell.stackView2_ImgView1)
                }
                if cell.arr_imgs.count == 3 {
                    cell.stackView2_View2.isHidden = false
                    cell.stackView2.isHidden = false
                    cell.stackView2_Btn2.setTitle(" ", for: .normal)
                    cell.stackView2_widthConstant.constant = 100
                    
                    let dict = cell.arr_imgs[0] as? NSDictionary ?? [:]
                    let img1 = dict.value(forKey: "images") as? String ?? ""
                    Config().setimage(image_url: Config().baseImageUrl + img1, image_name: cell.stackView1_ImgView)
                    
                    let dict1 = cell.arr_imgs[1] as? NSDictionary ?? [:]
                    let img2 = dict1.value(forKey: "images") as? String ?? ""
                    Config().setimage(image_url: Config().baseImageUrl + img2, image_name: cell.stackView2_ImgView1)
                    
                    let dict2 = cell.arr_imgs[2] as? NSDictionary ?? [:]
                    let img3 = dict2.value(forKey: "images") as? String ?? ""
                    Config().setimage(image_url: Config().baseImageUrl + img3, image_name: cell.stackView2_ImgView2)
                }
                if cell.arr_imgs.count >= 4 {
                    cell.stackView2_View2.isHidden = false
                    cell.stackView2.isHidden = false
                    cell.stackView2_Btn2.setTitle("\(cell.arr_imgs.count - 3)+ more", for: .normal)
                    cell.stackView2_widthConstant.constant = 100
                    
                    let dict = cell.arr_imgs[0] as? NSDictionary ?? [:]
                    let img1 = dict.value(forKey: "images") as? String ?? ""
                    Config().setimage(image_url: Config().baseImageUrl + img1, image_name: cell.stackView1_ImgView)
                    
                    let dict1 = cell.arr_imgs[1] as? NSDictionary ?? [:]
                    let img2 = dict1.value(forKey: "images") as? String ?? ""
                    Config().setimage(image_url: Config().baseImageUrl + img2, image_name: cell.stackView2_ImgView1)
                    
                    let dict2 = cell.arr_imgs[2] as? NSDictionary ?? [:]
                    let img3 = dict2.value(forKey: "images") as? String ?? ""
                    Config().setimage(image_url: Config().baseImageUrl + img3, image_name: cell.stackView2_ImgView2)
                }
            }
            cell.stackView2_Btn2.layer.backgroundColor = UIColor.black.withAlphaComponent(0.4).cgColor
            cell.stackView2_Btn2.tag = indexPath.row
            cell.stackView2_Btn1.tag = indexPath.row
            cell.stackView1_Btn.tag = indexPath.row
            cell.stackView2_Btn2.addTarget(self, action: #selector(moreImageShow(_:)), for: .touchUpInside)
            cell.stackView1_Btn.addTarget(self, action: #selector(moreImageShow(_:)), for: .touchUpInside)
            cell.stackView2_Btn1.addTarget(self, action: #selector(moreImageShow(_:)), for: .touchUpInside)
            
            if DataManager.getVal(dict["user_id"]) as? String ?? "" ==  Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""{
                cell.btn_show.isHidden = false
            }else{
                cell.btn_show.isHidden = true
            }
            cell.btn_show.tag = indexPath.row
            cell.btn_show.addTarget(self, action: #selector(displayAlertOptions(_:)), for: .touchUpInside)
            
//            let tap01 = UITapGestureRecognizer(target: self, action: #selector(moreImageShow(_:)))
//            cell.mainStackView.isUserInteractionEnabled = true
//            cell.mainStackView.addGestureRecognizer(tap01)
//            tap01.view?.tag = indexPath.row
            
            cell.mainVC = self
            
            let snapCount = DataManager.getVal(dict["snaps_count"]) as? String ?? ""
            let lastUserSnapCount = DataManager.getVal(dict["last_user_snaps_count"]) as? String ?? ""
            
            cell.userImgRoundView.layer.cornerRadius = cell.userImgRoundView.frame.width/2
            cell.lastCommentImgRoundView.layer.cornerRadius = cell.lastCommentImgRoundView.frame.width/2
            if lastUserSnapCount == "0" {
                cell.lastCommentGradient1.removeFromSuperlayer()
            cell.lastCommentImgRoundView.layer.backgroundColor = UIColor.white.cgColor
            }else{
                cell.lastCommentGradient1.cornerRadius = cell.lastCommentImgRoundView.layer.cornerRadius
                cell.lastCommentGradient1.frame = cell.lastCommentImgRoundView.frame
                cell.lastCommentGradient1.colors = [UIColor(red: 0.42, green: 0.39, blue: 1.00, alpha: 1.00).cgColor,UIColor(red: 0.05, green: 0.23, blue: 0.66, alpha: 1.00).cgColor,UIColor(red: 0.10, green: 0.55, blue: 0.65, alpha: 1.00).cgColor,UIColor(red: 0.14, green: 0.90, blue: 0.71, alpha: 1.00).cgColor]
                cell.lastCommentImgRoundView.layer.insertSublayer(cell.lastCommentGradient1, at: 0)
                cell.lastCommentGradient1.startPoint = CGPoint(x: 0.0, y: 1.0)
                cell.lastCommentGradient1.endPoint = CGPoint(x: 1.0, y: 1.0)
                cell.lastCommentGradient1.frame = CGRect(x: 0.0, y: 0.0, width: cell.lastCommentImgRoundView.frame.size.width, height: cell.lastCommentImgRoundView.frame.size.height)
            }
             
            if snapCount == "0" {
                cell.gradient1.removeFromSuperlayer()
            cell.userImgRoundView.layer.backgroundColor = UIColor.white.cgColor
            }else{
                cell.gradient1.cornerRadius = cell.userImgRoundView.layer.cornerRadius
                cell.gradient1.frame = cell.userImgRoundView.frame
                cell.gradient1.colors = [UIColor(red: 0.42, green: 0.39, blue: 1.00, alpha: 1.00).cgColor,UIColor(red: 0.05, green: 0.23, blue: 0.66, alpha: 1.00).cgColor,UIColor(red: 0.10, green: 0.55, blue: 0.65, alpha: 1.00).cgColor,UIColor(red: 0.14, green: 0.90, blue: 0.71, alpha: 1.00).cgColor]
                cell.userImgRoundView.layer.insertSublayer(cell.gradient1, at: 0)
                cell.gradient1.startPoint = CGPoint(x: 0.0, y: 1.0)
                cell.gradient1.endPoint = CGPoint(x: 1.0, y: 1.0)
                cell.gradient1.frame = CGRect(x: 0.0, y: 0.0, width: cell.userImgRoundView.frame.size.width, height: cell.userImgRoundView.frame.size.height)
            }
            cell.contentView.layoutSubviews()
            return cell
        }
    }
    
    func RightSwipeAdsAPI(ads_id: Int, type: String){
         self.view.endEditing(true)

         let parameterDictionary = NSMutableDictionary()
        let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
        parameterDictionary.setValue("tribe123", forKey: "api_key")
        parameterDictionary.setValue(userID, forKey: "user_id")
        parameterDictionary.setValue(ads_id, forKey: "ads_id")
        parameterDictionary.setValue(type, forKey: "type")
        print(parameterDictionary)
         let methodName = "ads_view"

         DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
             let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
             let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
             if status == "1" {
                 let url = URL(string: self.adsrighturl)
                 if UIApplication.shared.canOpenURL(url!) {
                     if #available(iOS 10.0, *) {
                          UIApplication.shared.open(url!, options: [:], completionHandler: { (success) in

                          })
                     } else {
                         UIApplication.shared.openURL(url!)
                     }
                 }
             }
             else {
             }
         }
     }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dict = self.arr_postData[indexPath.row]
        let ads_status = DataManager.getVal(dict["ads_status"]) as? String ?? "0"
        if ads_status == "1" {
            let adsid = DataManager.getVal(dict["id"]) as? String ?? ""
            let strid = Int(adsid) ?? 0
            self.RightSwipeAdsAPI(ads_id: strid, type: "like")
            let linkUrl = DataManager.getVal(dict["link"]) as? String ?? ""
            self.adsrighturl = linkUrl
        }else{
            let cellType = DataManager.getVal(dict["type"]) as? String ?? ""
            
            if cellType == "meetup" {
                selecteIndexpathForReferesh = IndexPath(row: indexPath.row, section: 0)
                let vc = self.storyboard?.instantiateViewController(identifier: "MeetUpDetailVC") as! MeetUpDetailVC
                vc.meetupId = DataManager.getVal(dict["id"]) as? String ?? ""
                
                vc.miniTribeId = DataManager.getVal(dict["mini_tribe_id"]) as? String ?? ""
                navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        
    }

    @objc func displayAlertOptions(_ sender : UIButton){
        selecteIndexpathForReferesh = IndexPath(row: sender.tag, section: 0)
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        actionSheet.modalPresentationStyle = .popover
        actionSheet.addAction(UIAlertAction(title: "Edit Post", style: .default, handler: {(action:UIAlertAction) in
            
            let dict = self.arr_postData[sender.tag]
            
            let vc = self.storyboard?.instantiateViewController(identifier: "CreatePostVC") as! CreatePostVC
            vc.comesFrom = "Edit"
            vc.user_Img = DataManager.getVal(dict["user_image"]) as? String ?? ""
            vc.userName = DataManager.getVal(dict["user_name"]) as? String ?? ""
            vc.miniTribeId = DataManager.getVal(dict["mini_tribe_id"]) as? String ?? ""
            vc.perspective = DataManager.getVal(dict["perspective"]) as? String ?? ""
            vc.arr_editAsset = DataManager.getVal(dict["images"]) as? [[String:Any]] ?? []
            vc.miniTribePostId = DataManager.getVal(dict["id"]) as? String ?? ""
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Delete Post", style: .destructive, handler: {(action:UIAlertAction) in
            
            self.DeletePostViewPopUp.frame = self.view.frame
            self.DeletePostViewPopUp.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            self.view.addSubview(self.DeletePostViewPopUp)
            
            let dict = self.arr_postData[sender.tag]
            self.deletePostId = DataManager.getVal(dict["id"]) as? String ?? ""
            
        }))
      
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @objc func ImageClicked1(_ sender : UITapGestureRecognizer) {
        
        let dict = filteredData[sender.view?.tag ?? -1]
        let id = DataManager.getVal(dict["last_user_id"]) as? String ?? ""
        let snapCount = DataManager.getVal(dict["last_user_snaps_count"]) as? String ?? ""
        
        let actionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
                    
                }
                actionSheetController.addAction(cancelAction)
            let nearto = UIAlertAction(title: "View profile", style: .default) { action -> Void in
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileController") as! ProfileController
                vc.swipeUserID = Int(id) ?? 0
                vc.isComingFromMiniTribe = true
                print(USER_VIBE)
                vc.vibeType = USER_VIBE
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
        
//
//               let vc = self.storyboard?.instantiateViewController(withIdentifier: "ExpandedImageViewController") as! ExpandedImageViewController
//               vc.urlStr = (DataManager.getVal(dict["last_user_profile_image"]) as? String ?? "")
//               self.navigationController?.pushViewController(vc, animated: true)
        
           }
    @objc func adsViewIMgClick(_ sender : UITapGestureRecognizer) {
        
        let dict = filteredData[sender.view?.tag ?? -1]
        let link = DataManager.getVal(dict["link"]) as? String ?? ""
        
    }
    @objc func ImageClicked(_ sender : UITapGestureRecognizer) {
        
        let dict = filteredData[sender.view?.tag ?? -1]
        let id = DataManager.getVal(dict["user_id"]) as? String ?? ""
        let snapCount = DataManager.getVal(dict["snaps_count"]) as? String ?? ""
        
        let actionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
                    
                }
                actionSheetController.addAction(cancelAction)
            let nearto = UIAlertAction(title: "View profile", style: .default) { action -> Void in
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileController") as! ProfileController
                vc.swipeUserID = Int(id) ?? 0
                print(SELECT_VIBE)
                vc.vibeHide = "1"
                vc.isComingFromMiniTribe = true
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
        
//               let vc = self.storyboard?.instantiateViewController(withIdentifier: "ExpandedImageViewController") as! ExpandedImageViewController
//               vc.urlStr = DataManager.getVal(dict["user_image"]) as? String ?? ""
//        vc.shouldPrefix = true
//               self.navigationController?.pushViewController(vc, animated: true)
           }

    
    @objc func likeClicked(_ sender: UIButton){
        ccc = "1"
        let dict = filteredData[sender.tag]
        selecteIndexpathForReferesh = IndexPath(row: sender.tag, section: 0)
        let paraDict = NSMutableDictionary()
        paraDict.setValue(Config().api_key, forKey: "api_key")
        paraDict.setValue(DataManager.getVal(dict["id"]) as? String ?? "", forKey: "mini_tribe_post_id")
       paraDict.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")

      //  paraDict.setValue("25", forKey: "user_id")

        print(paraDict)
            
        let methodName = "create_mini_tribe_like"
        DataManager.getAPIResponse(paraDict , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
            print(message)
            if status == "1" {
                self.api_call()
            }
            else {
                self.view.makeToast(message)
            }
        }
    }
    
    @objc func commentClicked(_ sender: UIButton){
        self.view.endEditing(true)
        let dict = filteredData[sender.tag]
        let cell = tableview.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! Tribefulltblcell
      
        let paraDict = NSMutableDictionary()
        paraDict.setValue(Config().api_key, forKey: "api_key")
        paraDict.setValue(cell.txt_comment.text ?? "", forKey: "comment")
        paraDict.setValue(DataManager.getVal(dict["id"]) as? String ?? "", forKey: "mini_tribe_post_id")
       paraDict.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")

      //  paraDict.setValue("25", forKey: "user_id")

        print(paraDict)
            
        let methodName = "create_mini_tribe_comment"
        DataManager.getAPIResponse(paraDict , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
            print(message)
            if status == "1" {
                cell.txt_comment.text = ""
                self.api_callNew(tag: sender.tag)
            }
            else {
                self.view.makeToast(message)
            }
        }
    }
    
    @objc func commentClicked1(_ sender: UIButton){
        self.view.endEditing(true)
        basicFunctions.presentLoader()
        let dict = filteredData[sender.tag]
        let cell = tableview.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! Tribefulltblcell2
      
        let paraDict = NSMutableDictionary()
        paraDict.setValue(Config().api_key, forKey: "api_key")
        paraDict.setValue(cell.writeCommentTextField.text ?? "", forKey: "comment")
        paraDict.setValue(DataManager.getVal(dict["id"]) as? String ?? "", forKey: "mini_tribe_post_id")
       paraDict.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")

      //  paraDict.setValue("25", forKey: "user_id")

        print(paraDict)
            
        let methodName = "create_mini_tribe_comment"
        DataManager.getAPIResponse(paraDict , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
            print(message)
            if status == "1" {
                cell.writeCommentTextField.text = ""
                self.api_callNew(tag: sender.tag)
            }
            else {
                self.view.makeToast(message)
            }
        }
        basicFunctions.stopLoading()
    }
    
    func deletePostApi(id: String){
        basicFunctions.presentLoader()
        let paraDict = NSMutableDictionary()
        paraDict.setValue(Config().api_key, forKey: "api_key")
        paraDict.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
        paraDict.setValue(id, forKey: "mini_tribe_post_id")
        print(paraDict)
        
        let methodName = "delete_mini_tribe_post"
        DataManager.getAPIResponse(paraDict , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
            print(message)
            if status == "1" {
                self.txt_search.text = ""
                self.api_call()
            }
            else {
                print(message)
            }
        }
        basicFunctions.stopLoading()
    }
    
    @objc func shareClicked(_ sender: UIButton){
        
    }
    
    @objc func displayLikesList(_ sender : UIButton){
        
        let dict = arr_postData[sender.tag]
        let vc = self.storyboard?.instantiateViewController(identifier: "LikesListViewController") as! LikesListViewController
        vc.postId = DataManager.getVal(dict["id"]) as? String ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func displayCommentsList(_ sender : UIButton){
        let dict = arr_postData[sender.tag]
        let vc = self.storyboard?.instantiateViewController(identifier: "CommentsListViewController") as! CommentsListViewController
        vc.postId = DataManager.getVal(dict["id"]) as? String ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
class DataDetector {

    private class func _find(all type: NSTextCheckingResult.CheckingType,
                             in string: String, iterationClosure: (String) -> Bool) {
        guard let detector = try? NSDataDetector(types: type.rawValue) else { return }
        let range = NSRange(string.startIndex ..< string.endIndex, in: string)
        let matches = detector.matches(in: string, options: [], range: range)
        loop: for match in matches {
            for i in 0 ..< match.numberOfRanges {
                let nsrange = match.range(at: i)
                let startIndex = string.index(string.startIndex, offsetBy: nsrange.lowerBound)
                let endIndex = string.index(string.startIndex, offsetBy: nsrange.upperBound)
                let range = startIndex..<endIndex
                guard iterationClosure(String(string[range])) else { break loop }
            }
        }
    }

    class func find(all type: NSTextCheckingResult.CheckingType, in string: String) -> [String] {
        var results = [String]()
        _find(all: type, in: string) {
            results.append($0)
            return true
        }
        return results
    }

    class func first(type: NSTextCheckingResult.CheckingType, in string: String) -> String? {
        var result: String?
        _find(all: type, in: string) {
            result = $0
            return false
        }
        return result
    }
}

// MARK: String extension

extension String {
    var detectedLinks: [String] { DataDetector.find(all: .link, in: self) }
    var detectedFirstLink: String? { DataDetector.first(type: .link, in: self) }
    var detectedURLs: [URL] { detectedLinks.compactMap { URL(string: $0) } }
    var detectedFirstURL: URL? {
        guard let urlString = detectedFirstLink else { return nil }
        return URL(string: urlString)
    }
}
//extension NSMutableAttributedString {
//
//    public func setAsLink(textToFind:String, linkURL:String) -> Bool {
//
//        let foundRange = self.mutableString.range(of: textToFind)
//        if foundRange.location != NSNotFound {
//            self.addAttribute(.link, value: linkURL, range: foundRange)
//            return true
//        }
//        return false
//    }
//}
extension NSMutableAttributedString{
    func setColorForText(_ textToFind: String, with color: UIColor) {
        let range = self.mutableString.range(of: textToFind, options: .caseInsensitive)
        if range.location != NSNotFound {
            addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }
    }
}
//extension String {
//
//    var emojilessStringWithSubstitution: String {
//        let emojiPatterns = [UnicodeScalar(0x1F601)...UnicodeScalar(0x1F64F),
//                             UnicodeScalar(0x2702)...UnicodeScalar(0x27B0)]
//        return self.unicodeScalars
//            .filter { ucScalar in !(emojiPatterns.contains{ $0 ~= ucScalar }) }
//            .reduce("") { $0 + String($1) }
//    }
//}
