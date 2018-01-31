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
    func pinchedView(_ sender:UIPinchGestureRecognizer){
        self.view.bringSubview(toFront: pinchView)
        sender.view!.transform = sender.view!.transform.scaledBy(x: sender.scale, y: sender.scale)
        sender.scale = 1.0
    }
    
    func draggedView(_ sender:UIPanGestureRecognizer){
        self.view!.bringSubview(toFront: sender.view!)
        let translation = sender.translation(in: self.view)
        sender.view!.center = CGPoint(x: sender.view!.center.x + translation.x, y: sender.view!.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    func bttnTouched(_ sender: UIBarButtonItem){
        self.performSegue(withIdentifier: "mapBackToMenu", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleImage = UIImage(named: "Wordmark-Blue-Red-1")
        let go: UIButton = UIButton(frame: CGRect(x: 0,y: 0,width: 150, height: 25))
        go.setImage(titleImage, for: UIControlState())
        go.addTarget(self, action: #selector(WebViewContoller.bttnTouched(_:)), for: UIControlEvents.touchUpInside)
        
        self.navigationItem.titleView = go
        //my code :)
        //loads the slide menu function
        menuButton.target = revealViewController()
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        panRec.addTarget(self, action: #selector(MapViewController.draggedView(_:)))
        panView.addGestureRecognizer(panRec)
        panView.isUserInteractionEnabled = true
        pinchRec.addTarget(self, action: #selector(MapViewController.pinchedView(_:)))
        pinchView.addGestureRecognizer(pinchRec)
        pinchView.isUserInteractionEnabled = true
        pinchView.isMultipleTouchEnabled = true
        //imageView.image = UIImage(contentsOfFile: "CampusMap")
    }
}
