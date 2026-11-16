//
//  overAllIntentions.swift
//  Soul Tribe
//
//  Created by mac-14 on 29/11/21.
//

import UIKit

class yearlyIntentionsVC: UIViewController,UITextViewDelegate {

    @IBOutlet weak var optionView1: UIView!
    @IBOutlet weak var optionView1CornerRadius: UIView!
    @IBOutlet weak var popUp_back: UIButton!
    @IBOutlet weak var popUp_Affirm: UIButton!
    
    @IBOutlet weak var firstDate_lbl: UILabel!
    @IBOutlet weak var firstDate_SubLbl: UILabel!
    @IBOutlet weak var secondDate_lbl: UILabel!
    @IBOutlet weak var secondDate_subLbl: UILabel!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var text_View: UITextView!
    var comesFromSignUp = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        text_View.textColor = UIColor.lightGray
        
        optionView1CornerRadius.layer.cornerRadius = 6
        popUp_back.layer.borderWidth = 0.5
        popUp_back.layer.cornerRadius = 6
        popUp_Affirm.layer.cornerRadius = 6
        popUp_back.layer.borderColor = UIColor.lightGray.cgColor
        text_View.layer.borderWidth = 0.5
        text_View.layer.borderColor = UIColor.lightGray.cgColor
        text_View.layer.cornerRadius = 6
        saveButton.layer.cornerRadius = 6
        skipButton.layer.borderColor = UIColor.lightGray.cgColor
        skipButton.layer.borderWidth = 0.5
        skipButton.layer.cornerRadius = 6
        
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy"
        let dateString = formatter.string(from: now)
    
        self.firstDate_lbl.text = "Yearly Intentions"
        self.secondDate_lbl.text = dateString + " Intentions"
    }
    
    @IBAction func hidePopUpView1(_ sender: Any) {
        self.optionView1.removeFromSuperview()
    }
    @IBAction func AffirmIntentions(_ sender: Any) {
        self.optionView1.removeFromSuperview()
        saveIntentions()
    }
    
    func saveIntentions() {
      
            let parameterDictionary = NSMutableDictionary()
         let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
           parameterDictionary.setValue("tribe123", forKey: "api_key")
            parameterDictionary.setValue(userID, forKey: "user_id")
            parameterDictionary.setValue("Yearly", forKey: "type")
            parameterDictionary.setValue(text_View.text, forKey: "answere")
            parameterDictionary.setValue(self.secondDate_subLbl.text, forKey: "question")
           print(parameterDictionary)
            let methodName = "insert_intention"

            DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
                let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
                let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""

                if status == "1" {
                    self.view.makeToast(message)
                    
                    if self.comesFromSignUp == "yes1" {
                        DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "monthlyIntentionsVC") as! monthlyIntentionsVC
                            vc.comesFromSignUp = "yes2"
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }else{
//                        DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
//                            self.navigationController?.popViewController(animated: true)
//                        }
                        if showIntentionVC.contains("Overall") && !showIntentionVC.contains("monthly") {
                            showIntentionVC = showIntentionVC.replacingOccurrences(of: "yearly", with: "")
                            DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "overAllIntentions") as! overAllIntentions
                                self.navigationController?.pushViewController(vc, animated: true)
                                showIntentionVC = showIntentionVC.replacingOccurrences(of: "Overall", with: "")
                                print(showIntentionVC)
                            }
                        }else{
                            if !showIntentionVC.contains("Overall") && showIntentionVC.contains("monthly") {
                                showIntentionVC = showIntentionVC.replacingOccurrences(of: "yearly", with: "")
                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "monthlyIntentionsVC") as! monthlyIntentionsVC
                                self.navigationController?.pushViewController(vc, animated: true)
                                showIntentionVC = showIntentionVC.replacingOccurrences(of: "monthly", with: "")
                                print(showIntentionVC)
                            }else{
                                DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
                                    let vc = self.storyboard?.instantiateViewController(identifier: "IntentionListVC") as! IntentionListVC
                                    vc.comeFromIntentions = "yes"
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                            }
                        }
                    }
                }
                else {
                     self.view.makeToast(message)
                }
            }
      //  }
    }
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        if text_View.textColor == UIColor.lightGray {
//            text_View.text = ""
//            text_View.textColor = UIColor.black
//        }
//    }
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if text_View.text.isEmpty {
//            text_View.text = "Write your answer here"
//            text_View.textColor = UIColor.lightGray
//        }
//    }
    
    func IntenstionAPI(Type:String!){
        let date = Date()
        let dateformat = DateFormatter()
        dateformat.dateFormat = "yyyy-MM-dd"
        let finaldate = dateformat.string(from: date ?? Date())
        let parameterDictionary = NSMutableDictionary()
        let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
        parameterDictionary.setValue("tribe123", forKey: "api_key")
        parameterDictionary.setValue(userID, forKey: "user_id")
        parameterDictionary.setValue(Type, forKey: "type")
        parameterDictionary.setValue(finaldate, forKey: "date")
        print(parameterDictionary)
        let methodName = "update_intension_list"
        DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""

            if status == "1" {
                self.view.makeToast(message)
            }
            else {
                self.view.makeToast(message)
            }
        }
}
    
    @IBAction func skipBtnAction(_ sender: Any) {
        if self.comesFromSignUp == "yes1" {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "monthlyIntentionsVC") as! monthlyIntentionsVC
            vc.comesFromSignUp = "yes2"
            self.navigationController?.pushViewController(vc, animated: true)
            self.IntenstionAPI(Type: "month")
        }else{
            if showIntentionVC.contains("Overall") && !showIntentionVC.contains("monthly") {
                showIntentionVC = showIntentionVC.replacingOccurrences(of: "yearly", with: "")
//                DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "overAllIntentions") as! overAllIntentions
                    self.navigationController?.pushViewController(vc, animated: true)
                    showIntentionVC = showIntentionVC.replacingOccurrences(of: "Overall", with: "")
                    print(showIntentionVC)
//                }
            }else{
                if !showIntentionVC.contains("Overall") && showIntentionVC.contains("monthly") {
                    showIntentionVC = showIntentionVC.replacingOccurrences(of: "yearly", with: "")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "monthlyIntentionsVC") as! monthlyIntentionsVC
                    self.navigationController?.pushViewController(vc, animated: true)
                    showIntentionVC = showIntentionVC.replacingOccurrences(of: "monthly", with: "")
                    self.IntenstionAPI(Type: "month")
                    print(showIntentionVC)
                }else{
//                    DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
                        let vc = self.storyboard?.instantiateViewController(identifier: "IntentionListVC") as! IntentionListVC
                        vc.comeFromIntentions = "yes"
                        self.navigationController?.pushViewController(vc, animated: true)
//                    }
                }
            }
        }
    }
    @IBAction func saveBtnAction(_ sender: Any) {

        if self.text_View.text == "" {
            self.view.makeToast("Please fill your intentions")
        }else{
        self.optionView1.frame = self.view.frame
        self.optionView1.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.view.addSubview(self.optionView1)
        }
    }
    @IBAction func backMenu(_ sender: Any) {
        if self.comesFromSignUp == "yes1" {
            self.navigationController?.popViewController(animated: true)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
}
