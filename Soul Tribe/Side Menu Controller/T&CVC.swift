//
//  T&CVC.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 11/06/21.
//

import UIKit
import WebKit

class T_CVC: UIViewController,WKNavigationDelegate {
    @IBOutlet weak var headerview: UIView!
    var leftDrawerTransition:DrawerTransition!
    var left = LeftMenuViewController()

    @IBOutlet weak var Activity: UIActivityIndicatorView!
    @IBOutlet weak var web_View: WKWebView!
    var typeL = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
          headerview.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
          headerview.layer.shadowOpacity = 0.5
          headerview.layer.shadowOffset = .zero
          headerview.layer.shadowRadius = 5
        if typeL == "privacy" {
            let url = URL(string: "https://soultribenow.com/privacy-policy")
            let request = URLRequest(url: url!)
            self.Activity.startAnimating()
            self.Activity.hidesWhenStopped = true
            self.web_View.navigationDelegate = self
            web_View.load(request)
        }else{
            let url = URL(string: "https://soultribenow.com/terms")
            let request = URLRequest(url: url!)
            self.Activity.startAnimating()
            self.Activity.hidesWhenStopped = true
            self.web_View.navigationDelegate = self
            web_View.load(request)
        }
        
    }
    @IBAction func trems(_ sender:UIButton) {
        let url = URL(string: "https://soultribenow.com/terms")
        let request = URLRequest(url: url!)
        self.Activity.startAnimating()
        self.Activity.hidesWhenStopped = true
        self.web_View.navigationDelegate = self
        web_View.load(request)
    }
    @IBAction func Privacy(_ sender:UIButton) {
        let url = URL(string: "https://soultribenow.com/privacy-policy")
        let request = URLRequest(url: url!)
        self.Activity.startAnimating()
        self.Activity.hidesWhenStopped = true
        self.web_View.navigationDelegate = self
        web_View.load(request)
    }
    @IBAction func backbtnaction(_ sender:UIButton) {
        self.slideMenuController()?.toggleLeft()
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        Activity.stopAnimating()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        Activity.stopAnimating()
    }

}
