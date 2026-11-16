//
//  IntentionListVC.swift
//  Soul Tribe
//
//  Created by mac-14 on 29/11/21.
//

import UIKit

class yearly_intentionCell: UITableViewCell{
    
    @IBOutlet weak var intentioTitle: UILabel!
    @IBOutlet weak var intentionSubtitle: UILabel!
    @IBOutlet weak var subtitleView: RectangularDashedView!
}
class popUpCollecionButton_cell: UICollectionViewCell{
    
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var butn: UIButton!
}
class monthly_intentionCell: UITableViewCell{
    
    @IBOutlet weak var intentioTitle: UILabel!
    @IBOutlet weak var intentionSubtitle: UILabel!
    @IBOutlet weak var subtitleView: RectangularDashedView!
}
class IntentionListVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var optionView1: UIView!
    @IBOutlet weak var optionView1CornerRadius: UIView!
    @IBOutlet weak var noDataView: UIView!
    
    @IBOutlet weak var overAll_Title: UILabel!
    @IBOutlet weak var overAll_Subtitle: UILabel!
    @IBOutlet weak var yearly_Title: UILabel!
    @IBOutlet weak var monthly_Title: UILabel!
    @IBOutlet weak var overAll_subtitleView: RectangularDashedView!
    @IBOutlet weak var monthlyTable: UITableView!
    @IBOutlet weak var yearlyTable: UITableView!
    @IBOutlet weak var yearlyTableHeight_Constraint: NSLayoutConstraint!
    @IBOutlet weak var monthlyTableHeight_Constraint: NSLayoutConstraint!
    @IBOutlet weak var overAllViewHeight_Constraint: NSLayoutConstraint!
    @IBOutlet weak var YearlyLblTop_Constraint: NSLayoutConstraint!
    @IBOutlet weak var YearlyHeight_Constraint: NSLayoutConstraint!
    @IBOutlet weak var monthlyHeight_Constraint: NSLayoutConstraint!
    @IBOutlet weak var saperateLbl: UILabel!
   
    
    @IBOutlet weak var intentionCollectionView: UICollectionView!
    var intentionsList = NSDictionary()
    var monthlyIntentionList = NSArray()
    var yearlyIntentionList = NSArray()
    var overAll_list = NSArray()
    var collectionCount = Int()
    var arrayOfStringCollection = [String]()
    var comeFromIntentions = String() //handel self back to action
    var yearlyHeight = CGFloat()
    var monthylyHeight = CGFloat()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionCount = 0
        intentionCollectionView.delegate = self
        intentionCollectionView.dataSource = self
        optionView1CornerRadius.layer.cornerRadius = 8
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
     //   self.yearlyTableHeight_Constraint.constant = self.yearlyTable.contentSize.height
       // self.monthlyTableHeight_Constraint.constant = self.monthlyTable.contentSize.height
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getintentionsList()
    }
    
    func getintentionsList() {
        basicFunctions.presentLoader()
        let parameterDictionary = NSMutableDictionary()
     let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
       parameterDictionary.setValue("tribe123", forKey: "api_key")
        parameterDictionary.setValue(userID, forKey: "user_id")
       print(parameterDictionary)
        let methodName = "get_user_intentions_list"

        DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""

            if status == "1" {
                self.intentionsList = DataManager.getVal(responseData?["data"]) as? NSDictionary ?? [:]
                self.yearlyIntentionList = self.intentionsList.value(forKey: "yearly") as? NSArray ?? []
                self.monthlyIntentionList = self.intentionsList.value(forKey: "monthly") as? NSArray ?? []
                self.overAll_list = self.intentionsList.value(forKey: "overall_application") as? NSArray ?? []
                var dict = NSDictionary()
                
                
                if self.yearlyIntentionList.count == 0 && self.monthlyIntentionList.count == 0 && self.overAll_list.count == 0 {
//                    self.noDataView.isHidden = false
//                    let lbl = UILabel()
//                    lbl.text = "No List found"
//                    lbl.frame = CGRect(x: UIScreen.main.bounds.width/2-50, y: UIScreen.main.bounds.height/2 - 60, width: UIScreen.main.bounds.width/2, height: 20)
//                    self.noDataView.addSubview(lbl)
                }else{
//                    self.noDataView.isHidden = true
                    if self.overAll_list.count > 0 {
                        dict = self.overAll_list.object(at: 0) as? NSDictionary ?? [:]
                        self.YearlyLblTop_Constraint.constant = 10
                        self.overAll_subtitleView.isHidden = false
                    }else{
                        self.YearlyLblTop_Constraint.constant = -90
                        self.overAll_Title.isHidden = true
                        self.overAll_subtitleView.isHidden = true
                    }
                    if self.yearlyIntentionList.count == 0 {
                        self.yearlyTableHeight_Constraint.constant = 0
                        self.YearlyHeight_Constraint.constant = 0
                    }else{
                        //self.YearlyHeight_Constraint.constant = 26
                        self.yearlyTableHeight_Constraint.constant = CGFloat(300 * self.yearlyIntentionList.count)
                    }
                    if self.monthlyIntentionList.count == 0 {
                        self.monthlyTableHeight_Constraint.constant = 0
                        self.monthlyHeight_Constraint.constant = 0
                        
                    }else{
                       
                        //self.monthlyHeight_Constraint.constant = 26
                        self.monthlyTableHeight_Constraint.constant = CGFloat(300 * self.monthlyIntentionList.count)
                    }
                    if self.monthlyIntentionList.count == 0{
                        self.saperateLbl.isHidden = true
                    }else{
                        self.saperateLbl.isHidden = false
                    }
                    if self.monthlyIntentionList.count == 0 && self.yearlyIntentionList.count > 0{
                        self.overAll_subtitleView.isHidden = true
                    }else{
                        self.overAll_subtitleView.isHidden = false
                    }
                    if self.monthlyIntentionList.count > 0 && self.yearlyIntentionList.count == 0{
                        self.overAll_subtitleView.isHidden = true
                    }else{
                        self.overAll_subtitleView.isHidden = false
                    }
                }
                self.overAll_Subtitle.text = dict.value(forKey: "answere") as? String
                self.monthlyTable.reloadData()
                self.yearlyTable.reloadData()
                let overAll_Status = self.intentionsList.value(forKey: "overall_application_status") as? Int
                let yearly_Status = self.intentionsList.value(forKey: "yearly_status") as? Int
                let monthly_Status = self.intentionsList.value(forKey: "monthly_status") as? Int
                
                if overAll_Status == 0 {
                    self.collectionCount = self.collectionCount + 1
                    self.arrayOfStringCollection.append("Overall")
                }
                if yearly_Status == 0 {
                    self.collectionCount = self.collectionCount + 1
                    self.arrayOfStringCollection.append("Yearly")
                }
                if monthly_Status == 0 {
                    self.collectionCount = self.collectionCount + 1
                    self.arrayOfStringCollection.append("Monthly")
                }
                print(self.collectionCount)
                
                if self.collectionCount == 0 {
                }else{
                    let layout2: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                    layout2.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
                    layout2.itemSize = CGSize(width: Int(self.intentionCollectionView.frame.size.width)/(self.collectionCount)-10, height: 45)
                    layout2.scrollDirection = .horizontal
                    self.intentionCollectionView.collectionViewLayout = layout2
                    self.intentionCollectionView.reloadData()
                    self.monthlyTable.reloadData()
                    self.yearlyTable.reloadData()
                }
            }
            else {
                 self.view.makeToast(message)
            }
        }
        basicFunctions.stopLoading()
    }
    
    @IBAction func backMenu(_ sender: Any) {
        if self.comeFromIntentions == "yes" {
            if USER_VIBE.contains("Mini Tribes") {
                let ra = "Mini Tribes"
                let newVibe = USER_VIBE.replacingOccurrences(of: ra, with: "Mini")

                if newVibe.contains("Mini") &&  !newVibe.contains("Soul Love") && !newVibe.contains("Tribe"){
    //                        if let tabBarController = self.tabBarController {
    //                            let indexToRemove = 2
    //                            if indexToRemove < tabBarController.viewControllers!.count {
    //                                var viewControllers = tabBarController.viewControllers
    //                                viewControllers?.remove(at: indexToRemove)
    //                                tabBarController.viewControllers = viewControllers
    //                            }
    //                        }
                    
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let navigate = storyboard.instantiateViewController(withIdentifier: "SecondTabBarVC") as! SecondTabBarVC
//                        navigate.selectedIndex = 2
                        let leftController = storyboard.instantiateViewController(withIdentifier: "LeftMenuViewController") as! LeftMenuViewController
                        let slideMenuController = SlideMenuController(mainViewController: UINavigationController(rootViewController:navigate), leftMenuViewController: leftController)
                        slideMenuController.delegate = leftController as? SlideMenuControllerDelegate
                        UIApplication.shared.windows.first?.rootViewController = slideMenuController
                        UIApplication.shared.windows.first?.makeKeyAndVisible()
                    self.tabBarController?.tabBar.isUserInteractionEnabled = true
                }else{
                    //5
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let navigate = storyboard.instantiateViewController(withIdentifier: "TTabBarViewController") as! TTabBarViewController
//                    navigate.selectedIndex = 4
                    let leftController = storyboard.instantiateViewController(withIdentifier: "LeftMenuViewController") as! LeftMenuViewController
                    let slideMenuController = SlideMenuController(mainViewController: UINavigationController(rootViewController:navigate), leftMenuViewController: leftController)
                    slideMenuController.delegate = leftController as? SlideMenuControllerDelegate
                    UIApplication.shared.windows.first?.rootViewController = slideMenuController
                    UIApplication.shared.windows.first?.makeKeyAndVisible()
                    self.tabBarController?.tabBar.isUserInteractionEnabled = true
                }
            }else{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let navigate = storyboard.instantiateViewController(withIdentifier: "thirdTabBarVC") as! thirdTabBarVC
//                navigate.selectedIndex = 2
                let leftController = storyboard.instantiateViewController(withIdentifier: "LeftMenuViewController") as! LeftMenuViewController
                let slideMenuController = SlideMenuController(mainViewController: UINavigationController(rootViewController:navigate), leftMenuViewController: leftController)
                slideMenuController.delegate = leftController as? SlideMenuControllerDelegate
                UIApplication.shared.windows.first?.rootViewController = slideMenuController
                UIApplication.shared.windows.first?.makeKeyAndVisible()
                
                if !USER_VIBE.contains("Mini") &&  USER_VIBE.contains("Soul Love") && !USER_VIBE.contains("Tribe") {
                    SELECT_VIBE = "Soul Love"
                }
                if !USER_VIBE.contains("Mini") &&  !USER_VIBE.contains("Soul Love") && USER_VIBE.contains("Tribe") {
                    SELECT_VIBE = "Tribe"
                }
            }
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func hidePopUpView1(_ sender: Any) {
        self.optionView1.removeFromSuperview()
    }
    @IBAction func AddIntentions(_ sender: Any) {
        if self.collectionCount == 0 {
            self.view.makeToast("You have entered all of your intentions at this time. No more intentions can be added or edited.")
        }else{
            self.optionView1.frame = self.view.frame
            self.optionView1.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            self.view.addSubview(self.optionView1)
        }
    }
    
    @objc func createIntentions(_ sender: UIButton) {
        
        let str = sender.title(for: .normal)
        
        if str == "Overall" {
            let vc = storyboard?.instantiateViewController(identifier: "overAllIntentions") as! overAllIntentions
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if str == "Monthly" {
            let vc = storyboard?.instantiateViewController(identifier: "monthlyIntentionsVC") as! monthlyIntentionsVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if str == "Yearly" {
            let vc = storyboard?.instantiateViewController(identifier: "yearlyIntentionsVC") as! yearlyIntentionsVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        self.optionView1.removeFromSuperview()
        self.collectionCount = 0
        self.arrayOfStringCollection.removeAll()
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        self.monthlyTableHeight_Constraint.constant = CGFloat(108 * self.monthlyIntentionList.count)
//        self.yearlyTableHeight_Constraint.constant = CGFloat(108 * self.yearlyIntentionList.count)
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == monthlyTable {
            return self.monthlyIntentionList.count
        }else{
            return self.yearlyIntentionList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == monthlyTable {
            let cell = tableView.dequeueReusableCell(withIdentifier: "monthly_intentionCell") as! monthly_intentionCell
            var dict = NSDictionary()
            dict = self.monthlyIntentionList.object(at: indexPath.row) as! NSDictionary
            cell.intentioTitle.text = "\(dict.value(forKey: "month") as! String)" + " " + "\(dict.value(forKey: "year") as! String)"
            cell.intentionSubtitle.text = dict.value(forKey: "answere") as? String
            monthylyHeight += 76 + cell.intentionSubtitle.text!.height(constraintedWidth: cell.intentionSubtitle.bounds.width, font: .systemFont(ofSize: 15))
            if monthylyHeight < 100 {
                monthylyHeight = 100
            }
            monthlyTableHeight_Constraint.constant = monthylyHeight
            cell.contentView.setNeedsLayout()
            cell.contentView.layoutIfNeeded()
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "yearly_intentionCell") as! yearly_intentionCell
            var dict = NSDictionary()
            dict = self.yearlyIntentionList.object(at: indexPath.row) as! NSDictionary
            cell.intentioTitle.text =  dict.value(forKey: "year") as? String
            cell.intentionSubtitle.text = dict.value(forKey: "answere") as? String
            yearlyHeight += 76 + cell.intentionSubtitle.text!.height(constraintedWidth: cell.intentionSubtitle.bounds.width, font: .systemFont(ofSize: 15))
            if yearlyHeight < 100 {
                yearlyHeight = 100
            }
            yearlyTableHeight_Constraint.constant = yearlyHeight
            cell.contentView.setNeedsLayout()
            cell.contentView.layoutIfNeeded()
            return cell
        }
    }
}

extension IntentionListVC: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collectionCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popUpCollecionButton_cell", for: indexPath) as! popUpCollecionButton_cell
        cell.buttonView.layer.cornerRadius = 5
        cell.buttonView.layer.borderWidth = 0.5
        cell.buttonView.layer.borderColor = UIColor.lightGray.cgColor
        
        cell.butn.tag = indexPath.row
        cell.butn.addTarget(self, action: #selector(createIntentions(_ :)), for: .touchUpInside)
        cell.butn.setTitle(self.arrayOfStringCollection[indexPath.row], for: .normal)
        return cell
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 100, height: 35)
//    }
}
