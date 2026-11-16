//
//  InviteFriendVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 11/06/21.
//

import UIKit
import FBSDKShareKit
class InviteFriendVC: UIViewController, SharingDelegate {
    func sharer(_ sharer: Sharing, didCompleteWithResults results: [String : Any]) {
        
    }
    
    func sharer(_ sharer: Sharing, didFailWithError error: Error) {
        
    }
    
    func sharerDidCancel(_ sharer: Sharing) {
        
    }
    
    var leftDrawerTransition:DrawerTransition!
    var left = LeftMenuViewController()
    var stringdata = "Join me within Soul Tribe! The first social and dating app for conscious creators. Connect with others for love and/ or friendships, all while amplifying manifestations! https://soultribenow.com/"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true

        // Do any additional setup after loading the view.
    }
    @IBAction func backbtnaction(_ sender:UIButton) {
        self.slideMenuController()?.toggleLeft()

    }
    
    @IBAction func facebookbtn(_ sender:UIButton){
    //ex: fb-messenger://post?text=hello
   // ex: fb-messenger://send?text=hello
   // ex: fb-messenger://messaging?text=hello
        
        
        let urlWhats = "https://m.me?text=\(stringdata)"
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            if let whatsappURL = NSURL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL as URL) {
                    UIApplication.shared.open(whatsappURL as URL, options: [:], completionHandler: { (Bool) in

                    })
                } else {
                    let alert = UIAlertController(title: "Error", message: "Please install messenger first.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
    
//        guard let url = URL(string: "https://soultribenow.com/") else {
//            preconditionFailure("https://soultribenow.com/")
//        }
//
//        let content = ShareLinkContent()
//        content.contentURL = url
//        // Optional
//        content.hashtag = Hashtag(stringdata)
//        content.quote = "Soul tribe"
//
//        // Show as a message dialog -> Messenger App
//        let messageDialog = MessageDialog(content: content, delegate: self)
//        messageDialog.show()

//        let dialog = ShareDialog.init(fromViewController: self, content: content, delegate: self)
//        do {
//
//            try dialog.validate()
//        } catch {
//            print(error)
//        }
//
//        dialog.show()
        
//        let fbURLWeb: NSURL = NSURL(string: stringdata) ?? NSURL()
//        let fbURLID: NSURL = NSURL(string: stringdata) ?? NSURL()
//
//        if(UIApplication.shared.canOpenURL(fbURLID as URL)){
//            UIApplication.shared.open(fbURLID as URL, options: [:], completionHandler: nil)
//        } else {
//            UIApplication.shared.open(fbURLWeb as URL, options: [:], completionHandler: nil)
//        }
  
    }
    @IBAction func whatsappbtn(_ sender:UIButton){
        let urlWhats = "whatsapp://send?text=\(stringdata)"
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            if let whatsappURL = NSURL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL as URL) {
                    UIApplication.shared.open(whatsappURL as URL, options: [:], completionHandler: { (Bool) in

                    })
                } else {
                    let alert = UIAlertController(title: "Error", message: "Please install WhatsApp first.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
//        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
//            if let whatsappURL = NSURL(string: urlString) {
//                if UIApplication.shared.canOpenURL(whatsappURL as URL) {
//                    UIApplication.shared.open(whatsappURL as URL, options: [:], completionHandler: { (Bool) in
//
//                    })
//                } else {
//                    let alert = UIAlertController(title: "Error", message: "Please install WhatsApp first.", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//                    self.present(alert, animated: true, completion: nil)
//
//                }
//            }
//        }

    }
    
    @IBAction func sharekbtn(_ sender:UIButton){
        // set up activity view controller
        let textToShare = [ stringdata]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.postToWeibo,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.postToTencentWeibo
        ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
