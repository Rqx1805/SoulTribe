//
//  CustomOverlayView.swift
//  Koloda
//
//  Created by Eugene Andreyev on 7/27/15.
//  Copyright (c) 2015 CocoaPods. All rights reserved.
//

import UIKit
import Koloda

private let overlayRightImageName = "overlay_like"
private let overlayLeftImageName = "overlay_skip"

class CustomOverlayView: OverlayView {

    @IBOutlet lazy var overlayImageView: UIImageView! = {
        [unowned self] in
        
        var imageView = UIImageView(frame: self.bounds)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        self.addSubview(imageView)
        
        return imageView
        }()
    
    @IBOutlet weak var swipeLbl: UILabel!
        
    @IBOutlet weak var imagSpark: UIImageView!{
        didSet{
            let imageView = UIImageView()
            imageView.frame = CGRect(x: overlayImageView.frame.width/2 - 15, y: overlayImageView.frame.height/2 - 15, width: 30, height: 30)
            imageView.contentMode = .scaleAspectFit
            self.addSubview(imageView)
        }
    }
//    @IBOutlet lazy var sparkImageView1: UIImageView! = {
//        [unowned self] in
//
//
//
//        return imageView
//        }()
    
    override var overlayState: SwipeResultDirection?  {
        didSet {
            switch overlayState {
            case .left? :
                imagSpark.image = UIImage(named: "Icon material-close")
                swipeLbl.text = ""
                overlayImageView.image = UIImage(named: overlayLeftImageName)
            case .right? :
                if SELECT_VIBE == "Tribe" {
                    swipeLbl.text = "Vibe!"
                    imagSpark.image = UIImage(named: "swipeVibe")
                }else{
                    swipeLbl.text = "Spark!"
                    imagSpark.image = UIImage(named: "swipeSpart")
                }
                overlayImageView.image = UIImage(named: overlayRightImageName)
            default:
                overlayImageView.image = nil
            }
            
        }
    }

}
