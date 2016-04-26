//
//  WebViewContoller.swift
//  LCSC
//
//  Created by Eric de Baere Grassl on 4/18/16.
//  Copyright © 2016 LCSC. All rights reserved.
//

import UIKit

class WebViewContoller: UIViewController, UIWebViewDelegate {
   
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    
    @IBOutlet weak var webViewWindow: UIWebView!

    func bttnTouched(sender: UIBarButtonItem){
        self.performSegueWithIdentifier("backToMenu", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleImage = UIImage(named: "Wordmark-Blue-Red-1")
        let go: UIButton = UIButton(frame: CGRectMake(0,0,150, 25))
        go.setImage(titleImage, forState: .Normal)
        go.addTarget(self, action: #selector(WebViewContoller.bttnTouched(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.navigationItem.titleView = go
        menuButton.target = revealViewController()
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        var urlText = ""
        let title = self.navigationController!.title!
        switch title{
            case "LCSC": urlText = "http://www.lcsc.edu"
            case "Hangouts": urlText = "https://hangouts.google.com"
            case "Athletics": urlText = "http://www.lcwarriors.com"
            case "WarriorWeb": urlText = "https://warriorwebss.lcsc.edu/Student/Account/Login?ReturnUrl=%2fStudent%2fPlanning%2fDegreePlans"
            case "LCMail": urlText = "http://mail.google.com/a/lcmail.lcsc.edu"
            case "BlackBoard": urlText = "https://lcsc.blackboard.com/"
            case "Twitter": urlText = "http://twitter.com/LCSC"
            case "Radio": urlText = "http://stream.lcsc.edu/iphone.htm"
            case "LiveStream": urlText = "http://livestream.com/accounts/8399277"
            case "Facebook": urlText = "https://www.facebook.com/LewisClarkState"
            case "Instagram": urlText = "https://www.instagram.com/lewisclarkstate/?hl=en"
            default: return
        }
        
        if title != "Radio"{
            webViewWindow.scalesPageToFit = true
        }
        
        webViewWindow?.delegate = self
        let url = NSURL(string: urlText)
        let request = NSURLRequest(URL: url!)
        webViewWindow?.loadRequest(request)
       if title == "Hangouts"{
        performSegueWithIdentifier("backToMenu", sender: self)
        }
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        let script = ScriptWebView()
        let currentURL = (webView.request?.URL!.absoluteString)!
       webView.stringByEvaluatingJavaScriptFromString(script.getScript(currentURL))
    }
}
