//
//  MeetUpDetailVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 29/06/21.
//

import UIKit
import GoogleMaps
import OnlyPictures
import MapKit

class MeetUpDetailVC: UIViewController {
    //MARK:- IBOutlet
    
    @IBAction func btn_goingAction(_ sender: UIButton) {
        api_updateStatus(id: "1")
        btngoing.backgroundColor = UIColor(red: 0.05, green: 0.23, blue: 0.66, alpha: 0.2)
        btnmightgo.backgroundColor = UIColor.white
        btnnotgoing.backgroundColor = UIColor.white
    }
    
    @IBAction func btn_mightGoAction(_ sender: UIButton) {
        api_updateStatus(id: "3")
        btngoing.backgroundColor = UIColor.white
        btnmightgo.backgroundColor = UIColor(red: 0.05, green: 0.23, blue: 0.66, alpha: 0.2)
        btnnotgoing.backgroundColor = UIColor.white
    }
    @IBAction func btn_notGoingAction(_ sender: UIButton) {
        api_updateStatus(id: "2")
        btngoing.backgroundColor = UIColor.white
        btnmightgo.backgroundColor = UIColor.white
        btnnotgoing.backgroundColor = UIColor(red: 0.05, green: 0.23, blue: 0.66, alpha: 0.2)
    }
    
//    @IBOutlet weak var showCommentViewHeightConstraint: NSLayoutConstraint! // 100
//    @IBOutlet weak var writeCommentViewTopConstraint: NSLayoutConstraint!
//    @IBOutlet weak var showCommentView: UIView!
//    @IBOutlet weak var writeCommentView: UIView!
//    @IBOutlet weak var showCommentImg: UIImageView!
//    @IBOutlet weak var showCommentNameLbl: UILabel!
//    @IBOutlet weak var showCommentMessageLbl: UILabel!
//    @IBOutlet weak var writeCommentImg: UIImageView!
//    @IBOutlet weak var writeCommentTextFld: UITextField!
//    @IBOutlet weak var sendCommentBtn: UIButton!
    
    @IBOutlet weak var vw_map: GMSMapView!
    @IBOutlet weak var onlyImages3: OnlyHorizontalPictures!
    @IBOutlet weak var onlyImgaes1: OnlyHorizontalPictures!
    @IBOutlet weak var onlyImages2: OnlyHorizontalPictures!
    
    var meetupId = ""
    var miniTribeId = ""
    
    var arr_Going = [[String:Any]]()
    var arr_NotGoing = [[String:Any]]()
    var arr_MightGo = [[String:Any]]()
    
    @IBOutlet weak var picturesCollectionViewGoing: UICollectionView!
    @IBOutlet weak var picturesCollectionViewNotGoing: UICollectionView!
    @IBOutlet weak var picturesCollectionViewMightGoing: UICollectionView!
    
    @IBOutlet weak var picturesCollectionViewGoingWidthConstranit: NSLayoutConstraint!
    @IBOutlet weak var picturesCollectionViewNotGoingWidthConstranit: NSLayoutConstraint!
    @IBOutlet weak var picturesCollectionViewMightGoingWidthConstranit: NSLayoutConstraint!
    
    @IBOutlet weak var img_userNew: UIImageView!
    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var imguser: UIImageView!
    @IBOutlet weak var lblmeditation: UILabel!
    @IBOutlet weak var btnpublic: UIButton!
    @IBOutlet weak var lblcreated: UILabel!
    @IBOutlet weak var lbldate: UILabel!
    @IBOutlet weak var lbltime: UILabel!
    @IBOutlet weak var lbllocation: UILabel!
    @IBOutlet weak var lbldiscription: UILabel!
    @IBOutlet weak var btnraedmore: UIButton!
    @IBOutlet weak var btngoing: UIButton!
    @IBOutlet weak var btnmightgo: UIButton!
    @IBOutlet weak var btnnotgoing: UIButton!
    @IBOutlet weak var lblGoing: UILabel!
    @IBOutlet weak var lblNotGoing: UILabel!
    @IBOutlet weak var lblMightGo: UILabel!
    @IBOutlet weak var createdByname: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    //MARK:- Variables
    var ApiDict = NSMutableDictionary()
    //MARK:- viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        getdata()
        
//        showCommentViewHeightConstraint.constant = 0
//        showCommentView.isHidden = true
//        showCommentView.layer.cornerRadius = 8
        
        picturesCollectionViewGoing.register(UINib(nibName: "CustomOnlyPicturesCell", bundle: nil), forCellWithReuseIdentifier: "CustomOnlyPicturesCell")
        picturesCollectionViewNotGoing.register(UINib(nibName: "CustomOnlyPicturesCell", bundle: nil), forCellWithReuseIdentifier: "CustomOnlyPicturesCell")
        picturesCollectionViewMightGoing.register(UINib(nibName: "CustomOnlyPicturesCell", bundle: nil), forCellWithReuseIdentifier: "CustomOnlyPicturesCell")
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(linkLblClicked1(_:)))
        lbldiscription.addGestureRecognizer(tap3)
//        self.onlyImgaes1.dataSource = self
//        self.onlyImages2.dataSource = self
//        self.onlyImages3.dataSource = self

//        self.onlyImgaes1.alignment = .left
//        self.onlyImages2.alignment = .left
//        self.onlyImages3.alignment = .left
        
//        self.img_userNew.layer.cornerRadius = self.img_userNew.frame.size.width/2
        

        btnmightgo.layer.cornerRadius = 6
        btnmightgo.layer.borderWidth = 0.7
        btnmightgo.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        btnmightgo.backgroundColor = UIColor.white

        btnnotgoing.layer.cornerRadius = 6
        btnnotgoing.layer.borderWidth = 0.7
        btnnotgoing.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        btnnotgoing.backgroundColor = UIColor.white
        
        btngoing.layer.cornerRadius = 6
        btngoing.layer.borderWidth = 0.7
        btngoing.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        btngoing.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }
    
    @objc func linkLblClicked1(_ sender : UITapGestureRecognizer) {
       
        let str = lbldiscription.text?.detectedLinks
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
    //MARK:- backBtnAction

    @IBAction func backBtnAction(_ sender: Any) {
        backTwo()
       // navigationController?.popViewController(animated: true)

    }
    func backTwo() {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
    }
    @IBAction func OpenMapApplication(_ sender: Any) {
        let lat = DataManager.getVal(self.ApiDict["meetup_latitude"]) as? String ?? ""
        let lon = DataManager.getVal(self.ApiDict["meetup_longitude"]) as? String ?? ""
        let add = DataManager.getVal(self.ApiDict["meetup_location"]) as? String ?? ""
        
        let latitude: CLLocationDegrees = Double(lat)!
        let longitude: CLLocationDegrees = Double(lon)!
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = add
        mapItem.openInMaps(launchOptions: options)
    }
//    @IBAction func sendMessageCommentBtnAction(_ sender: Any) {
//        showCommentViewHeightConstraint.constant = 60
//        showCommentView.isHidden = false
//    }
    //MARK:- ApiManager

    func api_updateStatus(id:String){
        
        basicFunctions.presentLoader()
        self.view.endEditing(true)
        
        let paraDict = NSMutableDictionary()
        paraDict.setValue(Config().api_key, forKey: "api_key")
        paraDict.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
        paraDict.setValue(self.miniTribeId , forKey: "mini_tribe_id")
        paraDict.setValue(self.meetupId , forKey: "mini_tribe_meetup_id")
        paraDict.setValue(id, forKey: "status")
        paraDict.setValue("meetup", forKey: "type")
 
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
    
    func getdata(){
        let timeZone = TimeZone.current.identifier
                
        
        let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
        let paraDict = NSMutableDictionary()
        paraDict.setValue(Config().api_key, forKey: "api_key")
        paraDict.setValue(timeZone, forKey: "timezone")
        paraDict.setValue(userID, forKey: "user_id")
        paraDict.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
        paraDict.setValue(miniTribeId, forKey: "mini_tribe_id")
        paraDict.setValue(meetupId, forKey: "mini_tribe_meetup_id")
        
        print (paraDict)

        let methodName = "get_detail_mini_tribe_meetup"
        DataManager.getAPIResponse(paraDict , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
             let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
             let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
                print(message)
             if status == "1" {
                print(DataManager.getVal(responseData?["data"]) as? [String:Any] ?? [:])
                self.ApiDict = DataManager.getVal(responseData?["data"]) as? NSMutableDictionary ?? [:]
                
                self.img_userNew.sd_setImage(with: URL(string: "\(Config().baseImageUrl)\(DataManager.getVal(self.ApiDict["meetup_image"]) as? String ?? "")"), completed: nil)
                
                 let tap = UITapGestureRecognizer(target: self, action: #selector(self.ImageClicked(_:)))
                 self.img_userNew.isUserInteractionEnabled = true
                 self.img_userNew.addGestureRecognizer(tap)
                 
                let visibility = DataManager.getVal(self.ApiDict["meetup_visibility"]) as? String ?? ""
                    
                if visibility == "2"{
                    self.btnpublic.setTitle("Public", for: .normal)
                }else{
                    self.btnpublic.setTitle("Private", for: .normal)
                }
                
                let lat = DataManager.getVal(self.ApiDict["meetup_latitude"]) as? String ?? ""
                let lon = DataManager.getVal(self.ApiDict["meetup_longitude"]) as? String ?? ""
                
                self.vw_map.camera = GMSCameraPosition(latitude: CLLocationDegrees(lat) ?? 0.0, longitude: CLLocationDegrees(lon) ?? 0.0, zoom: 15.0)
                let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: CLLocationDegrees(lat) ?? 0.0, longitude: CLLocationDegrees(lon) ?? 0.0))
                marker.map = self.vw_map
                
                
                self.lbldate.text = self.ApiDict["meetup_date"] as? String ?? ""
                self.lbltime.text = "\(self.ApiDict["meetup_time"] as? String ?? "")" + " \(self.ApiDict["meetup_period"] as? String ?? "")"
                self.lbllocation.text = self.ApiDict["meetup_location"] as? String ?? ""
                self.lbldiscription.text = self.ApiDict["meetup_description"] as? String ?? ""
                self.createdByname.text = "\(self.ApiDict["name"] as? String ?? "")"
                self.lblGoing.text = "\(self.ApiDict["meetup_going_members"] as? Int ?? 0) People Are Going"
                self.lblNotGoing.text = "\(self.ApiDict["meetup_not_going_members"] as? Int ?? 0) People Are Not Going"
                self.lblMightGo.text = "\(self.ApiDict["meetup_might_go_members"] as? Int ?? 0) People Might Go"
                 self.titleLbl.text = self.ApiDict["meetup_topic"] as? String ?? ""
                self.arr_Going = DataManager.getVal(self.ApiDict["meetup_going_members_list"]) as? [[String:Any]] ?? []
                self.arr_MightGo = DataManager.getVal(self.ApiDict["meetup_might_go_list"]) as? [[String:Any]] ?? []
                self.arr_NotGoing = DataManager.getVal(self.ApiDict["meetup_not_going_members_list"]) as? [[String:Any]] ?? []
                
                 if self.arr_Going.count == 1 {
                     self.lblGoing.text = "1 person is Going"
                 }else{
                     self.lblGoing.text = "\(self.ApiDict["meetup_going_members"] as? Int ?? 0) People Are Going"
                 }
                 if self.arr_NotGoing.count == 1 {
                     self.lblNotGoing.text = "1 person is not Going"
                 }else{
                     self.lblNotGoing.text = "\(self.ApiDict["meetup_not_going_members"] as? Int ?? 0) People Are not Going"
                 }
                 if self.arr_MightGo.count == 1 {
                     self.lblMightGo.text = "1 person might Go"
                 }else{
                     self.lblMightGo.text = "\(self.ApiDict["meetup_might_go_members"] as? Int ?? 0) People might Go"
                 }
                 
                let meetupStatus = DataManager.getVal(self.ApiDict["meetup_status"]) as? String ?? ""
                
                if meetupStatus == "1"{
                    self.btngoing.backgroundColor = UIColor(red: 0.05, green: 0.23, blue: 0.66, alpha: 0.2)
                    self.btnmightgo.backgroundColor = UIColor.white
                    self.btnnotgoing.backgroundColor = UIColor.white
                }else if meetupStatus == "2"{
                    self.btngoing.backgroundColor = UIColor.white
                    self.btnmightgo.backgroundColor = UIColor.white
                    self.btnnotgoing.backgroundColor = UIColor(red: 0.05, green: 0.23, blue: 0.66, alpha: 0.2)
                }else if meetupStatus == "3"{
                    self.btngoing.backgroundColor = UIColor.white
                    self.btnmightgo.backgroundColor = UIColor(red: 0.05, green: 0.23, blue: 0.66, alpha: 0.2)
                    self.btnnotgoing.backgroundColor = UIColor.white
                }else{
                    self.btngoing.backgroundColor = UIColor.white
                    self.btnmightgo.backgroundColor = UIColor.white
                    self.btnnotgoing.backgroundColor = UIColor.white
                }
                
//                if self.arr_Going.count > 0 {
//                    self.constraint_width_onlyImages1.constant = 100
//                }else{
//                    self.constraint_width_onlyImages1.constant = 0
//                }
//
//                if self.arr_NotGoing.count > 0 {
//                    self.constraint_width_onlyImages2.constant = 100
//                }else{
//                    self.constraint_width_onlyImages2.constant = 0
//                }
//
//                if self.arr_MightGo.count > 0 {
//                    self.constraint_width_onlyImages3.constant = 100
//                }else{
//                    self.constraint_width_onlyImages3.constant = 0
//                }
//
//                self.onlyImages3.reloadData()
//                self.onlyImgaes1.reloadData()
//                self.onlyImages2.reloadData()
                 let temp = self.lbldiscription.text?.detectedURLs
                 if temp?.count ?? 0 > 0 {
                     let str = self.lbldiscription.text?.detectedLinks[0]
                     let string_to_color = str
                     let range = (self.lbldiscription.text as? NSString ?? "").range(of: string_to_color ?? "")
                     let attribute = NSMutableAttributedString.init(string: self.lbldiscription.text ?? "")
                     attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.link , range: range)
                     self.lbldiscription.attributedText = attribute
                 
                 }
                 if self.arr_Going.count > 4 {
                     self.picturesCollectionViewGoingWidthConstranit.constant = CGFloat(30 * 4)
                 }else{
                     self.picturesCollectionViewGoingWidthConstranit.constant = CGFloat(30 * self.arr_Going.count)
                 }
                 if self.arr_NotGoing.count > 4 {
                     self.picturesCollectionViewNotGoingWidthConstranit.constant = CGFloat(30 * 4)
                 }else{
                     self.picturesCollectionViewNotGoingWidthConstranit.constant = CGFloat(30 * self.arr_NotGoing.count)
                 }
                 if self.arr_MightGo.count > 4 {
                     self.picturesCollectionViewMightGoingWidthConstranit.constant = CGFloat(30 * 4)
                 }else{
                     self.picturesCollectionViewMightGoingWidthConstranit.constant = CGFloat(30 * self.arr_MightGo.count)
                 }
                 self.picturesCollectionViewGoing.reloadData()
                 self.picturesCollectionViewNotGoing.reloadData()
                 self.picturesCollectionViewMightGoing.reloadData()
             }
             else {
                print(message)
             }
    }
}

    
    @objc func ImageClicked(_ sender : UIImageView) {
                       
               let vc = self.storyboard?.instantiateViewController(withIdentifier: "ExpandedImageViewController") as! ExpandedImageViewController
        vc.shouldPrefix = true
               vc.urlStr = DataManager.getVal(self.ApiDict["meetup_image"]) as? String ?? ""
                
               self.navigationController?.pushViewController(vc, animated: true)
           }
    
}
//
//
//
//extension MeetUpDetailVC: OnlyPicturesDataSource {
//
//    // ---------------------------------------------------
//    // returns the total no of pictures
//
//    func numberOfPictures() -> Int {
//        return arr_Going.count
//    }
//
//    // ---------------------------------------------------
//    // returns the no of pictures should be visible in screen.
//    // In above preview, Left & Right formats are example of visible pictures, if you want pictures to be shown without count, remove this function, it's optional.
//
//    func visiblePictures() -> Int {
//        return 4
//    }
//
//
//    // ---------------------------------------------------
//    // return the images you want to show. If you have URL's for images, use next function instead of this.
//    // use .defaultPicture property to set placeholder image. This only work with local images. for URL's images we provided imageView instance, it's your responsibility to assign placeholder image in it. Check next function.
//    // onlyPictures.defaultPicture = #imageLiteral(resourceName: "defaultProfilePicture")
//
////    func pictureViews(index: Int) -> UIImage {
////
////        return pictures[index]
////    }
//
//
//    // ---------------------------------------------------
//    // If you do have URLs of images. Use below function to have UIImageView instance and index insted of 'pictureViews(index: Int) -> UIImage'
//    // NOTE: It's your resposibility to assign any placeholder image till download & assignment completes.
//    // I've used AlamofireImage here for image async downloading, assigning & caching, Use any library to allocate your image from url to imageView.
//
//    func pictureViews(_ imageView: UIImageView, index: Int) {
//
//        let dict = arr_Going[index]
//        let urlStr = "\(Config().baseImageUrl)\(DataManager.getVal(dict["profile_image"]) as? String ?? "")"
//
//        imageView.image = #imageLiteral(resourceName: "Ellipse 36")   // placeholder image
//        imageView.sd_setImage(with: URL(string: urlStr), completed: nil)
//
//    }
//}
extension MeetUpDetailVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
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
