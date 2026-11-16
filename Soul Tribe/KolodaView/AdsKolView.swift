//
//  AdsKolView.swift
//  Soul Tribe
//
//  Created by MAC-30 on 24/01/22.
//

import UIKit

class AdsKolView: UIView {

    @IBOutlet weak var adsImageView: MyImageView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var mainView: MyView!
    @IBOutlet var descriptionView: MyView!
    @IBOutlet var descriptionLbl: UILabel!
   // @IBOutlet var readMore: UIButton!
    @IBOutlet var rightSwipe: UIButton!
    @IBOutlet var leftSwipe: UIButton!
    @IBOutlet var learnMoreBtn: UIButton!
   // @IBOutlet var readMoreBtnHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var adstitleLbl:UILabel!
    override init(frame: CGRect) {
        super.init(frame : frame)
        
//        NotificationCenter.default.addObserver(self, selector: #selector(chnageImgSoul(_:)), name: Notification.Name("changeImgSoulLoveBtn"), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(chnageImgTribe(_:)), name: Notification.Name("changeImgTribeBtn"), object: nil)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder : aDecoder)
        commonInit()
    }
    private func commonInit() {
        Bundle.main.loadNibNamed("AdsKolView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.layer.cornerRadius = 20
        adsImageView.layer.cornerRadius = 20
        mainView.layer.cornerRadius = 20
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
}
