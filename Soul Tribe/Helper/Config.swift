//
//  Config.swift
//  Hyak
//
//  Created by mac-16 on 3/18/20.
//  Copyright © 2020 mac-16. All rights reserved.
//


import Foundation
import UIKit
import CoreData
import SDWebImage

let SB_instaStory = UIStoryboard(name: "SB_instaStory", bundle: nil)

class Config: NSObject,UIAlertViewDelegate {
    let API_URL = "https://soultribenow.com/api/user/"
    let baseImageUrl = "https://soultribenow.com/storage/app/public/"
    
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.height
    
    let AppUserDefaults = UserDefaults.standard
    let debug_mode = 1
    
    let api_key = "tribe123"
    
    let googleApiKey = "AIzaSyC4JU4fmfFQ8eHsksAF1GFbQePKev4Taak"
    let placesApiKey = "AIzaSyAEDxadEkVaLIi5t6cV6rWYvkbVbJydGBw" //"AIzaSyCcPWHyC2mJjFtCKGRgQHyYO310KRH25tw"
    
    /********************************* App Color Codes ***************************************/
//    #16C79A
      
    let AppThemeMainColor = UIColor(red: 0.09, green: 0.78, blue: 0.60, alpha: 0.5)
    let makeToaskBgColor = UIColor(red: 0.24, green: 0.78, blue: 0.60, alpha: 1.00)
    
    func setimage(image_url: String,image_name: UIImageView){
           if image_url != ""{
               let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
               activityIndicator.center = (image_name.center)
               activityIndicator.hidesWhenStopped = true
               activityIndicator.startAnimating()
               let block: SDWebImageCompletionBlock! = { (image:UIImage?, error: Error?, cache:SDImageCacheType, url: URL?) in
                   activityIndicator.stopAnimating()
               }
               let picture_url: URL = URL(string: image_url) ?? URL(string: "https://www.google.com")!
               image_name.addSubview(activityIndicator)
               image_name.sd_setImage(with: picture_url , placeholderImage: UIImage(named: "dummy4"), options:  [], completed:block)
           }else{
               image_name.image = UIImage(named: "user")
           }
       }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func show(LoadVIew: UIView) -> UIView {
        let uiVIew = UIView()
        uiVIew.frame = CGRect(x: 0, y: 0, width: LoadVIew.frame.size.width, height: LoadVIew.frame.size.height)
        uiVIew.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
        let uiImg = UIImageView()
        uiImg.frame = CGRect(x: LoadVIew.frame.size.width/2 - 75, y: LoadVIew.frame.size.height/2 - 50, width: 150, height: 100)
        
        uiImg.image = UIImage(named: "Ratelogo")
        uiVIew.addSubview(uiImg)
        
        UIView.animate(withDuration: 1, delay: 0, options: [UIView.AnimationOptions.autoreverse,UIView.AnimationOptions.repeat,UIView.AnimationOptions.curveEaseInOut],
        animations: {
            uiImg.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        }, completion:nil)
        return uiVIew
    }
    func hide(LoadVIew: UIView){
        LoadVIew.removeFromSuperview()
        LoadVIew.isHidden = true
    }
    func addRedDotAtTabBarItemIndex(index: Int, tabbarController: UITabBarController) {
        for subview in tabbarController.tabBar.subviews {

            if let subview = subview as? UIView {

                if subview.tag == 1234 {
                    subview.removeFromSuperview()
                    break
                }
            }
        }
        let RedDotRadius: CGFloat = 5
        let RedDotDiameter = RedDotRadius * 2

        let TopMargin:CGFloat = 5

        let TabBarItemCount = CGFloat(tabbarController.tabBar.items!.count)

        let screenSize = UIScreen.main.bounds
        let HalfItemWidth = (screenSize.width) / (TabBarItemCount * 2)

        let  xOffset = HalfItemWidth * CGFloat(index * 2 + 1)

        let imageHalfWidth: CGFloat = (tabbarController.tabBar.items![index] as! UITabBarItem).selectedImage!.size.width / 2

        let redDot = UIView(frame: CGRect(x: xOffset + imageHalfWidth - 7, y: TopMargin, width: RedDotDiameter, height: RedDotDiameter))

        redDot.tag = 1234
        redDot.backgroundColor = Config().AppThemeMainColor
        redDot.layer.cornerRadius = RedDotRadius

            tabbarController.tabBar.addSubview(redDot)

    }
}
