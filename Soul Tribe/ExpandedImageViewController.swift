//
//  ExpandedImageViewController.swift
//  Soul Tribe
//
//  Created by MAC-30 on 29/11/21.
//ExpandedImageViewController

import UIKit

class ExpandedImageViewController: UIViewController , UIScrollViewDelegate{

    var imageView: UIImageView!
    var scrollImg: UIScrollView!
    
    
    var urlStr = String()
    var myUrl : URL?
    
    
    var shouldPrefix = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        NotificationCenter.default.post(name: NSNotification.Name("ShowButton"), object: nil)
 
        let vWidth = UIScreen.main.bounds.width
        let vHeight = UIScreen.main.bounds.height

        scrollImg = UIScrollView()
        scrollImg.delegate = self
        scrollImg.frame = CGRect(x: 10, y: 100, width: vWidth - 20, height: vHeight - 40)
        scrollImg.backgroundColor = UIColor.clear
        scrollImg.alwaysBounceVertical = false
        scrollImg.alwaysBounceHorizontal = false
        scrollImg.showsVerticalScrollIndicator = true
        scrollImg.showsHorizontalScrollIndicator = true
        scrollImg.flashScrollIndicators()

        scrollImg.minimumZoomScale = 1.0
        scrollImg.maximumZoomScale = 10.0

        let doubleTapGest = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTapScrollView(recognizer:)))
        doubleTapGest.numberOfTapsRequired = 2
        scrollImg.addGestureRecognizer(doubleTapGest)

        self.view.addSubview(scrollImg)

//        if modelName == "iPhone 4s" || modelName == "iPhone 5" || modelName == "iPhone 5c" || modelName == "iPhone 5s" || modelName == "iPhone 6" || modelName == "iPhone 6 Plus" || modelName == "iPhone 6s" || modelName == "iPhone 6s Plus" || modelName == "iPhone SE" || modelName == "iPhone 7" || modelName == "iPhone 7 Plus" || modelName == "iPhone 8" || modelName == "iPhone 8 Plus" || modelName == "Simulator iPhone 8" {
//            imageView = UIImageView(frame: CGRect(x: 0, y: -60, width: vWidth, height: vHeight))
//        }
//        else {
        imageView = UIImageView(frame: CGRect(x: 0, y: -50, width: scrollImg.frame.size.width, height: scrollImg.frame.size.height))
        
        
        if shouldPrefix == true{
                   myUrl = URL(string: "\(Config().baseImageUrl)\(urlStr)")
              }else{
                   myUrl = URL(string: "\(urlStr)")
              }
              
        imageView.sd_setImage(with: myUrl, completed: nil)
            imageView.contentMode = .scaleAspectFit
            scrollImg.addSubview(imageView!)
        }
    @objc func handleDoubleTapScrollView(recognizer: UITapGestureRecognizer) {
        if scrollImg.zoomScale == 1 {
            scrollImg.zoom(to: zoomRectForScale(scale: scrollImg.maximumZoomScale, center: recognizer.location(in: recognizer.view)), animated: true)
        } else {
            scrollImg.setZoomScale(1, animated: true)
        }
    }

    func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = imageView.frame.size.height / scale
        zoomRect.size.width  = imageView.frame.size.width  / scale
        let newCenter = imageView.convert(center, from: scrollImg)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
       
//        if urlStr != nil {
//            imageView.sd_setImage(with: urlStr!, placeholderImage: UIImage(named: "uploadProgress"), options:  [], completed:nil)
//        }else {
//            imageView.image = img
//        }
//
    
    
    @IBAction func popUp_CancelAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
        // Do any additional setup after loading the view.
    }
    
  


