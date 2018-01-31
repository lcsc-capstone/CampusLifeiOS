//
//  Authentication.swift
//  LCSC
//
//  Created by Eric de Baere Grassl on 2/29/16.
//  Copyright © 2016 LCSC. All rights reserved.
//

import UIKit


//saves the user username and password
@objc class Authentication: NSObject {
    
    fileprivate var prefs = UserDefaults.standard
    override init(){
        super.init()
        //initializing data in case it is nil
        if (((prefs.string(forKey: "wwlogin") == nil || prefs.string(forKey: "wwpassword") == nil || prefs.string(forKey: "bblogin") == nil || prefs.string(forKey: "bbpassword") == nil)) || (prefs.string(forKey: "lcmlogin") == nil) || (prefs.string(forKey: "lcmpassword")) == nil){
            clearProfile()
        }
        if (prefs.string(forKey: "userHaveEverBeenAtResourcesPage") == nil){
            prefs.set(false, forKey: "userHaveEverBeenAtResourcesPage")
        }
        if (prefs.string(forKey: "userHaveEverBeenAtProfilePage") == nil){
            prefs.set(false, forKey: "userHaveEverBeenAtProfilePage")
        }
        prefs.synchronize()
    }
    
    func clearProfile(){
        clearWarriorWebProfile()
        clearBlackBoardProfile()
        clearLCMailProfile()
    }
    
    func clearWarriorWebProfile(){
        prefs.set("", forKey: "wwlogin")
        prefs.set("", forKey: "wwpassword")
        prefs.synchronize()
    }
    
    func clearBlackBoardProfile(){
        prefs.set("", forKey: "bblogin")
        prefs.set("", forKey: "bbpassword")
        prefs.synchronize()
    }
    
    func clearLCMailProfile(){
        prefs.set("", forKey: "lcmlogin")
        prefs.set("", forKey: "lcmpassword")
        prefs.synchronize()
    }
    
    //function to avoid showingt he alert in resources table more than once
    func userHaveEverBeenAtResourcesPage() -> Bool{
        let bool = prefs.bool(forKey: "userHaveEverBeenAtResourcesPage")
        return bool
    }
    
    
    func setUserHaveEverBeenAtResourcesPage(_ bool: Bool){
        prefs.set(bool, forKey: "userHaveEverBeenAtResourcesPage")
        prefs.synchronize()
    }
    
    func setUserHaveEverBeenAtProfilePage(_ bool: Bool){
        prefs.set(bool, forKey: "userHaveEverBeenAtProfilePage")
        prefs.synchronize()
    }
    
    func userHaveEverBeenAtProfilePage() -> Bool{
        let bool = prefs.bool(forKey: "userHaveEverBeenAtProfilePage")
        return bool
    }
    
    //save your data acording to the profile destination and returns a bool representing if it was successfull operation or not
    func setProfile(_ destination: String, newLogin: String?, newPassword: String?) -> Bool{
        if destination == "warriorweb"{
            if (newLogin != ""){
                if (newPassword != ""){
                    prefs.set(newLogin!, forKey: "wwlogin")
                    prefs.set(newPassword!, forKey: "wwpassword")
                    prefs.synchronize()
                    return true
                }
            }
        }else if destination == "blackboard"{
            if (newLogin != ""){
                if (newPassword != ""){
                    prefs.set(newLogin!, forKey: "bblogin")
                    prefs.set(newPassword!, forKey: "bbpassword")
                    prefs.synchronize()
                    return true
                }
            }
        }
        return false
    }
    
    
    //gets
    func getWarriorWebUsername() -> String{
        return prefs.string(forKey: "wwlogin")!
    }
    
    func getWarriorWebPassword() -> String{
        return prefs.string(forKey: "wwpassword")!
    }
    
    func getBlackBoardUsername() -> String{
        return prefs.string(forKey: "bblogin")!
    }
    
    func getBlackBoardPassword() -> String{
        return prefs.string(forKey: "bbpassword")!
    }
    
}

