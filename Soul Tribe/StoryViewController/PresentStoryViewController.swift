//
//  PresentStoryViewController.swift
//  StoryDemo
//
//  Created by MAC-30 on 12/10/21.
//


import UIKit
import AVKit
import AVFoundation
import SGSegmentedProgressBarLibrary
import CoreMedia
import SDWebImage

class PresentStoryViewController: UIViewController,UIGestureRecognizerDelegate,SGSegmentedProgressBarDelegate,SGSegmentedProgressBarDataSource{
    
    var imageDemoArray = ["Sports","black.jpg","black.jpg","black.jpg","black.jpg","Art"
    ]

    
    var LableDemopArray = ["","In this process, we are going to the call above method In this process, we are going to the call above method","","SwiftUI’s VideoPlayer view lets us playback movies from any URL, local or remote","",""]
    
    var videoUrl = [Bundle.main.url(forResource: "small", withExtension: "mp4"),Bundle.main.url(forResource: "small", withExtension: "mp4"),Bundle.main.url(forResource: "small", withExtension: "mp4"),Bundle.main.url(forResource: "small1", withExtension: "mp4"),Bundle.main.url(forResource: "small2", withExtension: "mp4"),Bundle.main.url(forResource: "small1", withExtension: "mp4")]
    var comeUserID = String()
    var ImageArray = [UIImage]()
    var player = AVPlayer()
    var avpController = AVPlayerViewController()
    var playerLayer1: AVPlayerLayer!
    @IBOutlet weak var nextBtn: UIButton!
    var userName = String()
    @IBOutlet weak var image_view: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var name_lbl: UILabel!
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var Activity: UIActivityIndicatorView!
    
    @IBOutlet weak var optionView1: UIView!
    @IBOutlet weak var optionView1CornerRadius: UIView!
    @IBOutlet weak var deletePopUp_OK: UIButton!
    @IBOutlet weak var deletePopUp_Cancel: UIButton!
    @IBOutlet weak var threeDotMenuoptionBtn: UIButton!
    
    @IBOutlet weak var timeAgoLbl: UILabel!
    @IBOutlet weak var crossBtnRightConstant: NSLayoutConstraint!
    @IBOutlet weak var crossBtn: UIButton!
    
    var observer: NSKeyValueObservation?
    var getcount = Int()
    var segmentBar: SGSegmentedProgressBar?
    var isRed = false
    var progressBarTimer: Timer!
    var timeDuration = Int()
    var isRunning = false
    var snapsArray = NSMutableArray()
    var snaps_count:Int!
    var imageArrayn = NSMutableArray()
    var messageArray = NSMutableArray()
    var colourCodeArray = NSMutableArray()
    var backGroundColourCodeArray = NSMutableArray()
    var timeAgoArray = NSMutableArray()
    var comerFromTab = String()  // to hide three dot menu option from presentStoryViewController
    var Ty = ""
    var userIDNew = ""
    var imagenew =  ""
    var checkplay = "0"
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.segmentBar?.pause()
        self.player.pause()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        userImageView.contentMode = .scaleAspectFit
        if self.comerFromTab == "y" {
            threeDotMenuoptionBtn.isHidden = false
            self.crossBtn.isHidden = true
        }else{
            self.crossBtn.isHidden = false
            threeDotMenuoptionBtn.isHidden = true
            self.crossBtnRightConstant.constant = -35
        }
        
        observer = nil // not necessary but still
        observer = userImageView.observe(\.image, options: [.old, .new], changeHandler: { [weak self](imageView,_) in
                    
                guard let img = imageView.image else {
                    self?.segmentBar?.pause()
                    self?.Activity.startAnimating()
                    print("----------------not set imageView, do something with the image")
                    return
                }
            self?.segmentBar?.resume()
            self?.Activity.stopAnimating()
                print("--------------set on your imageView, do something with the image", img)
            })
        self.Activity.hidesWhenStopped = true
        deletePopUp_OK.layer.cornerRadius = 6
        deletePopUp_Cancel.layer.cornerRadius = 6
        deletePopUp_Cancel.layer.borderWidth = 0.5
        deletePopUp_Cancel.layer.borderColor = UIColor.lightGray.cgColor
        optionView1CornerRadius.layer.cornerRadius = 6
        getcount = 1
        self.snaps_count = 1
        self.timeDuration = 0
//        self.videoDemoArray = [url1,url2,url3]
        image_view.layer.cornerRadius = 32
       // self.name_lbl.text = userName
        
        self.textLbl.isHidden = true
 
        self.image_view.layer.cornerRadius  = self.image_view.frame.width/2
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        self.view.addGestureRecognizer(tapGestureRecognizer)
            
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        self.view.addGestureRecognizer(longPressRecognizer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.dismiss(_ :)), name: Notification.Name("dismiss"), object: nil)
    }
    
    deinit {

        observer = nil // 4.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if self.comeUserID == "" {
            let user_id = UserDefaults.standard.value(forKey: "user_id") as? String ?? ""
            getStoryAPI(userId: user_id)
        }else{
            getStoryAPI(userId: comeUserID)
        }
    }
    
//    func hexStringToUIColor (hex:String) -> UIColor {
//        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
//
//        if (cString.hasPrefix("#")) {
//            cString.remove(at: cString.startIndex)
//        }
//
//        if ((cString.count) != 6) {
//            return UIColor.gray
//        }
//
//        var rgbValue:UInt64 = 0
//        Scanner(string: cString).scanHexInt64(&rgbValue)
//
//        return UIColor(
//            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
//            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
//            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
//            alpha: CGFloat(1.0)
//        )
//    }
    
    func getStoryAPI(userId: String) {
//        self.getcount = 0
        
        self.Activity.startAnimating()
//        basicFunctions.presentLoader()
        let dict = NSMutableDictionary()
        if Ty == "1" {
            dict.setValue(userIDNew, forKey: "user_id")
        }else{
            dict.setValue(userId, forKey: "user_id")
        }
        dict.setValue(Config().api_key, forKey: "api_key")

        let methodName = "get_stories"

        DataManager.getAPIResponse(dict, methodName: methodName, methodType: "POST"){(responseData,error)-> Void in

            let status = DataManager.getVal(responseData?["status"]) as? String ?? ""
           // let message = DataManager.getVal(responseData?["message"]) as? String ?? ""

            if status == "1"{
                let user = DataManager.getVal(responseData?["data"]) as! NSDictionary
                let userdetail = user.value(forKey: "user") as! NSDictionary
                let image = userdetail.value(forKey: "profile_image") as? String ?? ""
                
                let urlStr = Config().baseImageUrl + image
                self.image_view.sd_setImage(with: URL(string: urlStr), completed: nil)
              //  Config().setimage(name: "https://tribe.devtechnosys.tech/storage/app/public/" + image! , image: self.image_view)
                self.name_lbl.text  = userdetail.value(forKey: "name") as? String
                self.snaps_count = user.value(forKey: "snaps_count") as? Int
                self.snapsArray = user.value(forKey: "snaps") as! NSMutableArray
                
                if self.snapsArray.count == 0 {
                    self.view.makeToast("Journey not Found")
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                        self.dismiss(animated: true, completion: nil)
                    })
                }else{
                    for i in 0..<self.snapsArray.count {
                        var dict = NSDictionary()
                        dict = self.snapsArray.object(at: i) as! NSDictionary
                        let image = dict.value(forKey: "images") as? String ?? ""
                        let message = dict.value(forKey: "message") as? String
                        let color_code = dict.value(forKey: "color_code") as? String
                        let timeago = dict.value(forKey: "time") as? String
                        self.timeAgoArray.add(timeago ?? "2 min ago")
                        let bgcolor_code = dict.value(forKey: "background_color_code") as? String
                        self.backGroundColourCodeArray.add(bgcolor_code ?? "#000000")
                        self.colourCodeArray.add(color_code ?? "#000000")
                        self.imageArrayn.add(Config().baseImageUrl + image)
                        self.messageArray.add(message ?? "")
                        if image.contains("bin") {
                            self.imagenew =  image.replacingOccurrences(of: "bin", with: "mp4")
                        }
                        let newimage =  "https://soultribenow.com/storage/app/public/" + self.imagenew
                        let imageurl = URL.init(string: newimage)
                        
                        if let data = try? Data(contentsOf: imageurl!)
                        {
                            let image: UIImage = UIImage(data: data)!
                            self.ImageArray.append(image)
                        }
                    }
                    let rect = CGRect(x: 5, y: self.textLbl.frame.origin.y, width: self.view.frame.size.width-10, height: 2)
                    self.segmentBar = SGSegmentedProgressBar(frame: rect, delegate: self, dataSource: self)
                    self.view.addSubview(self.segmentBar!)
                    self.segmentBar?.start()
                    self.userImageView.sd_setImage(with: URL(string: self.imageArrayn[0] as! String), completed: nil)
                    let image1 = self.imageArrayn[0]
                    if (image1 as AnyObject).contains("black.jpg") {
                        self.textLbl.isHidden = false
                        self.userImageView.isHidden = true
                        let message = self.messageArray[0] as? String
                        let colorcode = self.colourCodeArray[0] as? String
                        let bgColorCode = self.backGroundColourCodeArray[0] as? String ?? ""
                        self.textLbl.backgroundColor = self.hexStringToUIColor(hex: bgColorCode)
                        self.textLbl.text = message
                        self.textLbl.textColor = self.hexStringToUIColor(hex: colorcode!)
                        self.timeAgoLbl.text = self.timeAgoArray[0] as? String ?? ""
                    }else if (image1 as AnyObject).contains(".mp4") {
                        self.userImageView.isHidden = false
                        let videoURL = URL(string: self.imageArrayn[0] as? String ?? "")
                        if let thumbnailImage = self.getThumbnailImage(forUrl: videoURL!) {
                            self.userImageView.image = thumbnailImage
                           }
                        self.player = AVPlayer(url: videoURL!)
                        self.playerLayer1 = AVPlayerLayer(player: self.player)
                        self.playerLayer1?.frame = self.videoView.bounds
                        self.videoView.layer.addSublayer(self.playerLayer1)
                        self.player.play()
                        self.timeAgoLbl.text = self.timeAgoArray[0] as? String ?? ""
//                        self.playerLayer1.videoGravity = AVLayerVideoGravity.resizeAspectFill
                        let asset = AVURLAsset(url: videoURL!)
                        let duration: CMTime = asset.duration
                        let totalSeconds = CMTimeGetSeconds(duration)
                        self.timeDuration = Int(totalSeconds)
                        
                        self.player.addObserver(self, forKeyPath: "rate", options: NSKeyValueObservingOptions.new, context: nil)
                        self.player.addPeriodicTimeObserver(forInterval: CMTime(value: CMTimeValue(self.timeDuration), timescale: CMTimeScale(self.timeDuration)), queue: DispatchQueue.main) { [weak self] time in
                            self?.handlePlayerStatus(time: CMTime(value: CMTimeValue(self!.timeDuration), timescale: CMTimeScale(self!.timeDuration)))
                        }
                    }else{
                        self.userImageView.isHidden = false
                        self.textLbl.text = ""
                        self.textLbl.isHidden = true
                        self.timeAgoLbl.text = self.timeAgoArray[0] as? String ?? ""
                    }
                }
            }else{
                self.dismiss(animated: true, completion: nil)
            }
            self.Activity.stopAnimating()
            
//            basicFunctions.stopLoading()
        }
    }
    @objc func dismiss(_ pNotification: Notification) {
            
        self.dismiss(animated: true, completion: nil)
            
    }
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    @IBAction func crossBtnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deletePopUp_OKAction(_ sender: Any) {
        self.optionView1.removeFromSuperview()
        deleteStory()
    }
    @IBAction func deletePopUp_CancelAction(_ sender: Any) {
        self.optionView1.removeFromSuperview()
        self.segmentBar?.resume()
    }
    
    @objc func tapped(sender: UITapGestureRecognizer){
        print("tapped")
    }
    @objc func longPressed(sender: UILongPressGestureRecognizer)
    {
        print("longPress")
        if sender.state == .ended {
            self.segmentBar?.resume()
        }else{
//            sender.minimumPressDuration = 0.01
            self.segmentBar?.pause()
        }
    }
    @IBAction func disMisBtnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func beforeBtnAction(_ sender: Any) {
        self.segmentBar?.previousSegment()
//        userImageView.image = UIImage(named: imageDemoArray[self.segmentBar?.currentIndex ?? 0])
//        let image = imageArrayn[self.segmentBar?.currentIndex ?? 0]
//        if (image as AnyObject).contains("black.jpg") {
//            self.textLbl.isHidden = false
//            let message = messageArray[self.segmentBar?.currentIndex ?? 0] as? String
//            self.textLbl.text = message
//            let colorcode = self.colourCodeArray[self.segmentBar?.currentIndex ?? 0] as? String
//            self.textLbl.textColor = self.hexStringToUIColor(hex: colorcode!)
//        }else{
//            self.textLbl.text = ""
//            self.textLbl.isHidden = true
//        }
        self.player.pause()
     
        self.playerLayer1?.player = nil
        self.playerLayer1?.removeFromSuperlayer()
    
        self.videoView.isHidden = true
        self.userImageView.sd_setImage(with: URL(string: imageArrayn[self.segmentBar?.currentIndex ?? 0] as! String), completed: nil)
        self.timeAgoLbl.text = self.timeAgoArray[self.segmentBar?.currentIndex ?? 0] as? String ?? ""
        let image = imageArrayn[self.segmentBar?.currentIndex ?? 0]
        if (image as AnyObject).contains("black.jpg") {
            self.userImageView.isHidden = true
            self.timeDuration = 0
            self.playerLayer1?.player = nil
            self.playerLayer1?.removeFromSuperlayer()
            self.videoView.isHidden = true
            self.textLbl.isHidden = false
            let message = messageArray[self.segmentBar?.currentIndex ?? 0]
                let colorcode = self.colourCodeArray[self.segmentBar?.currentIndex ?? 0 + 1] as? String
                self.textLbl.textColor = self.hexStringToUIColor(hex: colorcode!)
            
            self.textLbl.text = message as! String
            let bgColorCode = self.backGroundColourCodeArray[self.segmentBar?.currentIndex ?? 0] as? String ?? ""
            self.textLbl.backgroundColor = self.hexStringToUIColor(hex: bgColorCode)
        }
        else if (image as AnyObject).contains(".HEIC") {
            self.userImageView.isHidden = false
            self.segmentBar?.pause()
//            self.Activity.startAnimating()
//            self.Activity.hidesWhenStopped = true
            self.videoView.isHidden = false
            self.textLbl.isHidden = true
//            let player = self.videoDemoArray[self.segmentBar?.currentIndex ?? 0]
//            if let url = self.videoUrl[self.segmentBar?.currentIndex ?? 0] {
//                    let asset = AVAsset(url: url)
//                    let duration = asset.duration
//                self.timeDuration = Int(CMTimeGetSeconds(duration))
//                    print(self.timeDuration)
//                }
//            playerLayer = AVPlayerLayer(player: player)
//            playerLayer!.frame = self.videoView.bounds
//            playerLayer!.videoGravity = .resizeAspect
//            self.videoView.layer.addSublayer(playerLayer!)
//            player.seek(to: .zero)
//            player.play()
            let videoURL = URL(string: self.imageArrayn[self.segmentBar?.currentIndex ?? 0] as? String ?? "")
            if let thumbnailImage = getThumbnailImage(forUrl: videoURL!) {
                self.userImageView.image = thumbnailImage
                }
            self.player = AVPlayer(url: videoURL!)
            let asset = AVURLAsset(url: videoURL!)
            let duration: CMTime = asset.duration
            let totalSeconds = CMTimeGetSeconds(duration)
            self.timeDuration = Int(totalSeconds)
            
            self.playerLayer1 = AVPlayerLayer(player: self.player)
            self.playerLayer1?.frame = self.videoView.bounds
            self.videoView.layer.addSublayer(self.playerLayer1)
            self.player.seek(to: .zero)
            self.player.play()
            
            self.player.addObserver(self, forKeyPath: "rate", options: NSKeyValueObservingOptions.new, context: nil)
            self.player.addPeriodicTimeObserver(forInterval: CMTime(value: CMTimeValue(self.timeDuration), timescale: CMTimeScale(self.timeDuration)), queue: DispatchQueue.main) { [weak self] time in
                self?.handlePlayerStatus(time: CMTime(value: CMTimeValue(self!.timeDuration), timescale: CMTimeScale(self!.timeDuration)))
            }
        }

        
        else if (image as AnyObject).contains(".mp4") {
            self.userImageView.isHidden = false
            self.segmentBar?.pause()
//            self.Activity.startAnimating()
//            self.Activity.hidesWhenStopped = true
            self.videoView.isHidden = false
            self.textLbl.isHidden = true
//            let player = self.videoDemoArray[self.segmentBar?.currentIndex ?? 0]
//            if let url = self.videoUrl[self.segmentBar?.currentIndex ?? 0] {
//                    let asset = AVAsset(url: url)
//                    let duration = asset.duration
//                self.timeDuration = Int(CMTimeGetSeconds(duration))
//                    print(self.timeDuration)
//                }
//            playerLayer = AVPlayerLayer(player: player)
//            playerLayer!.frame = self.videoView.bounds
//            playerLayer!.videoGravity = .resizeAspect
//            self.videoView.layer.addSublayer(playerLayer!)
//            player.seek(to: .zero)
//            player.play()
            let videoURL = URL(string: self.imageArrayn[self.segmentBar?.currentIndex ?? 0] as? String ?? "")
            if let thumbnailImage = getThumbnailImage(forUrl: videoURL!) {
                self.userImageView.image = thumbnailImage
                }
            self.player = AVPlayer(url: videoURL!)
            let asset = AVURLAsset(url: videoURL!)
            let duration: CMTime = asset.duration
            let totalSeconds = CMTimeGetSeconds(duration)
            self.timeDuration = Int(totalSeconds)
            
            self.playerLayer1 = AVPlayerLayer(player: self.player)
            self.playerLayer1?.frame = self.videoView.bounds
            self.videoView.layer.addSublayer(self.playerLayer1)
            self.player.seek(to: .zero)
            self.player.play()
            
            self.player.addObserver(self, forKeyPath: "rate", options: NSKeyValueObservingOptions.new, context: nil)
            self.player.addPeriodicTimeObserver(forInterval: CMTime(value: CMTimeValue(self.timeDuration), timescale: CMTimeScale(self.timeDuration)), queue: DispatchQueue.main) { [weak self] time in
                self?.handlePlayerStatus(time: CMTime(value: CMTimeValue(self!.timeDuration), timescale: CMTimeScale(self!.timeDuration)))
            }
        }
        else{
            self.userImageView.isHidden = false
            self.timeDuration = 0
            self.textLbl.text = ""
            self.textLbl.isHidden = true
            self.playerLayer1?.player = nil
            self.playerLayer1?.removeFromSuperlayer()
            self.videoView.isHidden = true
        }
    }
    
    
    func getThumbnailImage(forUrl url: URL) -> UIImage? {
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)

        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60), actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }

        return nil
    }
    func deleteStory() {
        let parameterDictionary = NSMutableDictionary()
     let userID = Config().AppUserDefaults.value(forKey:"user_id") as? String ?? ""
       parameterDictionary.setValue("tribe123", forKey: "api_key")
        parameterDictionary.setValue(userID, forKey: "user_id")
       print(parameterDictionary)
        let methodName = "delete_stories"

        DataManager.getAPIResponse(parameterDictionary , methodName: methodName, methodType: "POST"){ [self](responseData,error)-> Void in
            let status  = DataManager.getVal(responseData?["status"]) as? String ?? ""
            let message  = DataManager.getVal(responseData?["message"]) as? String ?? ""

            if status == "1" {
                if message == "Story deleted successfully" {
                    self.view.makeToast("Journey successfully deleted")
                }else{
                    self.view.makeToast(message)
                }
                DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
                    self.dismiss(animated: true, completion: nil)
                }
                self.segmentBar?.resume()
            }
            else {
                 self.view.makeToast(message)
            }
        }
    }
    
    @IBAction func DeletePopUp(_ sender: Any) {
        
        self.segmentBar?.pause()
        self.player.pause()
        
        self.checkplay = "1"
        let actionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { [self] action -> Void in
            segmentBar?.resume()
        }
        if self.comerFromTab == "y" {
            
        }
        let close = UIAlertAction(title: "Close", style: .default) { [self] action -> Void in
            self.dismiss(animated: true, completion: nil)
            self.checkplay = "0"
            self.segmentBar?.resume()
            self.player.play()
        }
        actionSheetController.addAction(cancelAction)
        let DeleteStory = UIAlertAction(title: "Delete", style: .default) { [self] action -> Void in
            self.optionView1.frame = self.view.frame
            self.optionView1.backgroundColor = UIColor.black.withAlphaComponent(0.1)
            self.view.addSubview(self.optionView1)
        }
        actionSheetController.addAction(DeleteStory)
        actionSheetController.addAction(close)
        self.present(actionSheetController, animated: true, completion: nil)
    }
    func handlePlayerStatus(time: CMTime) {
        if checkplay == "1" {
            self.segmentBar?.pause()
        }else{
            if self.player.status == .readyToPlay {
                self.userImageView.isHidden = true
                print("ready to play")
          }
            if self.player.currentTime().value != 0 {
                self.segmentBar?.resume()
                self.Activity.stopAnimating()
            }else{
                self.segmentBar?.pause()
                self.Activity.startAnimating()
            }
            if self.player.status == .failed || self.player.status == .unknown {
                print("failed/unknown")
            }
        }
        
    }
    @IBAction func nextBtnAction(_ sender: Any) {
        self.segmentBar?.nextSegment()
        
//        userImageView.image = UIImage(named: imageDemoArray[self.segmentBar?.currentIndex ?? 0])
//        let image = imageArrayn[self.segmentBar?.currentIndex ?? 0]
//        if (image as AnyObject).contains("black.jpg") {
//            self.textLbl.isHidden = false
//            let message = messageArray[self.segmentBar?.currentIndex ?? 0] as? String
//            let colorcode = self.colourCodeArray[self.segmentBar?.currentIndex ?? 0] as? String
//            self.textLbl.textColor = self.hexStringToUIColor(hex: colorcode!)
//            self.textLbl.text = message
//        }else{
//            self.textLbl.text = ""
//            self.textLbl.isHidden = true
//        }
        self.player.pause()
   
        self.playerLayer1?.player = nil
        self.playerLayer1?.removeFromSuperlayer()
        self.videoView.isHidden = true
//        segmentBar?.pause()
        self.userImageView.sd_setImage(with: URL(string: imageArrayn[self.segmentBar?.currentIndex ?? 0] as! String), completed: nil)
//        segmentBar?.resume()
        self.timeAgoLbl.text = self.timeAgoArray[self.segmentBar?.currentIndex ?? 0] as? String ?? ""
        let image = imageArrayn[self.segmentBar?.currentIndex ?? 0]
        if (image as AnyObject).contains("black.jpg") {
            self.userImageView.isHidden = true
            self.timeDuration = 0
            self.playerLayer1?.player = nil
            self.playerLayer1?.removeFromSuperlayer()
            self.videoView.isHidden = true
            self.textLbl.isHidden = false
            let message = messageArray[self.segmentBar?.currentIndex ?? 0]
            let colorcode = self.colourCodeArray[self.segmentBar?.currentIndex ?? 0 + 1] as? String
                self.textLbl.textColor = self.hexStringToUIColor(hex: colorcode!)
            self.textLbl.text = message as! String
            let bgColorCode = self.backGroundColourCodeArray[self.segmentBar?.currentIndex ?? 0] as? String ?? ""
            self.textLbl.backgroundColor = self.hexStringToUIColor(hex: bgColorCode)
        }
        else if (image as AnyObject).contains(".mp4") {
            self.userImageView.isHidden = false
            self.segmentBar?.pause()
            self.videoView.isHidden = false
            self.textLbl.isHidden = true

            let videoURL = URL(string: self.imageArrayn[self.segmentBar?.currentIndex ?? 0] as? String ?? "")
            if let thumbnailImage = getThumbnailImage(forUrl: videoURL!) {
                self.userImageView.image = thumbnailImage
               }
            self.player = AVPlayer(url: videoURL!)
            let asset = AVURLAsset(url: videoURL!)
            let duration: CMTime = asset.duration
            let totalSeconds = CMTimeGetSeconds(duration)
            self.timeDuration = Int(totalSeconds)
            
            self.playerLayer1 = AVPlayerLayer(player: self.player)
            self.playerLayer1?.frame = self.videoView.bounds
            self.videoView.layer.addSublayer(self.playerLayer1)
            self.player.seek(to: .zero)
            self.player.play()
            
            self.player.addObserver(self, forKeyPath: "rate", options: NSKeyValueObservingOptions.new, context: nil)
            self.player.addPeriodicTimeObserver(forInterval: CMTime(value: CMTimeValue(self.timeDuration), timescale: CMTimeScale(self.timeDuration)), queue: DispatchQueue.main) { [weak self] time in
                self?.handlePlayerStatus(time: CMTime(value: CMTimeValue(self!.timeDuration), timescale: CMTimeScale(self!.timeDuration)))
            }
        }else if (image as AnyObject).contains(".HEIC") {
            self.userImageView.isHidden = false
            self.segmentBar?.pause()
            self.videoView.isHidden = false
            self.textLbl.isHidden = true

            let videoURL = URL(string: self.imageArrayn[self.segmentBar?.currentIndex ?? 0] as? String ?? "")
            if let thumbnailImage = getThumbnailImage(forUrl: videoURL!) {
                self.userImageView.image = thumbnailImage
               }
            self.player = AVPlayer(url: videoURL!)
            let asset = AVURLAsset(url: videoURL!)
            let duration: CMTime = asset.duration
            let totalSeconds = CMTimeGetSeconds(duration)
            self.timeDuration = Int(totalSeconds)
            
            self.playerLayer1 = AVPlayerLayer(player: self.player)
            self.playerLayer1?.frame = self.videoView.bounds
            self.videoView.layer.addSublayer(self.playerLayer1)
            self.player.seek(to: .zero)
            self.player.play()
            
            self.player.addObserver(self, forKeyPath: "rate", options: NSKeyValueObservingOptions.new, context: nil)
            self.player.addPeriodicTimeObserver(forInterval: CMTime(value: CMTimeValue(self.timeDuration), timescale: CMTimeScale(self.timeDuration)), queue: DispatchQueue.main) { [weak self] time in
                self?.handlePlayerStatus(time: CMTime(value: CMTimeValue(self!.timeDuration), timescale: CMTimeScale(self!.timeDuration)))
            }
        }
        else{
            self.userImageView.isHidden = false
            self.timeDuration = 0
            self.textLbl.text = ""
            self.textLbl.isHidden = true
            self.playerLayer1?.player = nil
            self.playerLayer1?.removeFromSuperlayer()
            self.videoView.isHidden = true
        }
    }
    func getVideoDuration(from path: URL) -> String {
        let asset = AVURLAsset(url: path)
        let duration: CMTime = asset.duration
      
        let totalSeconds = CMTimeGetSeconds(duration)
//        let hours = Int(totalSeconds / 3600)
//        let minutes = Int((totalSeconds.truncatingRemainder(dividingBy: 3600)) / 60)
        let seconds = Int(totalSeconds.truncatingRemainder(dividingBy: 60))

//        if hours > 0 {
//            return String(seconds)
//        } else {
            return String(seconds)
//        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print("observer")
//        self.segmentBar?.pause()
//        self.Activity.startAnimating()
        if keyPath == "rate" {
            if self.player.rate == 0.1 {
                print("video at 0.1")
            }
        }
    }
    
    func segmentedProgressBarFinished(finishedIndex: Int, isLastIndex: Bool) {
        print("finish Index")
        if isLastIndex == true{
            self.timeDuration = 0
//            userImageView.image = UIImage(named: imageDemoArray[finishedIndex])
        }else{
            self.player.pause()
            self.playerLayer1?.player = nil
            self.playerLayer1?.removeFromSuperlayer()
            self.videoView.isHidden = true
            self.timeAgoLbl.text = self.timeAgoArray[finishedIndex + 1] as? String ?? ""
            self.userImageView.sd_setImage(with: URL(string: imageArrayn[finishedIndex + 1] as! String), completed: nil)
            let image = imageArrayn[finishedIndex + 1]
            if (image as AnyObject).contains("black.jpg") {
                let message = messageArray[finishedIndex + 1]
                let colorcode = self.colourCodeArray[finishedIndex + 1] as? String
                self.textLbl.textColor = self.hexStringToUIColor(hex: colorcode!)
                self.textLbl.text = message as! String
                let bgColorCode = self.backGroundColourCodeArray[finishedIndex + 1] as? String ?? ""
                self.textLbl.backgroundColor = self.hexStringToUIColor(hex: bgColorCode)
                self.userImageView.isHidden = true
                self.timeDuration = 0
                self.playerLayer1?.player = nil
                self.playerLayer1?.removeFromSuperlayer()
                self.videoView.isHidden = true
                self.textLbl.isHidden = false
            }
            else if (image as AnyObject).contains(".mp4") {
//                self.Activity.startAnimating()
//                let player = self.videoDemoArray[finishedIndex + 1]
//                if let url = self.videoUrl[finishedIndex + 1] {
//                        let asset = AVAsset(url: url)
//                        let duration = asset.duration
//                    self.timeDuration = Int(CMTimeGetSeconds(duration))
//                        print(self.timeDuration)
//                    }
//                playerLayer = AVPlayerLayer(player: player)
//                playerLayer!.frame = self.videoView.bounds
//                playerLayer!.videoGravity = .resizeAspect
//                self.videoView.layer.addSublayer(playerLayer!)
//                player.seek(to: .zero)
//                player.play()
                
                
                self.userImageView.isHidden = true
                self.segmentBar?.pause()
                self.videoView.isHidden = false
                self.textLbl.isHidden = true

                let videoURL = URL(string: self.imageArrayn[finishedIndex + 1] as? String ?? "")
                self.player = AVPlayer(url: videoURL!)
                let asset = AVURLAsset(url: videoURL!)
                let duration: CMTime = asset.duration
                let totalSeconds = CMTimeGetSeconds(duration)
                self.timeDuration = Int(totalSeconds)
                
                self.playerLayer1 = AVPlayerLayer(player: self.player)
                self.playerLayer1?.frame = self.videoView.bounds
                self.videoView.layer.addSublayer(self.playerLayer1)
                self.player.seek(to: .zero)
                self.player.play()
                
                self.player.addObserver(self, forKeyPath: "rate", options: NSKeyValueObservingOptions.new, context: nil)
                self.player.addPeriodicTimeObserver(forInterval: CMTime(value: CMTimeValue(self.timeDuration), timescale: CMTimeScale(self.timeDuration)), queue: DispatchQueue.main) { [weak self] time in
                    self?.handlePlayerStatus(time: CMTime(value: CMTimeValue(self!.timeDuration), timescale: CMTimeScale(self!.timeDuration)))
                }
                
                
                
//                let videoURL = URL(string: self.imageArrayn[finishedIndex + 1] as? String ?? "")
//                self.player = AVPlayer(url: videoURL!)
//
//                let asset = AVURLAsset(url: videoURL!)
//                let duration: CMTime = asset.duration
//                let totalSeconds = CMTimeGetSeconds(duration)
//                self.timeDuration = Int(totalSeconds)
//
//                self.playerLayer1 = AVPlayerLayer(player: self.player)
//                self.playerLayer1?.frame = self.view.bounds
//                self.view.layer.addSublayer(self.playerLayer1)
//                self.player.seek(to: .zero)
//                self.player.play()
//                self.userImageView.isHidden = true
//                self.videoView.isHidden = false
//                self.textLbl.isHidden = true
//
//                self.player.addObserver(self, forKeyPath: "rate", options: NSKeyValueObservingOptions.new, context: nil)
//                self.player.addPeriodicTimeObserver(forInterval: CMTime(value: CMTimeValue(self.timeDuration), timescale: CMTimeScale(self.timeDuration)), queue: DispatchQueue.main) { [weak self] time in
//                    self?.handlePlayerStatus(time: CMTime(value: CMTimeValue(self!.timeDuration), timescale: CMTimeScale(self!.timeDuration)))
//                }
                
            }else if (image as AnyObject).contains(".HEIC") {
                //                self.Activity.startAnimating()
                //                let player = self.videoDemoArray[finishedIndex + 1]
                //                if let url = self.videoUrl[finishedIndex + 1] {
                //                        let asset = AVAsset(url: url)
                //                        let duration = asset.duration
                //                    self.timeDuration = Int(CMTimeGetSeconds(duration))
                //                        print(self.timeDuration)
                //                    }
                //                playerLayer = AVPlayerLayer(player: player)
                //                playerLayer!.frame = self.videoView.bounds
                //                playerLayer!.videoGravity = .resizeAspect
                //                self.videoView.layer.addSublayer(playerLayer!)
                //                player.seek(to: .zero)
                //                player.play()
                                
                                
                                self.userImageView.isHidden = true
                                self.segmentBar?.pause()
                                self.videoView.isHidden = false
                                self.textLbl.isHidden = true

                                let videoURL = URL(string: self.imageArrayn[finishedIndex + 1] as? String ?? "")
                                self.player = AVPlayer(url: videoURL!)
                                let asset = AVURLAsset(url: videoURL!)
                                let duration: CMTime = asset.duration
                                let totalSeconds = CMTimeGetSeconds(duration)
                                self.timeDuration = Int(totalSeconds)
                                
                                self.playerLayer1 = AVPlayerLayer(player: self.player)
                                self.playerLayer1?.frame = self.videoView.bounds
                                self.videoView.layer.addSublayer(self.playerLayer1)
                                self.player.seek(to: .zero)
                                self.player.play()
                                
                                self.player.addObserver(self, forKeyPath: "rate", options: NSKeyValueObservingOptions.new, context: nil)
                                self.player.addPeriodicTimeObserver(forInterval: CMTime(value: CMTimeValue(self.timeDuration), timescale: CMTimeScale(self.timeDuration)), queue: DispatchQueue.main) { [weak self] time in
                                    self?.handlePlayerStatus(time: CMTime(value: CMTimeValue(self!.timeDuration), timescale: CMTimeScale(self!.timeDuration)))
                                }
                                
                                
                                
                //                let videoURL = URL(string: self.imageArrayn[finishedIndex + 1] as? String ?? "")
                //                self.player = AVPlayer(url: videoURL!)
                //
                //                let asset = AVURLAsset(url: videoURL!)
                //                let duration: CMTime = asset.duration
                //                let totalSeconds = CMTimeGetSeconds(duration)
                //                self.timeDuration = Int(totalSeconds)
                //
                //                self.playerLayer1 = AVPlayerLayer(player: self.player)
                //                self.playerLayer1?.frame = self.view.bounds
                //                self.view.layer.addSublayer(self.playerLayer1)
                //                self.player.seek(to: .zero)
                //                self.player.play()
                //                self.userImageView.isHidden = true
                //                self.videoView.isHidden = false
                //                self.textLbl.isHidden = true
                //
                //                self.player.addObserver(self, forKeyPath: "rate", options: NSKeyValueObservingOptions.new, context: nil)
                //                self.player.addPeriodicTimeObserver(forInterval: CMTime(value: CMTimeValue(self.timeDuration), timescale: CMTimeScale(self.timeDuration)), queue: DispatchQueue.main) { [weak self] time in
                //                    self?.handlePlayerStatus(time: CMTime(value: CMTimeValue(self!.timeDuration), timescale: CMTimeScale(self!.timeDuration)))
                //                }
                                
                            }
            else{
                self.userImageView.isHidden = false
                self.timeDuration = 0
                self.textLbl.text = ""
                self.textLbl.isHidden = true
                self.playerLayer1?.player = nil
                self.playerLayer1?.removeFromSuperlayer()
                self.videoView.isHidden = true
            }
        }
        if isLastIndex == true {
            self.dismiss(animated: true, completion: nil)
        }
    }
    var numberOfSegments: Int {
        return self.snaps_count
    }
    var segmentDuration: TimeInterval {
        if self.timeDuration != 0 {
            return TimeInterval(self.timeDuration)
        }else{
            return 3
        }
    }
    var paddingBetweenSegments: CGFloat {
        return 3
    }
    var trackColor: UIColor {
        return UIColor.darkGray
    }
    var progressColor: UIColor {
        return UIColor.white
    }
    var roundCornerType: SGCornerType {
        return .none
    }
}

