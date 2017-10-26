//
//  APIController.swift
//  Swify-Companion
//
//  Created by Julien MORI on 4/24/17.
//  Copyright © 2017 Julien MORI. All rights reserved.
//

import Foundation
import UIKit

class APIController {
    
    var dictio:NSDictionary?
    var profil_pic:String?
    var cursus_users:NSArray?
    var skills:NSArray?
    var lvl:String?
    var correction_point:String?
    var wallet:String?
    
    init () {
        print("dans le init")
    }
    
    func getUserInfo(token: String, login: String) -> NSDictionary {
        let url = NSURL(string: "https://api.intra.42.fr/v2/users/\(login)/?access_token=\(token)")
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "GET"
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        self.dictio = [:];
        let task =  URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            print(response!)
            if error != nil {
                print(error!)
            }
            else if let d = data {
                do {
                    if let dic : NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        self.dictio = dic
                        print(dic)
                    }
                }
                catch (let err) {
                    print(err)
                }
            }
        }
        task.resume()
        return dictio!
    }
    
    func recupInfo() {
        while (self.dictio == [:]) {}
        self.profil_pic = self.dictio?["image_url"] as? String
        self.cursus_users = self.dictio?["cursus_users"] as! NSArray
        print("start")
        var cursus = self.cursus_users![0] as! NSDictionary
        print(cursus)
        print(self.dictio?["correction_point"] as! Int)
        self.correction_point = String(describing: self.dictio?["correction_point"] as! Int)
        self.wallet = String(describing: self.dictio?["wallet"] as! Int)
        self.lvl = String(describing: cursus["level"]!)
        self.skills = cursus["skills"] as! NSArray
        print("prout")
        print(self.skills!)
    }
}
