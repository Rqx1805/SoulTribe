//
//  CreatePostVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 29/06/21.
//

import UIKit
import AssetsPickerViewController
import Photos

protocol refereshApi{
    func refresh(data: String)
}

class CreatePostcell: UICollectionViewCell{
    
    @IBOutlet weak var btn_close: UIButton!
    @IBOutlet weak var img_disp: UIImageView!
}

class CreatePostVC: UIViewController {
    @IBAction func btn_backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_addPicturesAction(_ sender: UIButton) {
      
        if comesFrom == "Edit"{
            let picker = AssetsPickerViewController()
            let config = AssetsPickerConfig()
            config.albumIsShowEmptyAlbum = false
            if comesFrom != "Edit"{
                config.selectedAssets = self.arr_assets
            }else{
                
            }
            let options = PHFetchOptions()
            options.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
            options.sortDescriptors = [NSSortDescriptor(key: "duration", ascending: true)]

            config.assetFetchOptions = [
                .smartAlbum: options,
                .album: options
            ]
            picker.pickerConfig = config
            picker.pickerDelegate = self
            present(picker, animated: true, completion: nil)
        }else{
            let picker = AssetsPickerViewController()
            let config = AssetsPickerConfig()
            config.albumIsShowEmptyAlbum = false
            config.selectedAssets = self.arr_assets

            let options = PHFetchOptions()
            options.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
            options.sortDescriptors = [NSSortDescriptor(key: "duration", ascending: true)]

            config.assetFetchOptions = [
                .smartAlbum: options,
                .album: options
            ]

            picker.pickerConfig = config
            picker.pickerDelegate = self
            present(picker, animated: true, completion: nil)

        }
    }
    @IBAction func btn_postAction(_ sender: UIButton) {
     
        self.view.endEditing(true)

        if ValidationClass().ValidateCreateMiniTribePost(self){

            basicFunctions.presentLoader()

            let parameterDictionary = NSMutableDictionary()
            
            parameterDictionary.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
            parameterDictionary.setValue(Config().api_key, forKey: "api_key")
            parameterDictionary.setValue(self.miniTribeId, forKey: "mini_tribe_id")
            parameterDictionary.setValue(txt_perspective.text, forKey: "perspective")
           
            if comesFrom == "Edit"{
                parameterDictionary.setValue(miniTribePostId, forKey: "mini_tribe_post_id")
            }
            
            let arr_images = NSMutableArray()
            
            if comesFrom == "Edit"{
                for index in 0..<self.arr_editAsset.count{
                    let dict = arr_editAsset[index]
                    let id = DataManager.getVal(dict["gallery_id"]) as? String ?? ""
                   
                    if id == "abc_abhilasha"{
                        let str = DataManager.getVal(dict["name"]) as? String ?? ""
                        do {
                            let d = try Data(contentsOf: URL(string: str)!)
                            let img = UIImage(data: d)
                            let img2 = img?.fixedOrientation()
                            let img1 = img2?.jpeg(.lowest)
                            let dataDict = NSMutableDictionary()
                            
                            dataDict.setObject("mini_tribe_post_image", forKey: "keyName" as NSCopying)
                            dataDict.setObject(img1 ?? Data(), forKey: "MyData" as NSCopying)
                            dataDict.setObject("png", forKey: "ext" as NSCopying)
                            arr_images.add(dataDict)
                        }catch{
                            print(error)
                        }
                    }else{
//                        let str = DataManager.getVal(dict["images"]) as? String ?? ""
//                        do {
//                            let d = try Data(contentsOf: URL(string:  "\(Config().baseImageUrl)\(str)")!)
//                            let img = UIImage(data: d)
//
//                            let dataDict = NSMutableDictionary()
//
//                            dataDict.setObject("mini_tribe_post_image", forKey: "keyName" as NSCopying)
//                            dataDict.setObject(img?.pngData() ?? Data(), forKey: "MyData" as NSCopying)
//                            dataDict.setObject("png", forKey: "ext" as NSCopying)
//                            arr_images.add(dataDict)
//                        }catch{
//                            print(error)
//                        }
                    }
                }
            }else{
//                let arr_images = NSMutableArray()
                
                for index in 0..<self.arr_assets.count {
                    let asset = arr_assets[index]
                    let img = basicFunctions.getAssetThumbnail(asset: asset)
                    
                    let img2 = img.fixedOrientation()
                    let img1 = img2?.jpeg(.lowest)
                    let dataDict = NSMutableDictionary()
                    
                    dataDict.setObject("mini_tribe_post_image", forKey: "keyName" as NSCopying)
                    dataDict.setObject(img1 ?? Data(), forKey: "MyData" as NSCopying)
                    dataDict.setObject("png", forKey: "ext" as NSCopying)
                    arr_images.add(dataDict)
                }
            }
            
            print(parameterDictionary)
            var methodName = ""
            if comesFrom == "Edit"{
                methodName = "edit_mini_tribe_post"
            }else{
                methodName = "create_mini_tribe_post"
            }
            
            DataManager.getAPIResponseFileMultipleImageArray(parameterDictionary: parameterDictionary, methodName: methodName, DocimageArray: arr_images, success: { (responseData,error)-> Void in
                
                let status = DataManager.getVal(responseData?["status"]) as! String
                let message = DataManager.getVal(responseData?["message"]) as! String
                 
                if status == "1" {
                    self.view.makeToast(message)
                    DispatchQueue.main.asyncAfter(deadline: .now()+1.5, execute: {
                        self.delegate?.refresh(data: "y")
                        self.navigationController?.popViewController(animated: true)
                    })
                }
                else {
                    self.view.makeToast(message)
                }
                basicFunctions.stopLoading()
        })
        }
    }
    
    
    @IBOutlet weak var constraint_height_colVw: NSLayoutConstraint! //125
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var txt_perspective: UITextView!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var img_disp: UIImageView!
    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var btnpost: UIButton!
    
    var delegate: refereshApi?
    
    var userName = ""
    var user_Img = ""
    var arr_assets = [PHAsset]()
    
    var miniTribeId = ""
    
    var comesFrom = ""
    var perspective = ""
    var arr_editAsset = [[String:Any]] ()
    var editAssetCount = 0
    var miniTribePostId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        img_disp.transform = img_disp.transform.rotated(by: .pi / 2)
//        img_disp.contentMode = .scaleToFill
        
        btnpost.layer.cornerRadius = 6
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        
        let toolbarNew = UIToolbar()
                let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
                let doneButton = UIBarButtonItem(title: Bundle.main.localizedString(forKey: "Done", value: nil, table: "Localizable"), style: .done, target: self, action: #selector(NewDoneButtonTapped))
                      
                toolbarNew.setItems([flexSpace, doneButton], animated: true)
                toolbarNew.sizeToFit()
                toolbarNew.isTranslucent = false
                toolbarNew.barStyle = .default
                toolbarNew.tintColor = Config().AppThemeMainColor
              
        txt_perspective.inputAccessoryView = toolbarNew
        
        constraint_height_colVw.constant = 0
        
        img_disp.layer.cornerRadius = img_disp.frame.size.width/2
        img_disp.sd_setImage(with: URL(string: "\(Config().baseImageUrl)\(user_Img)"), completed: nil)
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ImageClicked(_:)))
             img_disp.isUserInteractionEnabled = true
             img_disp.addGestureRecognizer(tap)
            
        lbl_name.text = userName
        
        txt_perspective.delegate = self
        
        if comesFrom == "Edit"{
            if perspective != "" {
                txt_perspective.textColor = UIColor.black
                txt_perspective.text = perspective
            }else{
                txt_perspective.textColor = UIColor.lightGray
                txt_perspective.text = "Share Your Perspective..."
            }
        
            self.editAssetCount = self.arr_editAsset.count
            
            if self.editAssetCount > 0 {
                constraint_height_colVw.constant = 400
            }
            else {
                constraint_height_colVw.constant = 0
            }
            
            self.collectionView.reloadData()
            
        }else{
            txt_perspective.textColor = UIColor.lightGray
            txt_perspective.text = "Share Your Perspective..."
        }
    }
    @objc func NewDoneButtonTapped() {
            self.view.endEditing(true)
        }
    @objc func ImageClicked(_ sender : UIImageView) {
               let vc = self.storyboard?.instantiateViewController(withIdentifier: "ExpandedImageViewController") as! ExpandedImageViewController
        vc.shouldPrefix = true
               vc.urlStr = user_Img
               self.navigationController?.pushViewController(vc, animated: true)
           }
}

extension CreatePostVC : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        if comesFrom == ""{
            return arr_assets.count
        }else{
            return arr_editAsset.count
        }
       
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CreatePostcell
        cell.img_disp.layer.cornerRadius = 6
        
        
        if comesFrom == "Edit" {
            
            let dict = arr_editAsset[indexPath.row]
                
            let addUrl = DataManager.getVal(dict["images"]) as? String ?? ""
            var strUrl = ""
            
            if addUrl != "" {
                strUrl = "\(Config().baseImageUrl)\(addUrl)"
            }else{
                strUrl = DataManager.getVal(dict["name"]) as? String ?? ""
            }
         
            do {
                let d = try Data(contentsOf: URL(string: strUrl)!)
                    cell.img_disp.image = UIImage(data: d)
            }catch{
                print(error)
            }
                
        }
        else {
            let asset = arr_assets[indexPath.row]
            let img = basicFunctions.getAssetThumbnail(asset: asset)
            cell.img_disp.image = img
         
    //        cell.brncross.isHidden = false
        }
    
        cell.btn_close.tag = indexPath.row
        cell.btn_close.addTarget(self, action: #selector(deleteAsset(_:)), for: .touchUpInside)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width/2 - 25, height: UIScreen.main.bounds.size.width/2 - 25)
    }

    @objc func deleteAsset(_ sender : UIButton){
       
        if comesFrom == "Edit" {
            if sender.tag < editAssetCount{
                let deleteAlert = UIAlertController(title: "Delete", message: "Are you sure you want to delete this image?", preferredStyle: UIAlertController.Style.alert)

                deleteAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                    let dict = self.arr_editAsset[sender.tag]
                    let id = DataManager.getVal(dict["id"]) as? String ?? ""
                    self.api_deleteImage(val: id, indexForArray: sender.tag)
                    print("deleteFromWeb")
                }))

                deleteAlert.addAction(UIAlertAction(title: Bundle.main.localizedString(forKey: "Cancel", value: nil, table: "Localizable"), style: .cancel, handler: { (action: UIAlertAction!) in
                }))
                self.present(deleteAlert, animated: true, completion: nil)
                
            }else{
                self.arr_editAsset.remove(at: sender.tag)
                
                if arr_editAsset.count > 0 {
                    constraint_height_colVw.constant = 400
                }
                else {
                    constraint_height_colVw.constant = 0
                }
                
                self.collectionView.reloadData()
                print("deleteFromAssetsGallery")
            }
        }else{
            
            self.arr_assets.remove(at: sender.tag)
            if arr_assets.count > 0 {
                constraint_height_colVw.constant = 400
            }
            else {
                constraint_height_colVw.constant = 0
            }
            self.collectionView.reloadData()
        }
    }
    
    @objc func api_deleteImage(val: String, indexForArray : Int){
        self.view.endEditing(true)
            
        basicFunctions.presentLoader()

        let parameterDictionary = NSMutableDictionary()
        parameterDictionary.setValue(Config().AppUserDefaults.value(forKey:"user_id") as? String ?? "", forKey: "user_id")
        parameterDictionary.setValue(Config().api_key, forKey: "api_key")
        parameterDictionary.setValue(miniTribePostId, forKey: "mini_tribe_post_id")
        parameterDictionary.setValue(val, forKey: "mini_tribe_post_image_id")
        print(parameterDictionary)

        let methodName = "delete_mini_tribe_post_image"
        
        DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){(responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""

            if status == "1" {
                self.arr_editAsset.remove(at: indexForArray)
                self.editAssetCount -= 1
                self.view.makeToast(message)
                if self.arr_editAsset.count > 0 {
                    self.constraint_height_colVw.constant = 400
                }
                else {
                    self.constraint_height_colVw.constant = 0
                }
               
                self.collectionView.reloadData()
            }
            else {
                self.view.makeToast(message)
            }
            basicFunctions.stopLoading()
        }
    }
}

extension CreatePostVC: AssetsPickerViewControllerDelegate {
    
    func assetsPickerCannotAccessPhotoLibrary(controller: AssetsPickerViewController) {}
    func assetsPickerDidCancel(controller: AssetsPickerViewController) {}
    func assetsPicker(controller: AssetsPickerViewController, didSelect asset: PHAsset, at indexPath: IndexPath) {}
    func assetsPicker(controller: AssetsPickerViewController, didDeselect asset: PHAsset, at indexPath: IndexPath) {}
    
    func assetsPicker(controller: AssetsPickerViewController, shouldDeselect asset: PHAsset, at indexPath: IndexPath) -> Bool {
        return true
    }
    
    func assetsPicker(controller: AssetsPickerViewController, shouldSelect asset: PHAsset, at indexPath: IndexPath) -> Bool {
       
        if comesFrom == "Edit" {
            let totalAssets = self.arr_editAsset.count + controller.selectedAssets.count
            if totalAssets >= 5 {
                return false
            }else {
                return true
            }
        } else{
            if controller.selectedAssets.count >= 5 {
                return false
            } else {
                return true
            }
        }
    }
    
    func assetsPicker(controller: AssetsPickerViewController, selected assets: [PHAsset]) {
      
        if comesFrom == "Edit"{
            for i in 0..<assets.count {
                
                let options: PHContentEditingInputRequestOptions = PHContentEditingInputRequestOptions()
                    options.canHandleAdjustmentData = {(adjustmeta: PHAdjustmentData) -> Bool in
                        return true
                    }
                assets[i].requestContentEditingInput(with: options, completionHandler: { (contentEditingInput, info) in
                   
                    let urlStr = contentEditingInput!.fullSizeImageURL?.absoluteString
                    let dict = ["name" :"\(urlStr ?? "")","gallery_id":"abc_abhilasha"]
                    self.arr_editAsset.append(dict)
                    
                    if self.arr_editAsset.count > 0 {
                        self.constraint_height_colVw.constant = 400
                    }
                    else {
                        self.constraint_height_colVw.constant = 0
                    }
                    self.collectionView.reloadData()
                })
            }
        }else{
            
            arr_assets = assets
                if arr_assets.count > 0 {
                    constraint_height_colVw.constant = 400
                }
                else {
                    constraint_height_colVw.constant = 0
                }
            collectionView.reloadData()
        }
    }
}


extension CreatePostVC : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text == "" {
            textView.text = "Share Your Perspective..."
            textView.textColor = UIColor.lightGray
        }
    }
}
//extension UIImage {
//    enum JPEGQuality: CGFloat {
//        case lowest  = 0
//        case low     = 0.25
//        case medium  = 0.5
//        case high    = 0.75
//        case highest = 1
//    }
//
//    /// Returns the data for the specified image in JPEG format.
//    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
//    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
//    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
//        return jpegData(compressionQuality: jpegQuality.rawValue)
//    }
//}
extension UIImage {
    /// Fix image orientaton to protrait up
  
    func fixedOrientation() -> UIImage? {
        guard imageOrientation != UIImage.Orientation.up else {
            // This is default orientation, don't need to do anything
            return self.copy() as? UIImage
        }

        guard let cgImage = self.cgImage else {
            // CGImage is not available
            return nil
        }

        guard let colorSpace = cgImage.colorSpace, let ctx = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: cgImage.bitsPerComponent, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else {
            return nil // Not able to create CGContext
        }

        var transform: CGAffineTransform = CGAffineTransform.identity

        switch imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: CGFloat.pi)
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.rotated(by: CGFloat.pi / 2.0)
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: size.height)
            transform = transform.rotated(by: CGFloat.pi / -2.0)
        case .up, .upMirrored:
            break
        @unknown default:
            fatalError("Missing...")
            break
        }

        // Flip image one more time if needed to, this is to prevent flipped image
        switch imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .up, .down, .left, .right:
            break
        @unknown default:
            fatalError("Missing...")
            break
        }

        ctx.concatenate(transform)

        switch imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.height, height: size.width))
        default:
            ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            break
        }

        guard let newCGImage = ctx.makeImage() else { return nil }
        return UIImage.init(cgImage: newCGImage, scale: 1, orientation: .up)
    }
}

  

