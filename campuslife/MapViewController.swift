//
//  MapViewController.swift
//  LCSC
//
//  Created by Eric de Baere Grassl on 3/16/16.
//  Copyright © 2016 LCSC. All rights reserved.
//

import UIKit

//map view
class MapViewController: UIViewController {
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var pinchView: UIView!
    @IBOutlet var panView: UIView!
    
    let pinchRec = UIPinchGestureRecognizer()
    let panRec = UIPanGestureRecognizer()
    func pinchedView(sender:UIPinchGestureRecognizer){
        self.view.bringSubviewToFront(pinchView)
        sender.view!.transform = CGAffineTransformScale(sender.view!.transform, sender.scale, sender.scale)
        sender.scale = 1.0
    }
    
    func draggedView(sender:UIPanGestureRecognizer){
        self.view!.bringSubviewToFront(sender.view!)
        let translation = sender.translationInView(self.view)
        sender.view!.center = CGPointMake(sender.view!.center.x + translation.x, sender.view!.center.y + translation.y)
        sender.setTranslation(CGPointZero, inView: self.view)
    }
    func bttnTouched(sender: UIBarButtonItem){
        self.performSegueWithIdentifier("mapBackToMenu", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleImage = UIImage(named: "Wordmark-Blue-Red-1")
        let go: UIButton = UIButton(frame: CGRectMake(0,0,150, 25))
        go.setImage(titleImage, forState: .Normal)
        go.addTarget(self, action: #selector(WebViewContoller.bttnTouched(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.navigationItem.titleView = go
        //my code :)
        //loads the slide menu function
        menuButton.target = revealViewController()
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        panRec.addTarget(self, action: "draggedView:")
        panView.addGestureRecognizer(panRec)
        panView.userInteractionEnabled = true
        pinchRec.addTarget(self, action: #selector(MapViewController.pinchedView(_:)))
        pinchView.addGestureRecognizer(pinchRec)
        pinchView.userInteractionEnabled = true
        pinchView.multipleTouchEnabled = true
        //imageView.image = UIImage(contentsOfFile: "CampusMap")
    }
}
