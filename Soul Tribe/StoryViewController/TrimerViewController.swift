//
//  TrimerViewController.swift
//  TuVozNow
//
//  Created by mac-14 on 30/04/20.
//  Copyright © 2020 zokoo. All rights reserved.
//

import UIKit
import PryntTrimmerView
import AVFoundation
import Photos
import AVKit

protocol SendVideoDataDelegate {
    func videoData(data: Data)
}

class TrimerViewController: UIViewController {
    //MARK: Variables
    var delegate: SendVideoDataDelegate?
    var videoDetails: UploadVideoData?
    var player: AVPlayer?
    var playbackTimeCheckerTimer: Timer?
    var trimmerPositionChangedTimer: Timer?
    var Asset : AVAsset?
    var videoURL: URL?
    var cropedVideoData = Data()
    var asset: PHAsset?
    var comeFromCamera = String()
    var comeFromCameraVideoURL: URL?
    
    var playerTotelTime = Int()
    var playerStartingTime = Int()
    var playerEndingTime = Int()
    var player1 = AVPlayer()
    var playWithTrimed = false
    //MARK:- Outlets
    @IBOutlet weak var trimmerView: TrimmerView!
    @IBOutlet weak var VideoView: UIView!
    @IBOutlet weak var cropingStatusView: UIView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeLabelLeadingConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.playWithTrimed = false
        continueButton.layer.cornerRadius = 6
        trimmerView.delegate = self
        
        if self.comeFromCamera == "y" {
            self.videoURL = comeFromCameraVideoURL
            self.videoDetails?.videoURL = comeFromCameraVideoURL!
        }
        if let newAsset = self.asset{
            self.getURL(asset: newAsset) { url in
                self.videoURL = url
                self.videoDetails?.videoURL = url
            }
        }
        
        self.cropingStatusView.isHidden = true
        continueButton.setTitle("Continue", for: .normal)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController?.tabBar.isHidden = true
        timeLabel.layer.cornerRadius = 5
        timeLabel.layer.masksToBounds = true
        HideViews()
        DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
            guard let videoURL = self.videoURL else{
                return
            }
            print("Video URL: \(videoURL)")
            self.Asset = AVAsset(url: videoURL)
            self.trimmerView.maxDuration = self.Asset?.duration.seconds ?? 15
            self.trimmerView.asset = self.Asset
            self.trimmerView.delegate = self
            self.addVideoPlayer(with: self.Asset!, playerView: self.VideoView)
            self.ShowViews()
        }
    }
    @IBAction func playTrimedVideo(_ sender: Any) {
       
        self.player1 = AVPlayer(url: self.videoURL!)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = self.player1
        if self.playWithTrimed == true {
            self.player1.seek(to: CMTime(seconds: Double(self.playerStartingTime), preferredTimescale: 1))
            print(Int(self.trimmerView.endTime!.seconds) + Int(self.trimmerView.startTime!.seconds))
            self.player1.addObserver(self, forKeyPath: "rate", options: NSKeyValueObservingOptions.new, context: nil)
            self.player1.addPeriodicTimeObserver(forInterval: CMTime(value: CMTimeValue(self.playerTotelTime), timescale: CMTimeScale(self.playerTotelTime)), queue: DispatchQueue.main) { [weak self] time in
                self?.handlePlayerStatus(time: CMTime(value: CMTimeValue(self!.playerTotelTime), timescale: CMTimeScale(self!.playerTotelTime)))
         }
        }
            present(playerViewController, animated: true, completion: {
                playerViewController.player!.play()
            })
    }
    func handlePlayerStatus(time: CMTime) {
        
        if self.player1.status == .readyToPlay {
            print("ready to play")
      }
        print(self.player1.currentTime().second)
        print(self.player1.currentTime().value)
        if self.player1.currentTime().second == self.playerEndingTime {
            self.player1.pause()
        }else{
        }
        if self.player1.status == .failed || self.player1.status == .unknown {
            print("failed/unknown")
        }
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print("observer")
        if keyPath == "rate" {
            if self.player1.rate == 0.1 {
                print("video at 0.1")
            }
        }
    }
    @IBAction func backBtnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
//        NotificationCenter.default.post(name: NSNotification.Name("CloseView"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.tabBarController?.tabBar.isHidden = false
        }
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
    }
    //MARK: Functions
    
 
    
    func HideViews()  {
        VideoView.isHidden = true
        trimmerView.isHidden = true
        timeLabel.isHidden = true
        continueButton.isHidden = true
    }
    
    func ShowViews()  {
        VideoView.isHidden = false
        trimmerView.isHidden = false
        timeLabel.isHidden = false
        continueButton.isHidden = false
    }
    func startPlaybackTimeChecker() {
        stopPlaybackTimeChecker()
        playbackTimeCheckerTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self,
                                                        selector:
            #selector(self.onPlaybackTimeChecker), userInfo: nil, repeats: true)
    }
    
    func stopPlaybackTimeChecker() {
        playbackTimeCheckerTimer?.invalidate()
        playbackTimeCheckerTimer = nil
    }
    
    func ChangeTimeLablePostion(x: CGFloat) {
        let padding: CGFloat = 10
        let lblWidth = timeLabel.frame.size.width
        let minX = VideoView.frame.origin.x + lblWidth/2
        let maxX = (VideoView.frame.width) - lblWidth/2
        let newX = x + padding
        if newX < minX{
            self.timeLabelLeadingConstraint.constant = VideoView.frame.origin.x - padding
        }else if newX > maxX{
            self.timeLabelLeadingConstraint.constant = maxX - lblWidth/2
            
        }else{
            self.timeLabelLeadingConstraint.constant = newX - lblWidth/2 - padding
        }
    }
    func getURL(asset: PHAsset, completion: @escaping (URL) -> () ) {
        PHImageManager.default().requestAVAsset(forVideo: asset, options: nil) { (avAsset, b, c) in
            if let urlAsset = avAsset as? AVURLAsset {
                completion(urlAsset.url)
            }
        }
    }
    //mark:- button action
    
    @IBAction func continueButtonAction(_ sender: Any) {
        let time = Int(self.trimmerView.endTime!.seconds) - Int(self.trimmerView.startTime!.seconds)
        if time > 30 {
            self.view.makeToast("Video should be less then 30 sec")
        }else{
            let startTime = Float(trimmerView.startTime?.seconds ?? 0.0)
            let endTime = Float(trimmerView.endTime?.seconds ?? 0.0)
            let myurl =  urlOfCurrentlyPlayingInPlayer(player: player!)
            cropVideo(sourceURL1: myurl!, statTime: startTime, endTime: endTime)
            self.getThumbnailImageFromVideoUrl(url: myurl!) { (thumbImage) in
                print(thumbImage)
                NotificationCenter.default.post(name: NSNotification.Name("addVideoImage"), object: nil,userInfo: ["data":thumbImage!])
            }
        }
    }
    private func addVideoPlayer(with asset: AVAsset, playerView: UIView) {
        let playerItem = AVPlayerItem(asset: asset)
        player = AVPlayer(playerItem: playerItem)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.itemDidFinishPlaying(_:)),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
        let layer: AVPlayerLayer = AVPlayerLayer(player: player)
        layer.backgroundColor = UIColor.white.cgColor
        layer.frame = CGRect(x: 0, y: 0, width: playerView.frame.width, height: playerView.frame.height)
        layer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        playerView.layer.sublayers?.forEach({$0.removeFromSuperlayer()})
        playerView.layer.addSublayer(layer)
    }
    @objc func itemDidFinishPlaying(_ notification: Notification) {
        if let startTime = trimmerView.startTime {
            player?.seek(to: startTime)
        }
    }
    
    @objc func onPlaybackTimeChecker() {
        
        guard let startTime = trimmerView.startTime, let endTime = trimmerView.endTime, let player = player else {
            return
        }
        let playBackTime = player.currentTime()
        trimmerView.seek(to: playBackTime)
        
        if playBackTime >= endTime {
            player.seek(to: startTime, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
            trimmerView.seek(to: startTime)
        }
    }
    ///It will return Thumbnail UIImage
    func getThumbnailImageFromVideoUrl(url: URL, completion: @escaping ((_ image: UIImage?)->Void)) {
        DispatchQueue.global().async { //1
            let asset = AVAsset(url: url) //2
            let avAssetImageGenerator = AVAssetImageGenerator(asset: asset) //3
            avAssetImageGenerator.appliesPreferredTrackTransform = true //4
            let thumnailTime = CMTimeMake(value: 2, timescale: 1) //5
            do {
                let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumnailTime, actualTime: nil) //6
                let thumbImage = UIImage(cgImage: cgThumbImage) //7
                DispatchQueue.main.async { //8
                    completion(thumbImage) //9
                }
            } catch {
                print(error.localizedDescription) //10
                DispatchQueue.main.async {
                    completion(nil) //11
                }
            }
        }
    }
    func getThumbnailImageData(url: URL) -> Data {
        var imageData = Data()
        getThumbnailImageFromVideoUrl(url: url) { image in
            imageData = image?.pngData() ?? Data()
        }
        return imageData
    }
    func urlOfCurrentlyPlayingInPlayer(player : AVPlayer) -> URL? {
        return ((player.currentItem?.asset) as? AVURLAsset)?.url
    }
//    func cropVideo(sourceURL1: URL, statTime:Float, endTime:Float) -> URL
//    {
//       // ShowLoaderWithMessage(message: "Trimming...")
//        let fileManager = FileManager.default
//        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
//
//        let asset = AVAsset(url: sourceURL1)
//        let _ = Float(asset.duration.value) / Float(asset.duration.timescale)
//        var outputURL = documentDirectory.appendingPathComponent("output")
//        do {
//            try fileManager.createDirectory(at: outputURL, withIntermediateDirectories: true, attributes: nil)
//            outputURL = outputURL.appendingPathComponent("\(sourceURL1.lastPathComponent)02.MP4")
//        }catch let error {
//            print(error)
//        }
//
//        //Remove existing file
//        try? fileManager.removeItem(at: outputURL)
//
//        guard let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetHighestQuality) else { return URL(string: "")!}
//        exportSession.outputURL = outputURL
//        exportSession.outputFileType = .mp4
//
//        let timeRange = CMTimeRange(start: CMTime(seconds: Double(statTime), preferredTimescale: 1000),
//                                    end: CMTime(seconds: Double(endTime), preferredTimescale: 1000))
//
//        exportSession.timeRange = timeRange
//        exportSession.exportAsynchronously {
//            switch exportSession.status {
//            case .completed:
//                do {
//                    self.cropedVideoData = try Data(contentsOf: outputURL)
//                    DispatchQueue.main.async {
//
//                    }
//                } catch  {
//
//                }
//            case .failed:
//
//                print("failed \(exportSession.error.debugDescription)")
//            case .cancelled:
//
//                print("cancelled \(exportSession.error.debugDescription)")
//            default:
//
//                break
//            }
//        }
//        return outputURL
//    }
    
    func cropVideo(sourceURL1: URL, statTime:Float, endTime:Float)
  {
      self.cropingStatusView.isHidden = false
      let manager = FileManager.default

      guard let documentDirectory = try? manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) else {return}
      let mediaType = "mp4"
//      if mediaType == kUTTypeMovie as String || mediaType == "mp4" as String {
          let asset = AVAsset(url: sourceURL1 as URL)
      
          let length = Float(asset.duration.value) / Float(asset.duration.timescale)
          print("video length: \(length) seconds")

          let start = statTime
          let end = endTime
          let ddd = end - start
          print(ddd)
          UserDefaults.standard.setValue(Int(ddd), forKey: "videoTime")
          var outputURL = documentDirectory.appendingPathComponent("output")
          do {
              try manager.createDirectory(at: outputURL, withIntermediateDirectories: true, attributes: nil)
              outputURL = outputURL.appendingPathComponent("\(UUID().uuidString).\(mediaType)")
             
          }catch let error {
              print(error)
          }

          //Remove existing file
          _ = try? manager.removeItem(at: outputURL)

          guard let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetHighestQuality) else {return}
          exportSession.outputURL = outputURL
          exportSession.outputFileType = .mp4

          let startTime = CMTime(seconds: Double(start ), preferredTimescale: 1000)
          let endTime = CMTime(seconds: Double(end ), preferredTimescale: 1000)
          let timeRange = CMTimeRange(start: startTime, end: endTime)

          exportSession.timeRange = timeRange
          exportSession.exportAsynchronously{
              switch exportSession.status {
              case .completed:
                  defer {
                  }
                  print("exported at \(outputURL)")
                  self.encodeVideo(at: outputURL) { url, error in
                      guard let url = url else{return}
                      print(url)
                      DispatchQueue.main.async {
                          let data1 = try? Data(contentsOf: url)
                          print(data1)
                          self.delegate?.videoData(data: data1 ?? Data())
                          self.presentedViewController?.presentedViewController?.dismiss(animated: true)
          //                      self.dismiss(animated: true, completion: nil)
                          NotificationCenter.default.post(name: NSNotification.Name("dismissView"), object: nil)
                      }
                  }
                   
                  DispatchQueue.main.async {
                      let compres = self.compressVideo(videoURL: outputURL)
//                      let data1 = try? Data(contentsOf: compres)
                      
//                      print(data1)
                      self.cropingStatusView.isHidden = true
                    
//                      print(data1)
                      
                  }
                  
              case .failed:
                  print("failed \(exportSession.error)")

              case .cancelled:
                  print("cancelled \(exportSession.error)")

              default: break
              }
              
          }
      
  }
    
    func compressVideo(videoURL: URL) -> URL {
            let data = NSData(contentsOf: videoURL as URL)!
            print("File size before compression: \(Double(data.length / 1048576)) mb")
            let compressedURL = NSURL.fileURL(withPath: NSTemporaryDirectory() + NSUUID().uuidString + ".mov")
            compressVideoHelperMethod(inputURL: videoURL , outputURL: compressedURL) { (exportSession) in
            }
            return compressedURL
        }
    
    func compressVideoHelperMethod(inputURL: URL, outputURL: URL, handler:@escaping (_ exportSession: AVAssetExportSession?)-> Void) {
            let urlAsset = AVURLAsset(url: inputURL, options: nil)
            guard let exportSession = AVAssetExportSession(asset: urlAsset, presetName: AVAssetExportPresetMediumQuality) else {
                handler(nil)
                return
            }
            exportSession.outputURL = outputURL
        exportSession.outputFileType = AVFileType.mp4
            exportSession.shouldOptimizeForNetworkUse = true
            exportSession.exportAsynchronously { () -> Void in
                handler(exportSession)
            }
        }
    func getCurrentTimeStampWOMiliseconds(dateToConvert: NSDate) -> String {
        let objDateformat: DateFormatter = DateFormatter()
        objDateformat.dateFormat = "yyyy-MM-dd"
        let strTime: String = objDateformat.string(from: dateToConvert as Date)
        let objUTCDate: NSDate = objDateformat.date(from: strTime)! as NSDate
        let milliseconds: Int64 = Int64(objUTCDate.timeIntervalSince1970)
        let strTimeStamp: String = "\(milliseconds)"
        return strTimeStamp
    }
    func encodeVideo(at videoURL: URL, completionHandler: ((URL?, Error?) -> Void)?)  {
        let avAsset = AVURLAsset(url: videoURL, options: nil)
            
        let startDate = Date()
            
        //Create Export session
        guard let exportSession = AVAssetExportSession(asset: avAsset, presetName: AVAssetExportPresetPassthrough) else {
            completionHandler?(nil, nil)
            return
        }
            
        //Creating temp path to save the converted video
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] as URL
        let filePath = documentsDirectory.appendingPathComponent("\(Date().currentTimeMillis())-rendered-Video.mp4")
            
        //Check if the file already exists then remove the previous file
        if FileManager.default.fileExists(atPath: filePath.path) {
            do {
                try FileManager.default.removeItem(at: filePath)
            } catch {
                completionHandler?(nil, error)
            }
        }
        exportSession.outputURL = filePath
        exportSession.outputFileType = AVFileType.mp4
        exportSession.shouldOptimizeForNetworkUse = true
        let start = CMTimeMakeWithSeconds(0.0, preferredTimescale: 0)
        let range = CMTimeRangeMake(start: start, duration: avAsset.duration)
        exportSession.timeRange = range
            
        exportSession.exportAsynchronously(completionHandler: {() -> Void in
            switch exportSession.status {
            case .failed:
                print(exportSession.error ?? "NO ERROR")
                completionHandler?(nil, exportSession.error)
            case .cancelled:
                print("Export canceled")
                completionHandler?(nil, nil)
            case .completed:
                //Video conversion finished
                let endDate = Date()
                    
                let time = endDate.timeIntervalSince(startDate)
                print(time)
                print("Successful!")
                print(exportSession.outputURL ?? "NO OUTPUT URL")
                completionHandler?(exportSession.outputURL, nil)
                    
                default: break
            }
                
        })
    }
}
extension TrimerViewController:TrimmerViewDelegate {
    func didChangePositionBar(_ playerTime: CMTime) {
        timeLabel.text = playerTime.positionalTime
        player?.seek(to: playerTime, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
        player?.play()
        startPlaybackTimeChecker()
        let second = playerTime.seconds
        let maxSeconds = Asset?.duration.seconds ?? 0.0
        let maxX = Double(trimmerView.frame.width)
        let newX = (maxX*second)/maxSeconds
        ChangeTimeLablePostion(x: CGFloat(newX))
    }
    
    func positionBarStoppedMoving(_ playerTime: CMTime) {
        stopPlaybackTimeChecker()
        player?.pause()
        player?.seek(to: playerTime, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
        let _ = (trimmerView.endTime! - trimmerView.startTime!).seconds
        let time = Int(self.trimmerView.endTime!.seconds) + Int(self.trimmerView.startTime!.seconds)
        self.playWithTrimed = true
        self.playerTotelTime = time
        self.playerStartingTime = Int(self.trimmerView.startTime!.seconds)
        self.playerEndingTime = Int(self.trimmerView.endTime!.seconds)
        print("------------\(time)")
    }
    
}
