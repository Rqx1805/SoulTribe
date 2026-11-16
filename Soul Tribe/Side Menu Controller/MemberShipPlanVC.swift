//
//  MemberShipPlanVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 11/06/21.
//

import UIKit
import StoreKit

class plancell:UICollectionViewCell{
    
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var trialBtn: UIButton!
    @IBOutlet weak var plantypeLbl:UILabel!
    @IBOutlet weak var durationLbl:UILabel!
    @IBOutlet weak var pagecontrolImg: UIImageView!
   
}

class MemberShipPlanVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var mainview: UIView!
    @IBOutlet weak var innerview: UIView!
    @IBOutlet weak var headerview: UIView!
    @IBOutlet weak var ratingButton: UIButton!
   
    var comeFromProfile = String()
    var leftDrawerTransition:DrawerTransition!
    var left = LeftMenuViewController()
    
    var pricearray = ["11.99" ,"111.99"]
    var planarray = ["Monthly Plan" ,"Yearly Plan"]
    var durationarray = ["Less than 40 cents a day!" ,"Get 2 months free!"]
    
    @IBOutlet weak var planCollectionView: UICollectionView!
    let screenWidth = UIScreen.main.bounds.size.width
    var responsedata = NSMutableArray()
    var subscription_count = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        mainview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        mainview.layer.shadowOpacity = 0.8
        mainview.layer.shadowOffset = .zero
        mainview.layer.shadowRadius = 6
        mainview.layer.cornerRadius = 10
        innerview.layer.cornerRadius = 10
        
        headerview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        headerview.layer.shadowOpacity = 0.5
        headerview.layer.shadowOffset = .zero
        headerview.layer.shadowRadius = 5

        self.navigationController?.isNavigationBarHidden = true

        if premiumPlaStatus == 0 {
            self.ratingButton.setTitle("Purchase", for: .normal) // Try it for FREE for 7 Days!
        }else{
            self.ratingButton.setTitle("Start Your FREE 7-Day Trial Today!", for: .normal)
        }
        
        let CategoriesLiberaryLayOut = UICollectionViewFlowLayout()
        CategoriesLiberaryLayOut.itemSize = CGSize(width: screenWidth, height: 708)
        CategoriesLiberaryLayOut.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        CategoriesLiberaryLayOut.minimumInteritemSpacing = 0
        CategoriesLiberaryLayOut.minimumLineSpacing = 5
        CategoriesLiberaryLayOut.scrollDirection = .horizontal
        planCollectionView.collectionViewLayout = CategoriesLiberaryLayOut
        self.PlanAPI()
        // Do any additional setup after loading the view.
    }
    func PlanAPI(){
        basicFunctions.presentLoader()
        let parameterDictionary = NSMutableDictionary()
        parameterDictionary.setValue("tribe123", forKey: "api_key")
        parameterDictionary.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")

       print(parameterDictionary)
        let methodName = "get_subscriptions"

        DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
            self.subscription_count = DataManager.getVal(responseData?["subscription_count"]) as? Int ?? 0
            if status == "1" {
                self.responsedata =  DataManager.getVal(responseData?["data"]) as? NSMutableArray ?? []
                self.planCollectionView.reloadData()
                basicFunctions.stopLoading()
            }
            else {
                self.view.makeToast(message)
                basicFunctions.stopLoading()
            }
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return responsedata.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! plancell
        //let price = pricearray[indexPath.item]
        var dict = NSDictionary()
        dict = responsedata.object(at: indexPath.row) as! NSDictionary
        let price = dict.value(forKey: "amount") as? Int ?? 0
        let floatprice = Float(price)
        let finalprice = floatprice/100.0
        
        cell.priceLbl.text = "Price: " + "$" + String(finalprice)
        let interval = dict.value(forKey: "interval") as? String ?? ""
        if interval == "month" {
            cell.plantypeLbl.text = "Monthly Plan"
            cell.durationLbl.text = "Less than 40 cents a day!"
        }else{
            cell.plantypeLbl.text = "Yearly Plan"
            cell.durationLbl.text = "Get 2 months free!"
        }
        cell.trialBtn.tag = indexPath.item
        
        if indexPath.item == 0 {
            cell.pagecontrolImg.image = UIImage(named: "slide01")
        }else{
            cell.pagecontrolImg.image = UIImage(named: "slide02")
        }
        
        cell.trialBtn.addTarget(self, action: #selector(trialBtn(_:)), for: .touchUpInside)
        return cell
    }
    
    @objc func trialBtn(_ sender:UIButton) {
        
        var dict = NSDictionary()
        dict = responsedata.object(at: sender.tag) as! NSDictionary
        let price_id = dict.value(forKey: "id") as? String ?? ""
        let plan_type = dict.value(forKey: "plan_type") as? String ?? ""
        let interval = dict.value(forKey: "interval") as? String ?? ""
        
        var identi = String()
        if sender.tag == 0 {
           identi = "One_Month_Plan"
           let defaults = UserDefaults.standard
           defaults.setValue(identi, forKey: "1Month")
           defaults.synchronize()
        }else{
           identi = "Twelfth_Month_Plan"
           let defaults = UserDefaults.standard
           defaults.setValue(identi, forKey: "1Year")
           defaults.synchronize()
        }
        
        let product = SKProduct.init()
        product.setValue(identi, forKey: "productIdentifier")
        let defaults = UserDefaults.standard
        defaults.setValue(price_id, forKey: "price_id")
        defaults.setValue(plan_type, forKey: "plan_type")
        if subscription_count == 0 {
            defaults.setValue("trial", forKey: "interval")
        }else{
            defaults.setValue(interval, forKey: "interval")
        }
        defaults.synchronize()
        RazeFaceProducts.store.buyProduct(product)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: planCollectionView.frame.size.width, height: 708)
    }
    
    @IBAction func privacyAction(_ sender:UIButton){
        let navigate = storyboard?.instantiateViewController(withIdentifier: "T_CVC") as! T_CVC
        navigate.typeL = "privacy"
        self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
    }
    
    @IBAction func termsuseAction(_ sender:UIButton){
        let navigate = storyboard?.instantiateViewController(withIdentifier: "T_CVC") as! T_CVC
        navigate.typeL = "terms"
        self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: navigate), close: true)
    }
    
    @IBAction func backbtnaction(_ sender:UIButton) {
        if self.comeFromProfile == "y" || self.comeFromProfile == "fromLikedVC" {
            self.navigationController?.popViewController(animated: true)
        }else{
            self.slideMenuController()?.toggleLeft()
        }
        
    }
    @IBAction func buyFreeAction(_ sender:UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "membership_PlanWebVC") as! membership_PlanWebVC
        if self.comeFromProfile == "y" || self.comeFromProfile == "fromLikedVC" {
            vc.comeFromFromFree = "y"
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
