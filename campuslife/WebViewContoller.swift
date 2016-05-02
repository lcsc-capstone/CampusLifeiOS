//
//  WebViewContoller.swift
//  LCSC
//
//  Created by Eric de Baere Grassl on 4/18/16.
//  Copyright © 2016 LCSC. All rights reserved.
//

import UIKit


//This class is responsible for the webView used to some of the itens in the menu
class WebViewContoller: UIViewController, UIWebViewDelegate {
   
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var webViewWindow: UIWebView!

    //Load the main Apps's main page when this button is touched
    func bttnTouched(sender: UIBarButtonItem){
        self.performSegueWithIdentifier("backToMenu", sender: nil)
    }
    
    
    //opens an App's with an deeplink as paramenter
    func openAppDeepLink(deepLinkString: String){
        let appURL = NSURL(string: deepLinkString)
        if UIApplication.sharedApplication().canOpenURL(appURL!){
            UIApplication.sharedApplication().openURL(appURL!)
        } else {
            UIApplication.sharedApplication().openURL(NSURL(string: "https://itunes.apple.com/us/app/gmail-email-from-google/id422689480?mt=8")!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleImage = UIImage(named: "Wordmark-Blue-Red-1")
        let go: UIButton = UIButton(frame: CGRectMake(0,0,150, 25))
        go.setImage(titleImage, forState: .Normal)
        go.addTarget(self, action: #selector(WebViewContoller.bttnTouched(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.navigationItem.titleView = go
        //menu button, tap and pan gestures functionalities
        menuButton.target = revealViewController()
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        //opens apps or an URL according to the view's tittle
        var urlText = ""
        let title = self.navigationController!.title!
        switch title{
            case "LCSC": urlText = "http://www.lcsc.edu"
            case "Hangouts": urlText = "https://hangouts.google.com"
            case "Athletics": urlText = "http://www.lcwarriors.com"
            case "WarriorWeb": urlText = "https://warriorwebss.lcsc.edu/Student/Account/Login?ReturnUrl=%2fStudent%2fPlanning%2fDegreePlans"
            case "LCMail": openAppDeepLink("googlegmail://")
            case "BlackBoard": urlText = "https://lcsc.blackboard.com/"
            case "Twitter": urlText = "http://twitter.com/LCSC"
            case "Radio": urlText = "http://stream.lcsc.edu/iphone.htm"
            case "LiveStream": urlText = "http://livestream.com/accounts/8399277"
            case "Facebook": urlText = "https://www.facebook.com/LewisClarkState"
            case "Instagram": urlText = "https://www.instagram.com/lewisclarkstate/?hl=en"
            case "WarriorOne Card": urlText = "http://connect.lcsc.edu/ecc/warrioronecard.aspx"
            case "Campus News": urlText = "http://www.lcsc.edu/news"
            default: return
        }
        
        
        //fix issue with LCSC's radio page that loads the page too small
        if title != "Radio"{
            webViewWindow.scalesPageToFit = true
        }
        
        
        //opens URL in webview
        webViewWindow?.delegate = self
        let url = NSURL(string: urlText)
        let request = NSURLRequest(URL: url!)
        webViewWindow?.loadRequest(request)
        //returns the app to the home view in case the operation called is "Hangouts" or "LCMail"
       if title == "Hangouts" || title == "LCMail"{
            performSegueWithIdentifier("backToMenu", sender: self)
        }
    }
    
    
    
    func webViewDidFinishLoad(webView: UIWebView) {
        //runs an script according to the url
        let script = ScriptWebView()
        let currentURL = (webView.request?.URL!.absoluteString)!
       webView.stringByEvaluatingJavaScriptFromString(script.getScript(currentURL))
    }
}
