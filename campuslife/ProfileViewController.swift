//
//  ProfileViewController.swift
//  LCSC
//
//  Created by Eric de Baere Grassl on 3/23/16.
//  Copyright © 2016 LCSC. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate, ImageCropViewControllerDelegate {
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var imageView: UIImageView!
    var imagePicker: UIImagePickerController!
    let auth = Authentication()
    
    
    
    @IBAction func cameraButtonTapped(_ sender: UIBarButtonItem) {
        initImageCropping()
    }
    
    
    @IBAction func takeAPictureTapped(_ sender: UIButton) {
        initImageCropping()
    }
    
    func initImageCropping(){
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present((imagePicker), animated: true, completion: nil)

    }
    
    func promptAlet(_ title: String, message: String){
        let alert:UIAlertView = UIAlertView()
        alert.title = title
        alert.message = message
        alert.delegate = self
        alert.addButton(withTitle: "Ok")
        alert.show()
    }
    
    //save the card image
    func saveImage(_ image: UIImage){
        UserDefaults.standard.set(UIImageJPEGRepresentation(image,1), forKey: "card")
        UserDefaults.standard.synchronize()
    }
    
    //allows the user to crop the image
    func imageCropViewControllerSuccess(_ controller: UIViewController!, didFinishCroppingImage croppedImage: UIImage!) {
        saveImage(croppedImage)
        promptAlet("Success!", message: "Your card picture was saved.")
        checkAndLoadCardPicture()
        navigationController?.popViewController(animated: true)
    }
    
    
    func imageCropViewControllerDidCancel(_ controller: UIViewController!) {
        navigationController?.popViewController(animated: true)
    }
    
    //saves the photo taken by the user
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        let image = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
        saveImage(image)
        checkAndLoadCardPicture()
        let controller = ImageCropViewController(image: image)
        controller?.delegate = self
        navigationController?.pushViewController(controller!, animated: true)
    }
    
    //load the card image in case it exists
    func checkAndLoadCardPicture(){
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        if let imageToLoad = UserDefaults.standard.object(forKey: "card"){
            imageView.image = UIImage(data: imageToLoad as! Data)
        } else {
            imageView.image = UIImage(named: "squirrelCard")
            if !auth.userHaveEverBeenAtProfilePage(){
                promptAlet("No card picture is registered!", message: "You can register your card picture by tapping the camera button.")
                auth.setUserHaveEverBeenAtProfilePage(true)
            }
        }
    }
    func bttnTouched(_ sender: UIBarButtonItem){
        self.performSegue(withIdentifier: "profileBackToMenu", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleImage = UIImage(named: "Wordmark-Blue-Red-1")
        let go: UIButton = UIButton(frame: CGRect(x: 0,y: 0,width: 150, height: 25))
        go.setImage(titleImage, for: UIControlState())
        go.addTarget(self, action: #selector(WebViewContoller.bttnTouched(_:)), for: UIControlEvents.touchUpInside)
        
        self.navigationItem.titleView = go
        //my code :)
        menuButton.target = revealViewController()
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 2.0
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundCollor")!)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        checkAndLoadCardPicture()
    }
}
