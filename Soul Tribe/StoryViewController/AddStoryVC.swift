//
//  AddStoryVC.swift
//  StoryDemo
//
//  Created by MAC-25 on 23/11/21.
//

import UIKit
import AssetsPickerViewController
import AssetsLibrary
import Photos
import AVKit
import AVFoundation
import JJFloatingActionButton
import Foundation
import AVKit

protocol SendVideoDataDelegate2 {
    func videoData2(data: Data)
}

class colorCell: UICollectionViewCell{
    @IBOutlet weak var colorview:UIView!
    @IBOutlet weak var indexoneImg: UIImageView!
    @IBOutlet weak var colourBtn:UIButton!
    @IBOutlet weak var selectedColorDot_Lbl1: UILabel!
}
class colorCell2: UICollectionViewCell{
    @IBOutlet weak var colorview:UIView!
    @IBOutlet weak var indexoneImg: UIImageView!
    @IBOutlet weak var colourBtn:UIButton!
    @IBOutlet weak var selectedColorDot_Lbl2: UILabel!
}

class ImageCell: UICollectionViewCell {
    @IBOutlet weak var imageview:UIImageView!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var deleteBtn:UIButton!
}

class AddStoryVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SendVideoDataDelegate2,UITextViewDelegate, SendVideoDataDelegate{
    func videoData(data: Data) {
        print("new", data)
        self.videoData = data
    }
    
    func videoData2(data: Data) {
        print("new1", data)
        self.videoData = data
        let dict = ["key1":"Videos","img1": videoData] as? [String : Any] ?? [:]
        self.arr_assetsnew.append(dict)
        
    }
    @IBOutlet weak var cropingStatusView: UIView!
    @IBOutlet weak var ShareTextView: UIView!
    @IBOutlet weak var typeTextView: UITextView!
    @IBOutlet weak var colourCollectionView: UICollectionView!
    @IBOutlet weak var colourCollectionView2: UICollectionView!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var shareImageCameraView: UIView!
    
    @IBOutlet weak var cameraImg: UIImageView!
    @IBOutlet weak var cameraVideoView: UIView!
    @IBOutlet weak var shareImageBtn: UIButton!
    @IBOutlet weak var shareImageGalleryView: UIView!
    @IBOutlet weak var imageGalleryCollectionView: UICollectionView!
    @IBOutlet weak var shareImageGalleryBtn: UIButton!
    var cameraVideoData = Data()
    var cameraImageData = UIImage()
    var videoData = Data()
    var selectedColor = String()
    var selectedColor2 = String()
    var arr_assets = [[String: Any]]()
    var arr_assetsnew = [[String: Any]]()
    var videoarr_assets = [PHAsset]()
    var selectedTopIndex = Int()
    var selectedbottomIndex = Int()
    var mediaPath: URL!
    
    @IBOutlet weak var shareBtnNEW: UIButton!
    var colorArray = ["#FFFFFF","#030303","#A0F27D","#16C79A","#F5972D","#A72FEC","#F66CBA","#242497","#FF0000","#00FF00","#0000FF","#FFFF00","#00FFFF","#FF00FF","#2F557D","#2F1E11"]
    var avpController = AVPlayerViewController()
    var player = AVPlayer()
    var imageAndVideo = String()
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    fileprivate let actionButton = JJFloatingActionButton()

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        typeTextView.centerVerticalText()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cropingStatusView.isHidden = true
//        cameraPreviewLayer?.frame = view.layer.frame
//        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        let toolbarNew = UIToolbar()
                let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
                let doneButton = UIBarButtonItem(title: Bundle.main.localizedString(forKey: "Done", value: nil, table: "Localizable"), style: .done, target: self, action: #selector(NewDoneButtonTapped))
                      
                toolbarNew.setItems([flexSpace, doneButton], animated: true)
                toolbarNew.sizeToFit()
                toolbarNew.isTranslucent = false
                toolbarNew.barStyle = .default
                toolbarNew.tintColor = Config().AppThemeMainColor
                typeTextView.inputAccessoryView = toolbarNew
        imageAndVideo = ""
//        self.typeTextView.centerVertically()
        NotificationCenter.default.addObserver(self, selector: #selector(self.addvideoInArr(_:)), name: NSNotification.Name("addVideoImage"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.dismisAction(_:)), name: NSNotification.Name("dismissView"), object: nil)
        typeTextView.text = "type here..."
        typeTextView.textColor = UIColor.lightGray
        
        self.typeTextView.delegate = self
        shareBtn.layer.cornerRadius =  8
        shareImageBtn.layer.cornerRadius =  8
        shareBtnNEW.layer.cornerRadius =  8
        shareImageGalleryBtn.layer.cornerRadius =  8
        self.ShareTextView.isHidden = false
        self.shareImageCameraView.isHidden = true
        self.shareImageGalleryView.isHidden = true
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        let LiberaryLayOut = UICollectionViewFlowLayout()
        LiberaryLayOut.itemSize = CGSize(width: screenWidth/1.5, height: screenHeight/1.5)
        LiberaryLayOut.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        LiberaryLayOut.minimumInteritemSpacing = 5
        LiberaryLayOut.minimumLineSpacing = 0
        LiberaryLayOut.scrollDirection = .vertical
        imageGalleryCollectionView.collectionViewLayout = LiberaryLayOut
                actionButton.buttonColor = UIColor.orange
                   actionButton.addItem(title: "Add Images", image: UIImage(named: "insert-picture-icon")) { item in
                       let picker = AssetsPickerViewController()
                       let config = AssetsPickerConfig()
                       config.albumIsShowEmptyAlbum = false
                  
                       let options = PHFetchOptions()
                       options.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
                       options.sortDescriptors = [NSSortDescriptor(key: "duration", ascending: true)]
                       config.assetFetchOptions = [
                           .smartAlbum: options,
                           .album: options
                       ]
                       picker.pickerConfig = config
                       picker.pickerDelegate = self
                       self.present(picker, animated: true, completion: nil)
                   }
                   
                   actionButton.buttonColor = UIColor.orange
                   actionButton.addItem(title: "Add Videos", image: UIImage(named: "video-camera")) { item in
                       
                       let vc = self.storyboard?.instantiateViewController(withIdentifier: "UploadVideoVC") as! UploadVideoVC
                       vc.delegate = self
                       self.present(vc, animated: true, completion: nil)
                   }
                   actionButton.items[1].buttonColor = UIColor(red: 179/255, green: 110/255, blue: 186/255, alpha: 1.0)
                   actionButton.items[0].buttonColor = UIColor(red: 250/255, green: 203/255, blue: 0/255, alpha: 1.0)
        // Do any additional setup after loading the view.
    }
    @objc func NewDoneButtonTapped() {
            self.view.endEditing(true)
        }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        // get the current text, or use an empty string if that failed
                let currentText = textView.text ?? ""
                // attempt to read the range they are trying to change, or exit if we can't
                guard let stringRange = Range(range, in: currentText) else { return false }
                // add their new text to the existing text
                let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        
        self.typeTextView.centerVerticalText()
        if updatedText.count > 250 {
            self.view.makeToast("Text limit exceeded")
            let str = updatedText.prefix(250)
            textView.text = String(str)
            return false
        }else{
            return updatedText.count <= 250
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.typeTextView.centerVerticalText()
    }
    
    @objc func addvideoInArr(_ notification: Notification) {
        if let data1 = notification.userInfo?["data"] as? UIImage {
            print("new22",data1)
            let dict = ["key1":"Video","img": data1] as? [String : Any] ?? [:]
            self.arr_assets.append(dict)
            self.imageGalleryCollectionView.reloadData()
        }
    }
    @objc func dismisAction(_ notification: Notification) {
        self.dismiss(animated: true, completion: nil)
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if typeTextView.textColor == UIColor.lightGray {
            typeTextView.text = ""
            typeTextView.textColor = UIColor.white
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if typeTextView.text.isEmpty {
            typeTextView.text = "type here..."
            typeTextView.textColor = UIColor.lightGray
        }
    }
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.colourCollectionView {
            return colorArray.count
        }else if collectionView == self.colourCollectionView2 {
            return colorArray.count
        }else{
            return arr_assets.count
        }
    }
    
    @objc func colorChange(_ sender:UIButton){
        self.selectedColor =  colorArray[sender.tag]
        self.typeTextView.textColor = hexStringToUIColor(hex: self.selectedColor)
 
        selectedTopIndex = sender.tag
        colourCollectionView.reloadData()
        colourCollectionView.scrollToItem(at: IndexPath(item: sender.tag, section: 0), at: .right, animated: false)
//        let cell = colourCollectionView.cellForItem(at: IndexPath(item: sender.tag, section: 0)) as! colorCell
//        cell.selectedColorDot_Lbl1.layer.cornerRadius = cell.selectedColorDot_Lbl1.frame.width/2
//
//        cell.selectedColorDot_Lbl1.isHidden = false
        
    }
    @objc func colorChange2(_ sender:UIButton){
        self.selectedColor2 =  colorArray[sender.tag]
        self.typeTextView.backgroundColor = hexStringToUIColor(hex: self.selectedColor2)
        selectedbottomIndex = sender.tag
        colourCollectionView2.reloadData()
        colourCollectionView2.scrollToItem(at: IndexPath(item: sender.tag, section: 0), at: .right, animated: false)
//        let cell = colourCollectionView2.cellForItem(at: IndexPath(item: sender.tag, section: 0)) as! colorCell2
//        cell.selectedColorDot_Lbl2.layer.cornerRadius = cell.selectedColorDot_Lbl2.frame.width/2
//        cell.selectedColorDot_Lbl2.isHidden = false
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.colourCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! colorCell
            if indexPath.row == 0 {
//                cell.indexoneImg.isHidden = false
                cell.colorview.backgroundColor = .white
            }else{
//                cell.indexoneImg.isHidden = true
                let color =  colorArray[indexPath.row]
                cell.colorview.backgroundColor = hexStringToUIColor(hex: color)
            }
            cell.colourBtn.tag = indexPath.row
            cell.colourBtn.addTarget(self, action: #selector(colorChange(_:)), for: .touchUpInside)
            cell.colorview.layer.cornerRadius = cell.colorview.frame.size.width/2
            cell.colorview.layer.cornerRadius = cell.colorview.frame.size.height/2
            cell.selectedColorDot_Lbl1.layer.cornerRadius = cell.selectedColorDot_Lbl1.frame.width/2
            if indexPath.row == selectedTopIndex {
                cell.selectedColorDot_Lbl1.isHidden  = false
            }else{
                cell.selectedColorDot_Lbl1.isHidden  = true
            }
            return cell
        }else if collectionView == self.colourCollectionView2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! colorCell2
            if indexPath.row == 0 {
//                cell.indexoneImg.isHidden = false
                cell.colorview.backgroundColor = .white
            }else{
//                cell.indexoneImg.isHidden = true
                let color =  colorArray[indexPath.row]
                cell.colorview.backgroundColor = hexStringToUIColor(hex: color)
            }
            cell.colourBtn.tag = indexPath.row
            cell.colourBtn.addTarget(self, action: #selector(colorChange2(_:)), for: .touchUpInside)
            cell.colorview.layer.cornerRadius = cell.colorview.frame.size.width/2
            cell.colorview.layer.cornerRadius = cell.colorview.frame.size.height/2
            cell.selectedColorDot_Lbl2.layer.cornerRadius = cell.selectedColorDot_Lbl2.frame.width/2
            if indexPath.row == selectedbottomIndex {
                cell.selectedColorDot_Lbl2.isHidden  = false
            }else{
                cell.selectedColorDot_Lbl2.isHidden  = true
            }
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCell
            let asset = arr_assets[indexPath.row]
//            if asset.mediaType == .image {
//                cell.videoView.isHidden = true
//                cell.imageview.isHidden = false
//            }else if asset.mediaType == .video {
//                cell.videoView.isHidden = false
//                cell.imageview.isHidden = true
//
//                let img = AddStoryVC.getAssetThumbnail(asset: asset)
////                self.player = AVPlayer(url: img)
////                self.avpController = AVPlayerViewController()
////                self.avpController.player = self.player
////                avpController.view.frame.size.width = cell.videoView.frame.size.width
////                avpController.view.frame.size.height = cell.videoView.frame.size.height
////                self.addChild(avpController)
////                cell.videoView.addSubview(avpController.view)
////                if(player.timeControlStatus == AVPlayer.TimeControlStatus.playing) {
////                    player.pause()
////                } else if(player.timeControlStatus == AVPlayer.TimeControlStatus.paused) {
////                    player.play()
////                }
//            }else if asset.mediaType == .unknown {
//                cell.videoView.isHidden = false
//                cell.imageview.isHidden = false
//            }
            cell.imageview.layer.cornerRadius = 8
//            let img = AddStoryVC.getAssetThumbnail(asset: asset)
            
            let dict = self.arr_assets[indexPath.row]
            let img = DataManager.getVal(dict["img"]) as? UIImage ?? UIImage()
            
            cell.imageview.image = img
            cell.deleteBtn.tag = indexPath.row
            cell.deleteBtn.addTarget(self, action: #selector(deleteAsset(_:)), for: .touchUpInside)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == colourCollectionView {
            let cell = collectionView.cellForItem(at: indexPath) as! colorCell
            cell.selectedColorDot_Lbl1.layer.cornerRadius = cell.selectedColorDot_Lbl1.frame.width/2
            
            cell.selectedColorDot_Lbl1.isHidden = false
            
        }else if collectionView == colourCollectionView{
            let cell = collectionView.cellForItem(at: indexPath) as! colorCell2
            cell.selectedColorDot_Lbl2.layer.cornerRadius = cell.selectedColorDot_Lbl2.frame.width/2
            cell.selectedColorDot_Lbl2.isHidden = false
        }
//        selectedColorDot_Lbl2.layer.cornerRadius = selectedColorDot_Lbl2.frame.width/2
    }
    
    @IBAction func AddCameraImgAction(_ sender: Any) {
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == imageGalleryCollectionView {
            return CGSize(width: imageGalleryCollectionView.frame.width/2.1, height: imageGalleryCollectionView.frame.width/2.1);
        }else{
           return CGSize(width: 50, height: 50)
        }
    }
    
    @objc func deleteAsset(_ sender : UIButton){
        self.arr_assets.remove(at: sender.tag)
        self.imageGalleryCollectionView.reloadData()
        
    }
    
    class func getAssetThumbnail(asset: PHAsset) -> UIImage {
           
           let manager = PHImageManager.default()
           let option = PHImageRequestOptions()
           var thumbnail = UIImage()
           option.isSynchronous = true
           manager.requestImage(for: asset, targetSize: CGSize(width: asset.pixelWidth, height: asset.pixelHeight), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
               if let abc = result{
                   thumbnail = abc
               }
           })
           return thumbnail
       }
    
    func openCamera()
        {
            if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
            {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerController.SourceType.camera
                imagePicker.mediaTypes = ["public.image", "public.movie"]
                imagePicker.allowsEditing = false
                
                imagePicker.videoMaximumDuration = 30
                imagePicker.videoQuality = .typeIFrame1280x720
                self.present(imagePicker, animated: true, completion: nil)
            }else
              {
                let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func shareTextBtnAction(_ sender: Any) {
        
        if self.typeTextView.textColor == UIColor.lightGray {
            self.view.makeToast("Please enter message")
        }else{
            //post_stories
    
    let parameterDictionary = NSMutableDictionary()
 let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
   parameterDictionary.setValue("tribe123", forKey: "api_key")
    parameterDictionary.setValue(userID, forKey: "user_id")
    parameterDictionary.setValue("", forKey: "stories")
    parameterDictionary.setValue("text", forKey: "type")
    parameterDictionary.setValue("ios", forKey: "mobile_type")
    parameterDictionary.setValue(self.selectedColor2, forKey: "background_color_code")
            if self.selectedColor.count == 0 {
                parameterDictionary.setValue("#ffffff", forKey: "color_code")
            }else{
                parameterDictionary.setValue(self.selectedColor, forKey: "color_code")
            }
    
    parameterDictionary.setValue(self.typeTextView.text, forKey: "message")
    
    let time = UserDefaults.standard.value(forKey: "videoTime")
    parameterDictionary.setValue(time, forKey: "")
   print(parameterDictionary)
    let methodName = "post_stories"

    DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
        let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
        let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""

        if status == "1" {
            self.view.makeToast(message)
//                self.wholikeList = DataManager.getVal(responseData?["data"]) as! NSMutableArray
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                self.navigationController?.popViewController(animated: true)
            })
        }
        else {
//                 self.view.makeToast(message)
        }
    }
        }
      
    }
    @IBAction func shareImageCameraBtnAction(_ sender: Any) {
        
        print("sa")
        basicFunctions.presentLoader()
//        if self.arr_assets.count == 0 {
//            self.view.makeToast("Please select any Image/Video")
//        }else{
            self.view.endEditing(true)
            basicFunctions.presentLoader()
            let parameterDictionary = NSMutableDictionary()
            let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
            parameterDictionary.setValue("tribe123", forKey: "api_key")
            parameterDictionary.setValue(userID, forKey: "user_id")
    //        parameterDictionary.setValue("", forKey: "stories")
            parameterDictionary.setValue("file", forKey: "type")
            parameterDictionary.setValue("", forKey: "color_code")
            parameterDictionary.setValue("", forKey: "message")
            parameterDictionary.setValue("ios", forKey: "mobile_type")
            let Arr_Data = NSMutableArray()
//            if self.videoData.count == 0 {
//                for index in 0..<self.arr_assets.count{
//
//                    let dict = self.arr_assets[index]
//                   let restr = DataManager.getVal(dict["key1"]) as? String ?? ""
        print(arr_assets.count)
        print(arr_assets)
        print(cameraVideoData)
        print(cameraImageData)
                    if self.imageAndVideo == "video" {
                        let videoDict = NSMutableDictionary()
                        videoDict.setObject("stories", forKey: "keyName" as NSCopying)
                        videoDict.setObject(self.cameraVideoData, forKey: "MyData" as NSCopying)
                        videoDict.setObject("mp4", forKey: "ext" as NSCopying)
                        Arr_Data.add(videoDict)
                        print(Arr_Data)
                        self.cropingStatusView.isHidden = false
                    }else{
    //                    let img = basicFunctions.getAssetThumbnail(asset: asset)
                        let img1 = self.cameraImageData.jpeg(.lowest)
                        print(img1)
    //                    let image1 = img1.jpeg(.lowest)
                        let dataDict = NSMutableDictionary()
                        dataDict.setObject("stories", forKey: "keyName" as NSCopying)
                        dataDict.setObject(img1 ?? Data(), forKey: "MyData" as NSCopying)
                        dataDict.setObject("png", forKey: "ext" as NSCopying)
                        Arr_Data.add(dataDict)
                        self.view.makeToast("Uploading image...")
                    }
//                }
//            }else{
            
//            }

        if Arr_Data.count > 5 {
            self.view.makeToast("only 5 items can upload at a time")
        }else{
            print(parameterDictionary)

            let  methodName = "post_stories"
           
            DataManager.getAPIResponseFileMultipleImageArray(parameterDictionary: parameterDictionary, methodName: methodName, DocimageArray: Arr_Data){ (responseData,error)-> Void in
                
                let status = DataManager.getVal(responseData?["status"]) as! String
                let message = DataManager.getVal(responseData?["message"]) as! String
                 
                if status == "1" {
                    self.cropingStatusView.isHidden = true
                    self.view.makeToast(message)
                    DispatchQueue.main.asyncAfter(deadline: .now()+1.0, execute: {
                        self.navigationController?.popViewController(animated: true)
                    })
                }
                else {
                    self.cropingStatusView.isHidden = false
                    self.view.makeToast(message)
                }
//                        basicFunctions.stopLoading()
            }

        }
        basicFunctions.stopLoading()
    //        print(arr_assets)
    //
    //
    //        let parameterDictionary = NSMutableDictionary()
    //     let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
    //       parameterDictionary.setValue("tribe123", forKey: "api_key")
    //        parameterDictionary.setValue(userID, forKey: "user_id")
    //        parameterDictionary.setValue("", forKey: "stories")
    //        parameterDictionary.setValue("file", forKey: "type")
    //        parameterDictionary.setValue("", forKey: "color_code")
    //        parameterDictionary.setValue("", forKey: "message")
    //       print(parameterDictionary)
    //        let methodName = "post_stories"
    //
    //        DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
    //            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
    //            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
    //
    //            if status == "1" {
    ////                self.wholikeList = DataManager.getVal(responseData?["data"]) as! NSMutableArray
    //                self.navigationControllero?.popViewController(animated: true)
    //            }
    //            else {
    ////                 self.view.makeToast(message)
    //            }
    //        }
           
       
    }
    @IBAction func shareImagegallryBtn(_ sender: Any) {
        
        if self.arr_assets.count == 0 {
            self.view.makeToast("Please select any Image/Video")
        }else{
            self.view.endEditing(true)
            basicFunctions.presentLoader()
            let parameterDictionary = NSMutableDictionary()
            let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
            parameterDictionary.setValue("tribe123", forKey: "api_key")
            parameterDictionary.setValue(userID, forKey: "user_id")
    //        parameterDictionary.setValue("", forKey: "stories")
            parameterDictionary.setValue("file", forKey: "type")
            parameterDictionary.setValue("", forKey: "color_code")
            parameterDictionary.setValue("", forKey: "message")
            parameterDictionary.setValue("ios", forKey: "mobile_type")
            let Arr_Data = NSMutableArray()
//            if self.videoData.count == 0 {
            
            for indexn in 0..<self.arr_assetsnew.count{
                let dict = self.arr_assetsnew[indexn]
                let restr = DataManager.getVal(dict["key1"]) as? String ?? ""
                if restr == "Videos" {
                    let videoDict = NSMutableDictionary()
                    videoDict.setObject("stories", forKey: "keyName" as NSCopying)
                    let img1 = DataManager.getVal(dict["img1"]) as? Data
                    videoDict.setObject(img1, forKey: "MyData" as NSCopying)
                    videoDict.setObject("mp4", forKey: "ext" as NSCopying)
                    Arr_Data.add(videoDict)
                    self.cropingStatusView.isHidden = false
                }
            }
            
            
                for index in 0..<self.arr_assets.count{
                    
                    let dict = self.arr_assets[index]
                   let restr = DataManager.getVal(dict["key1"]) as? String ?? ""
                    if restr == "Video" {
//                        let videoDict = NSMutableDictionary()
//                        videoDict.setObject("stories", forKey: "keyName" as NSCopying)
//                        videoDict.setObject(self.videoData, forKey: "MyData" as NSCopying)
//                        videoDict.setObject("mp4", forKey: "ext" as NSCopying)
//                        Arr_Data.add(videoDict)
//                        print(Arr_Data)
//                        print(self.videoData)
                        self.cropingStatusView.isHidden = false
                    }else{
                        let img = DataManager.getVal(dict["img"]) as? UIImage ?? UIImage()
                      
    //                    let img = basicFunctions.getAssetThumbnail(asset: asset)
                        let img1 = img.jpeg(.lowest)
    //                    let image1 = img1.jpeg(.lowest)
                        let dataDict = NSMutableDictionary()
                        dataDict.setObject("stories", forKey: "keyName" as NSCopying)
                        dataDict.setObject(img1 ?? Data(), forKey: "MyData" as NSCopying)
                        dataDict.setObject("png", forKey: "ext" as NSCopying)
                        Arr_Data.add(dataDict)
                        self.view.makeToast("Uploading image...")
                    }
                }
//            }else{
            
//            }
            if Arr_Data.count > 5 {
                self.view.makeToast("only 5 items can upload at a time")
            }else{
                print(parameterDictionary)

                let  methodName = "post_stories"
               
                DataManager.getAPIResponseFileMultipleImageArray(parameterDictionary: parameterDictionary, methodName: methodName, DocimageArray: Arr_Data){ (responseData,error)-> Void in
                    
                    let status = DataManager.getVal(responseData?["status"]) as! String
                    let message = DataManager.getVal(responseData?["message"]) as! String
                     
                    if status == "1" {
                        self.cropingStatusView.isHidden = true
                        self.view.makeToast(message)
                        DispatchQueue.main.asyncAfter(deadline: .now()+1.0, execute: {
                            self.navigationController?.popViewController(animated: true)
                        })
                    }
                    else {
                        self.view.makeToast(message)
                        self.cropingStatusView.isHidden = false
                    }
//                        basicFunctions.stopLoading()
                }
  
            }

            basicFunctions.stopLoading()
    //        print(arr_assets)
    //
    //
    //        let parameterDictionary = NSMutableDictionary()
    //     let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
    //       parameterDictionary.setValue("tribe123", forKey: "api_key")
    //        parameterDictionary.setValue(userID, forKey: "user_id")
    //        parameterDictionary.setValue("", forKey: "stories")
    //        parameterDictionary.setValue("file", forKey: "type")
    //        parameterDictionary.setValue("", forKey: "color_code")
    //        parameterDictionary.setValue("", forKey: "message")
    //       print(parameterDictionary)
    //        let methodName = "post_stories"
    //
    //        DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
    //            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
    //            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""
    //
    //            if status == "1" {
    ////                self.wholikeList = DataManager.getVal(responseData?["data"]) as! NSMutableArray
    //                self.navigationControllero?.popViewController(animated: true)
    //            }
    //            else {
    ////                 self.view.makeToast(message)
    //            }
    //        }
            
        }
       
    }
    @IBAction func AddImage(_ sender: Any) {
         let picker = AssetsPickerViewController()
         let config = AssetsPickerConfig()
         config.albumIsShowEmptyAlbum = false
         let options = PHFetchOptions()
     //    options.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
         options.sortDescriptors = [NSSortDescriptor(key: "duration", ascending: true)]

         config.assetFetchOptions = [
             .smartAlbum: options,
             .album: options
         ]

         picker.pickerConfig = config
         picker.pickerDelegate = self
         present(picker, animated: true, completion: nil)
    }
    
    @IBAction func addtextBtnAction(_ sender: Any) {
        self.ShareTextView.isHidden = false
        self.shareImageCameraView.isHidden = true
        self.shareImageGalleryView.isHidden = true
        actionButton.isHidden = true
        
    }
    
    @IBAction func addImageCameraBtnAction(_ sender: Any) {
        self.ShareTextView.isHidden = true
        self.shareImageCameraView.isHidden = false
        self.shareImageGalleryView.isHidden = true
        actionButton.isHidden = true
        openCamera()
    }
    
    @IBAction func addImagegalleryBtnAction(_ sender: Any) {
        self.ShareTextView.isHidden = true
        self.shareImageCameraView.isHidden = true
        self.shareImageGalleryView.isHidden = false
        actionButton.isHidden = false
        actionButton.display(inView: self.view, bottomInset: 170, trailingInset: 20, safeAreaInset: 20)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
//    func centerVertically() {
//        let fittingSize = CGSize(width: self.typeTextView.bounds.width, height: CGFloat.greatestFiniteMagnitude)
//           let size = sizeThatFits(fittingSize)
//        let topOffset = (self.typeTextView.bounds.size.height - size.height * zoomScale) / 2
//           let positiveTopOffset = max(1, topOffset)
//           contentOffset.y = -positiveTopOffset
//       }
    

    func getCurrentTimeStampWOMiliseconds(dateToConvert: NSDate) -> String {
        let objDateformat: DateFormatter = DateFormatter()
        objDateformat.dateFormat = "yyyy-MM-dd"
        let strTime: String = objDateformat.string(from: dateToConvert as Date)
        let objUTCDate: NSDate = objDateformat.date(from: strTime)! as NSDate
        let milliseconds: Int64 = Int64(objUTCDate.timeIntervalSince1970)
        let strTimeStamp: String = "\(milliseconds)"
        return strTimeStamp
    }
    func encodeVideo(_ videoURL: URL)  {

        let avAsset = AVURLAsset(url: videoURL, options: nil)

        let startDate = Foundation.Date()

        //Create Export session
        let exportSession = AVAssetExportSession(asset: avAsset, presetName: AVAssetExportPresetPassthrough)!

        // exportSession = AVAssetExportSession(asset: composition, presetName: mp4Quality)
        //Creating temp path to save the converted video


        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let myDocumentPath = URL(fileURLWithPath: documentsDirectory).appendingPathComponent("temp.mp4").absoluteString
        let url = URL(fileURLWithPath: myDocumentPath)

        let documentsDirectory2 = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] as URL

        let filePath = documentsDirectory2.appendingPathComponent("-\(Date().currentTimeMillis())-rendered-Video.mp4")
        deleteFile(filePath)

        //Check if the file already exists then remove the previous file
        if FileManager.default.fileExists(atPath: myDocumentPath) {
            do {
                try FileManager.default.removeItem(atPath: myDocumentPath)
            }
            catch let error {
                print(error)
            }
        }

//        exportSession.outputFileType = AVFileType.
        exportSession.outputURL = filePath
        exportSession.outputFileType = AVFileType.mp4
        exportSession.shouldOptimizeForNetworkUse = true
        let start = CMTimeMakeWithSeconds(0.0, preferredTimescale: 0)
        let range = CMTimeRangeMake(start: start, duration: avAsset.duration)
        exportSession.timeRange = range

        exportSession.exportAsynchronously(completionHandler: {() -> Void in
            switch exportSession.status {
            case .failed:
                print("%@",exportSession.error)
            case .cancelled:
                print("Export canceled")
            case .completed:
                //Video conversion finished
                let endDate = Foundation.Date()

                let time = endDate.timeIntervalSince(startDate)
                print(time)
                print("Successful!")
                print(exportSession.outputURL)
                self.mediaPath = exportSession.outputURL
                do{
                    var video = try Data(contentsOf: self.mediaPath as! URL)
                    self.cameraVideoData = video
                    print(video)
                    let asset = AVURLAsset(url: self.mediaPath, options: nil)
                            let imgGenerator = AVAssetImageGenerator(asset: asset)
                            imgGenerator.appliesPreferredTrackTransform = true
                    let cgImage = try! imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
                            let thumbnail = UIImage(cgImage: cgImage)
                    let imgdata = thumbnail.pngData()
    //                self.player = AVPlayer(url: videoURL as! URL)
    //               self.avpController = AVPlayerViewController()
    //               self.avpController.player = self.player
    //               avpController.view.frame.size.width =  self.cameraVideoView.frame.size.width
    //               avpController.view.frame.size.height =  self.cameraVideoView.frame.size.height
    //               self.addChild(avpController)
    //               self.cameraVideoView.addSubview(avpController.view)
    //                cameraImg.image = thumbnail
    //                if(player.timeControlStatus == AVPlayer.TimeControlStatus.playing) {
    //                       player.pause()
    //                   } else if(player.timeControlStatus == AVPlayer.TimeControlStatus.paused) {
    //                       player.play()
    //                   }
                    DispatchQueue.main.async {
                        self.ShareTextView.isHidden = true
                        self.shareImageCameraView.isHidden = true
                        self.shareImageGalleryView.isHidden = false
                        self.actionButton.isHidden = false
                        self.actionButton.display(inView: self.view, bottomInset: 170, trailingInset: 20, safeAreaInset: 20)
                        
                        let trimVC = self.storyboard?.instantiateViewController(withIdentifier: "TrimerViewController") as! TrimerViewController
                        trimVC.modalPresentationStyle = .fullScreen
                        trimVC.videoDetails = UploadVideoData(imageData: imgdata ?? Data(), videoURL: self.mediaPath, imageType: MimeTypes.jpeg, videoType: MimeTypes.mp4, title: "", description: "", countryName: "", isAnonymous: 0, myduration: "")
                        trimVC.comeFromCamera = "y"
                        trimVC.comeFromCameraVideoURL = self.mediaPath
                        trimVC.delegate = self
                        self.present(trimVC, animated: true, completion: nil)
                    }
                   
                }catch{
                    
                }
                
                //self.mediaPath = String(self.exportSession.outputURL!)
            // self.mediaPath = self.mediaPath.substringFromIndex(7)
            default:
                break
            }

        })
    }
    
    func deleteFile(_ filePath:URL) {
        guard FileManager.default.fileExists(atPath: filePath.path) else {
            return
        }
        do {
            try FileManager.default.removeItem(atPath: filePath.path)
        }catch{
            fatalError("Unable to delete file: \(error) : \(#function).")
        }
    }

}

extension AddStoryVC: AssetsPickerViewControllerDelegate {
    
    func assetsPickerCannotAccessPhotoLibrary(controller: AssetsPickerViewController) {}
    func assetsPickerDidCancel(controller: AssetsPickerViewController) {}
    func assetsPicker(controller: AssetsPickerViewController, didSelect asset: PHAsset, at indexPath: IndexPath) {}
    func assetsPicker(controller: AssetsPickerViewController, didDeselect asset: PHAsset, at indexPath: IndexPath) {}
    
    func assetsPicker(controller: AssetsPickerViewController, shouldDeselect asset: PHAsset, at indexPath: IndexPath) -> Bool {
        return true
    }
    
    func assetsPicker(controller: AssetsPickerViewController, shouldSelect asset: PHAsset, at indexPath: IndexPath) -> Bool {
        
            if controller.selectedAssets.count >= 5 {
                return false
            }else{
                return true
            }
        
    }
    
    func assetsPicker(controller: AssetsPickerViewController, selected assets: [PHAsset]) {
        for i in 0..<assets.count {
            let asset = assets[i]
            if asset.mediaType == .image {
                let img = AddStoryVC.getAssetThumbnail(asset: asset)
                let dict = ["key1":"image","img": img] as? [String : Any] ?? [:]
                arr_assets.append(dict)
            }else{
                videoarr_assets.append(asset)
            }
        }
//
//        arr_assets = assets
        print(arr_assets)
        print(videoarr_assets)
        imageGalleryCollectionView.reloadData()
    }
}


extension AddStoryVC: UIImagePickerControllerDelegate,UINavigationControllerDelegate {

     func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(picker.mediaTypes)
        
        if let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String {

            if mediaType  == "public.image" {
                print("Image Selected")
                self.imageAndVideo = "image"
                guard let image = info[.originalImage] as? UIImage else { return }
                            //Change aspect when not dummy image
                self.cameraImg.contentMode = .scaleAspectFill
                self.cameraImg.clipsToBounds = true
                self.cameraImg.image = image
                self.cameraImageData = image
                picker.dismiss(animated: true)
            }

            if mediaType == "public.movie" {
                print("Video Selected-----")
                self.imageAndVideo = "video"
                let videoURL = info[.mediaURL] as? NSURL
                    encodeVideo(videoURL! as URL)
//                    var video = try Data(contentsOf: self.mediaPath as! URL)
//
//                    self.cameraVideoData = video
//                    print(video)
//                self.cameraVideoUrl = videoURL.filePathURL

                picker.dismiss(animated: true)
            }
        }
    }
    
}



extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }

    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
}

extension UITextView {
    func centerVerticalText() {
        var topCorrect = (self.bounds.size.height - self.contentSize.height * self.zoomScale) / 2
        topCorrect = topCorrect < 0.0 ? 0.0 : topCorrect
        self.contentInset.top = topCorrect
    }
 }
extension Date {
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
